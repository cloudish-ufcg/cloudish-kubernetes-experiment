package main

import (
	"context"
	"encoding/csv"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	//"os"
	"strconv"
	"strings"
	"sync"
	"time"
	"crypto/rand"

	"github.com/golang/glog"
	"github.com/prometheus/client_golang/api"
	promApi "github.com/prometheus/client_golang/api/prometheus/v1"
	"github.com/prometheus/common/model"


	_ "k8s.io/client-go/plugin/pkg/client/auth/gcp"
        "k8s.io/client-go/tools/clientcmd"
        metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
        "k8s.io/client-go/kubernetes"
	appsv1beta2 "k8s.io/api/apps/v1beta2"

	"k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/resource"
)

func GetKubeClient(confPath string) (*kubernetes.Clientset) {

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


var (
	wg sync.WaitGroup

	/*cfg = api.Config{
		Address:      os.Getenv("PROM_ADDRESS"),
		RoundTripper: api.DefaultRoundTripper,
	}*/

	cfg = api.Config{
                Address:      "http://10.11.4.122:32409",
                RoundTripper: api.DefaultRoundTripper,
        }


	acc_runtime, act_runtime int

	promClient, _ = api.NewClient(cfg)
	newApi        = promApi.NewAPI(promClient)
	layout        = "2006-01-02 15:04:05 +0000 UTC"

	replicas = int32(1)

	clientset = GetKubeClient("/root/admin.conf")
)


func main() {

	var time_ref = 0
	file, err := ioutil.ReadFile("input.example2")

	if err == nil {

		r := csv.NewReader(strings.NewReader(string(file)))

		for {

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

				//controller_name := string(record[1]) + "-" + string(record[2])
				controller_name := tokenGenerator()
				expectedRuntime, _ := strconv.Atoi(string(record[6]))

				deployment := getDeploymentSpec(controller_name, cpuReq, memReq, slo)
				fmt.Println("Reading new task...")
				fmt.Println("Deployment %v, cpu: %v, mem: %v", "slo: %v", controller_name, cpuReq, memReq, slo)

				if timestamp == time_ref {
					fmt.Println("Time: ", timestamp)
					fmt.Println("Creating deployment ", controller_name)
					clientset.AppsV1beta2().Deployments("default").Create(deployment)
					
					go manageControllerTermination(controller_name, expectedRuntime, &wg)

				} else {
					wait_time := int(timestamp - time_ref)
					time_ref = timestamp
					fmt.Println("")
					time.Sleep(time.Duration(wait_time) * time.Second)
					fmt.Println("Time: ", timestamp)
					fmt.Println("Creating deployment ", controller_name)
					clientset.AppsV1beta2().Deployments("default").Create(deployment)
					go manageControllerTermination(controller_name, expectedRuntime, &wg)
				}

			}
		}
	}

	// TODO wait the experiment timeout and terminate all controllers
	wg.Wait()
	fmt.Println("Finished")
}

func manageControllerTermination(controllerName string, expectedRuntime int, wg *sync.WaitGroup) {
	wg.Add(1)

	for {
		runtime := getControllerRuntime(controllerName, time.Now().UTC())
		if runtime >= expectedRuntime {
			wg.Done()
			fmt.Println("Deployment achieved runtime. Deleting...", controllerName)
			clientset.AppsV1beta2().Deployments("default").Delete(controllerName, &metav1.DeleteOptions{})
			break
		} else {

			time.Sleep(1 * time.Second)
			fmt.Println("running", controllerName, runtime, expectedRuntime)
		}
	}
}

func getControllerRuntime(controllerRefName string, timestampRef time.Time) int {

	acc_runtime = 0
	act_runtime = 0
	query := `running_time{controller="` + controllerRefName + `"}`
	result, _ := newApi.Query(context.Background(), query, timestampRef)
	vectorVal := result.(model.Vector)

	if len(vectorVal) == 0 {
		return 0
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

	return total_running_time
}

func getDeploymentSpec(controllerRefName string,
	cpuReq string, memReq string, slo string) (*appsv1beta2.Deployment){

	rl := v1.ResourceList{v1.ResourceName(v1.ResourceMemory): resource.MustParse("50Mi"),
		v1.ResourceName(v1.ResourceCPU): resource.MustParse("100m")}

	pod := v1.PodTemplateSpec{
		ObjectMeta: metav1.ObjectMeta{Labels: map[string]string{"app": "nginx"}, Annotations: map[string]string{"slo": slo}},
		Spec:       v1.PodSpec{Containers:
		[]v1.Container{{Name: controllerRefName,
						Image: "nginx",
						Resources: v1.ResourceRequirements{
							Limits: rl,
							Requests: rl,
			},}},
			PriorityClassName: "low-priority"},
	}

	deployment := &appsv1beta2.Deployment{
		ObjectMeta: metav1.ObjectMeta{Name: controllerRefName},
		Spec:       appsv1beta2.DeploymentSpec{Selector: &metav1.LabelSelector{MatchLabels: pod.Labels}, Replicas: &replicas, Template: pod},
	}


	return deployment

}
