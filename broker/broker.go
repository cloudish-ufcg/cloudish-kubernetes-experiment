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

	"github.com/golang/glog"
	"github.com/prometheus/client_golang/api"
	promApi "github.com/prometheus/client_golang/api/prometheus/v1"
	"github.com/prometheus/common/model"
)

var (
	wg sync.WaitGroup

	cfg = api.Config{
		Address:      os.Getenv("PROM_ADDRESS"),
		RoundTripper: api.DefaultRoundTripper,
	}

	acc_runtime, act_runtime int64

	promClient, _ = api.NewClient(cfg)
	newApi        = promApi.NewAPI(promClient)
	layout        = "2006-01-02 15:04:05 +0000 UTC"
)

func main() {

	var time_ref int = 0
	file, err := ioutil.ReadFile("input.example")

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

				controller_name := string(record[1]) + "_" + string(record[2])
				expectedRuntime, _ := strconv.Atoi(string(record[6]))

				// TODO call util func to create a yaml (a string) based on the controller name and requeriments

				if timestamp == time_ref {
					fmt.Println(timestamp, time_ref, controller_name, expectedRuntime)
					// TODO call kubernetes client to create the pod
					// TODO call a gorotine to manage the controller termination
					go manageControllerTermination(controller_name, expectedRuntime, &wg)
				} else {
					wait_time := int(timestamp - time_ref)
					time_ref = timestamp
					fmt.Println("")
					time.Sleep(time.Duration(wait_time) * time.Second)
					fmt.Println(timestamp, time_ref, controller_name, expectedRuntime)
					// TODO call kubernetes client to create the pod
					// TODO call a gorotine to manage the controller termination
					go manageControllerTermination(controller_name, expectedRuntime, &wg)
				}

			}
		}
	}

	// TODO wait the experiment timeout and terminate all controllers
	wg.Wait()
	fmt.Println("finished")
}

func manageControllerTermination(controllerName string, expectedRuntime int, wg *sync.WaitGroup) {
	wg.Add(1)
	runtime := 0
	for {
		//runtime += 1
		runtime := getControllerRuntime(controllerName, time.Now().UTC())
		if runtime >= expectedRuntime {
			wg.Done()
			fmt.Println("terminated", controllerName)
			// TODO terminate controller via kubernetes go-client
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
				act_runtime = act_runtime + int64(elapsedTime)
			} else {
				glog.V(1).Infof("killed:", string(elem.Metric["pod"]))
				acc_runtime = acc_runtime + int64(elem.Value)
			}
		}
	}

	total_running_time := int64(acc_runtime + act_runtime)

	return total_running_time
}
