package main

import (
	"context"
	"encoding/csv"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
	"crypto/rand"

	"github.com/golang/glog"
	"github.com/prometheus/client_golang/api"
	promApi "github.com/prometheus/client_golang/api/prometheus/v1"
	"github.com/prometheus/common/model"

	appsv1beta2 "k8s.io/api/apps/v1beta2"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	_ "k8s.io/client-go/plugin/pkg/client/auth/gcp"
	"k8s.io/client-go/tools/clientcmd"

	"k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/resource"

	"os/exec"
	"bufio"
)

func GetKubeClient(confPath string) *kubernetes.Clientset {

	loadingRules := &clientcmd.ClientConfigLoadingRules{ExplicitPath: confPath}
	loader := clientcmd.NewNonInteractiveDeferredLoadingClientConfig(loadingRules, &clientcmd.ConfigOverrides{})

	clientConfig, err := loader.ClientConfig()
	if err != nil {
		panic(err)
	}

	kubeclient, err := kubernetes.NewForConfig(clientConfig)
	if err != nil {
		panic(err)
	}
	return kubeclient
}

func tokenGenerator() string {
	b := make([]byte, 6)
	rand.Read(b)
	return fmt.Sprintf("%x", b)
}

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func dump(info, file string) {

        f, err := os.OpenFile(file, os.O_WRONLY|os.O_APPEND|os.O_CREATE, 0644)
        check(err)
        defer f.Close()

        w := bufio.NewWriter(f)

        w.WriteString(info)
        w.Flush()
}

var (
	wg sync.WaitGroup

	acc_runtime, act_runtime int

	cfg = api.Config{
    Address:      "http://10.108.236.26:9090",
    RoundTripper: api.DefaultRoundTripper,
  }

	promClient, _ = api.NewClient(cfg)
	newApi        = promApi.NewAPI(promClient)

	replicas = int32(1)

	numberOfRetries = 0
	defaultTimeToSleep = 5
	layout    = "2006-01-02 15:04:05 +0000 UTC"
	clientset = GetKubeClient("/root/admin.conf")
)

func main() {

	start := time.Now()
	argsWithoutProg := os.Args[1:]

	inputFile := string(argsWithoutProg[0])

	var time_ref = 0
	file, err := ioutil.ReadFile(inputFile)

	if err == nil {

		r := csv.NewReader(strings.NewReader(string(file)))

		for {

			//time.Sleep(time.Duration(0.5) * time.Second)
			time.Sleep(time.Duration(500) * time.Millisecond)
			record, err := r.Read()

			if err == io.EOF {
				break
			}
			if err != nil {
				log.Fatal(err)
			}

			if string(record[1]) != "jid" {

				timestamp, _ := strconv.Atoi(string(record[0]))
				slo := string(record[11])
				cpuReq := string(record[8])
				memReq := string(record[9])
				task_id := string(record[1])
				class := string(record[10])

				//controller_name := string(record[1]) + "-" + string(record[2])
				controller_name := class + "-" + task_id + "-" + tokenGenerator()
				//expectedRuntime, _ := strconv.Atoi(string(record[6]))

				expectedRuntime := 150
	      dump(controller_name + "\n", "controllers.csv")

				deployment := getDeploymentSpec(controller_name, cpuReq, memReq, slo)

				fmt.Println("Reading new task...")
				fmt.Println("Deployment %v, cpu: %v, mem: %v", "slo: %v", controller_name, cpuReq, memReq, slo)

				if timestamp == time_ref {
					fmt.Println("Time: ", timestamp)
					fmt.Println("Creating deployment ", controller_name)
					clientset.AppsV1beta2().Deployments("default").Create(deployment)
					wg.Add(1)
					go manageControllerTermination(controller_name, expectedRuntime, &wg, numberOfRetries)

				} else {
					wait_time := int(timestamp - time_ref)
					time_ref = timestamp
					fmt.Println("")
					time.Sleep(time.Duration(wait_time) * time.Second)
					fmt.Println("Time: ", timestamp)
					fmt.Println("Creating deployment ", controller_name)
					clientset.AppsV1beta2().Deployments("default").Create(deployment)
					wg.Add(1)
					go manageControllerTermination(controller_name, expectedRuntime, &wg, numberOfRetries)
				}

			}
		}
	}

	// TODO wait the experiment timeout and terminate all controllers
	wg.Wait()

	elapsed := time.Since(start)
	fmt.Println("Finished - runtime: ", elapsed)
}

func manageControllerTermination(controllerName string, expectedRuntime int, wg *sync.WaitGroup, numberOfRetries int) {
//	wg.Add(1)
	var runtime = 0
	var waitTime = expectedRuntime - runtime
	for {

		if runtime >= expectedRuntime {
			fmt.Println("deleting", controllerName, runtime, expectedRuntime)
			out := fmt.Sprintf("%s %d %d\n", controllerName, runtime, expectedRuntime)
			dump(out, "/root/broker.log")
			fmt.Println("Deployment achieved runtime. Deleting...", controllerName)

			out = fmt.Sprintf("%s Deploy achieved runtime %d. Deleting...\n", controllerName, runtime)

			dump(out, "/root/broker.log")

			//clientset.AppsV1beta2().Deployments("default").Delete(controllerName, &metav1.DeleteOptions{})
			cmd := exec.Command("/usr/bin/kubectl", "delete", "deploy", controllerName)
			cmd.Run()
			wg.Done()
			break
		} else {
			time.Sleep(time.Duration(waitTime) * time.Second)
			fmt.Println("running", controllerName, runtime, expectedRuntime)
			out := fmt.Sprintf("%s %d %d %d\n", controllerName, runtime, expectedRuntime, waitTime)
                        dump(out, "/root/broker.log")
		}

		tmp_runtime, result := getControllerRuntime(controllerName, time.Now().UTC(), numberOfRetries)

		if (result == false){
			fmt.Println("Metric not found, waiting default time", controllerName)
			waitTime = defaultTimeToSleep
			out := fmt.Sprintf("%s Metric not found, waiting default time %d\n", controllerName, waitTime)
                        dump(out, "/root/broker.log")
		} else {
			runtime = tmp_runtime
			waitTime = expectedRuntime - runtime
			fmt.Println("Metric found, sleeping...", controllerName, waitTime)
			out := fmt.Sprintf("%s %s Metric found, running time: %d sleep time %d\n", time.Now().UTC(), controllerName, runtime, waitTime)
			dump(out, "/root/broker.log")
		}

	}
}

func getControllerRuntime(controllerRefName string, timestampRef time.Time, numberOfRetries int) (int, bool) {

	var acc_runtime = 0
	var act_runtime = 0
	var retries = 0
	var vectorVal model.Vector

	for len(vectorVal) == 0 && retries <= numberOfRetries {
		retries = retries + 1
		query := `running_time{controller="` + controllerRefName + `"}`
		result, _ := newApi.Query(context.Background(), query, timestampRef)
		vectorVal = result.(model.Vector)
	}

	if len(vectorVal) == 0 {
		return 0, false
	}

	for _, elem := range vectorVal {

		metric_name := elem.Metric["__name__"]
		glog.V(1).Infof("Metric name: ", metric_name)

		if metric_name == "running_time" {

			if elem.Metric["state"] == "running" {
				glog.V(1).Infof("running:", string(elem.Metric["pod"]))
				event_timestamp := string(elem.Metric["running_timestamp"])

				time_event, _ := time.Parse(layout, event_timestamp)
				time_ref, _ := time.Parse(layout, timestampRef.String())

				elapsedTime := time_ref.Sub(time_event).Seconds()
				act_runtime = act_runtime + int(elapsedTime)
			} else {
				glog.V(1).Infof("killed:", string(elem.Metric["pod"]))
				acc_runtime = acc_runtime + int(elem.Value)
			}
		}
	}

	total_running_time := int(acc_runtime + act_runtime)

	return total_running_time, true
}

func getDeploymentSpec(controllerRefName string,
	cpuReq string, memReq string, slo string) *appsv1beta2.Deployment {
	memReqFloat, _ := strconv.ParseFloat(memReq, 64)
	memReqKi := memReqFloat * 1000000
	memReqStr := strconv.FormatFloat(memReqKi, 'f', -1, 64)
	memRequest := memReqStr + "Ki"
	fmt.Println(memRequest)
	rl := v1.ResourceList{v1.ResourceName(v1.ResourceMemory): resource.MustParse(memRequest),
		v1.ResourceName(v1.ResourceCPU): resource.MustParse(cpuReq)}

	gracePeriod := int64(0)
	pod := v1.PodTemplateSpec{
		ObjectMeta: metav1.ObjectMeta{Labels: map[string]string{"app": "nginx"}, Annotations: map[string]string{"slo": slo, "controller": controllerRefName}},
		Spec: v1.PodSpec{
			TerminationGracePeriodSeconds: &gracePeriod,
			Containers: []v1.Container{{Name: controllerRefName,
				Image: "nginx",
				Resources: v1.ResourceRequirements{
					Limits:   rl,
					Requests: rl,
				}}},
			PriorityClassName: "low-priority"},
	}

	deployment := &appsv1beta2.Deployment{
		ObjectMeta: metav1.ObjectMeta{Name: controllerRefName},
		Spec:       appsv1beta2.DeploymentSpec{Selector: &metav1.LabelSelector{MatchLabels: pod.Labels}, Replicas: &replicas, Template: pod},
	}

	return deployment

}
