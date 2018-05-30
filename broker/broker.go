package main

import (
	"crypto/rand"
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

	appsv1beta2 "k8s.io/api/apps/v1beta2"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	_ "k8s.io/client-go/plugin/pkg/client/auth/gcp"
	"k8s.io/client-go/tools/clientcmd"

	"k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/resource"

	"bufio"
	"os/exec"
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
	//wg sync.WaitGroup

	replicas = int32(1)

	layout    = "2006-01-02 15:04:05 +0000 UTC"
	clientset = GetKubeClient("/root/admin.conf")
)

func main() {

	start := time.Now()
	argsWithoutProg := os.Args[1:]

	inputFile := string(argsWithoutProg[0])
	var experimentDurationInSeconds

	if (len(argsWithoutProg) > 1) {
		experimentDuration = time.Duration(argsWithoutProg[1]) * time.Second
	} else {
		experimentDuration = time.Duration(150) * time.Second
	}

	var timeRef = 0
	file, err := ioutil.ReadFile(inputFile)

	if err == nil {

		r := csv.NewReader(strings.NewReader(string(file)))

		for {

			//time.Sleep(time.Duration(0.5) * time.Second)
			//time.Sleep(time.Duration(500) * time.Millisecond)
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
				taskID := string(record[1])
				class := string(record[10])

				controlleName := class + "-" + taskID + "-" + tokenGenerator()

				dump(controlleName+"\n", "controllers.csv")

				deployment := getDeploymentSpec(controlleName, cpuReq, memReq, slo, class)

				fmt.Println("Reading new task...")
				fmt.Println("Deployment %s, cpu: %v, mem: %v", "slo: %s", controlleName, cpuReq, memReq, slo)

				if timestamp == timeRef {
					fmt.Println("Time: ", timestamp)
					fmt.Println("Creating deployment ", controlleName)
					clientset.AppsV1beta2().Deployments("default").Create(deployment)
					//wg.Add(1)
					//go manageControllerTermination(controlleName, expectedRuntime-timeRef, &wg)

				} else {
					waittime := int(timestamp - timeRef)
					timeRef = timestamp
					fmt.Println("")
					time.Sleep(time.Duration(waittime) * time.Second)
					fmt.Println("Time: ", timestamp)
					fmt.Println("Creating deployment ", controlleName)
					clientset.AppsV1beta2().Deployments("default").Create(deployment)
					//wg.Add(1)
					//go manageControllerTermination(controlleName, expectedRuntime-timeRef, &wg)
				}

			}
		}
	}

	manageControllerTermination(controlleName, expectedRuntime-timeRef, &wg)

	//wg.Wait()

	elapsed := time.Since(start)
	fmt.Println("Finished - runtime: ", elapsed)
}

func manageControllerTermination(experimentDuration Duration, wg *sync.WaitGroup) {

	time.Sleep(experimentDuration)

	fmt.Println("Killing all deployments after ", experimentDuration, seconds)
	out := fmt.Sprintf("Killing all deployments after %s", experimentDuration)
	dump(out, "/root/broker.log")

	//clientset.AppsV1beta2().Deployments("default").Delete(controllerName, &metav1.DeleteOptions{})
	cmd := exec.Command("/usr/bin/kubectl", "delete", "deploy", "--all")
	cmd.Run()

	//wg.Done()
}

func getDeploymentSpec(controllerRefName string,
	cpuReq string, memReq string, slo string, class string) *appsv1beta2.Deployment {
	memReqFloat, _ := strconv.ParseFloat(memReq, 64)
	memReqKi := memReqFloat * 1000000
	memReqStr := strconv.FormatFloat(memReqKi, 'f', -1, 64)
	memRequest := memReqStr + "Ki"
	fmt.Println(memRequest)
	rl := v1.ResourceList{v1.ResourceName(v1.ResourceMemory): resource.MustParse(memRequest),
		v1.ResourceName(v1.ResourceCPU): resource.MustParse(cpuReq)}

	priorityClass := class + "-priority"
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
			PriorityClassName: priorityClass},
	}

	deployment := &appsv1beta2.Deployment{
		ObjectMeta: metav1.ObjectMeta{Name: controllerRefName},
		Spec:       appsv1beta2.DeploymentSpec{Selector: &metav1.LabelSelector{MatchLabels: pod.Labels}, Replicas: &replicas, Template: pod},
	}

	return deployment
}
