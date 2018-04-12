// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
        "fmt"
        "time"
	//"strconv"
	"context"
	//"reflect"
	//"encoding/json"

        promApi "github.com/prometheus/client_golang/api/prometheus/v1"
        "github.com/prometheus/client_golang/api"

        "github.com/prometheus/common/model"
)

var (

	cfg = api.Config {
                Address: "http://10.11.4.122:31788",
                RoundTripper: api.DefaultRoundTripper,
        }

	acc_runtime, act_runtime, acc_waittime, act_waittime int64 = 0, 0, 0, 0
        n_running, n_waiting int = 0, 0
)

func main() {

        p := fmt.Println

        promClient, _ := api.NewClient(cfg)
        newApi := promApi.NewAPI(promClient)
        now := time.Now().UTC()
        controller_val := "nginx-003-fabio-65b4599bcc"
        timestamp_ref := time.Now().UTC()

	const layout string = "2006-01-02 15:04:05 +0000 UTC"

	query_runtime := `running_time{controller="` + controller_val + `"}`
        query_waittime2 := `waiting_time{controller="` + controller_val + `"}`
	query := query_runtime + " or " + query_waittime2
        result, _ := newApi.Query(context.Background(), query, now)
        vectorVal := result.(model.Vector)

	for _, elem := range vectorVal {
                //p(elem.Metric)
		//res2B, _ := json.Marshal(elem.Metric)
		//fmt.Println(string(res2B))

		metric_name := elem.Metric["__name__"]
	        p(metric_name)

		if metric_name == "running_time" {

			if elem.Metric["state"] == "running" {
				p("running:", string(elem.Metric["pod"]))
				n_running = n_running + 1

				event_timestamp := string(elem.Metric["running_timestamp"])

				time_event, _ := time.Parse(layout, event_timestamp)
				time_ref, _ := time.Parse(layout, timestamp_ref.String())

				elapsedTime := time_ref.Sub(time_event).Seconds()
				act_runtime = act_runtime + int64(elapsedTime)
			} else {
				p("killed:", string(elem.Metric["pod"]))
				acc_runtime = acc_runtime + int64(elem.Value)
			}
		} else if metric_name == "waiting_time" {

			if elem.Metric["state"] == "waiting" {
				p("waiting:", string(elem.Metric["pod"]))
				n_waiting = n_waiting + 1

				event_timestamp := string(elem.Metric["enqueue_timestamp"])

				time_event, _ := time.Parse(layout, event_timestamp)
				time_ref, _ := time.Parse(layout, timestamp_ref.String())

				elapsedTime := time_ref.Sub(time_event).Seconds()
				act_waittime = act_waittime + int64(elapsedTime)
			} else {
				p("running:", string(elem.Metric["pod"]))
				acc_waittime = acc_waittime + int64(elem.Value)
			}
		}
	}

	p("Timestamp reference:", timestamp_ref)

	p("Accumulated running time:", acc_runtime)
	p("Actual running time:", act_runtime)
	p("Total running time:", acc_runtime + act_runtime)
	p("Number of running pods", n_running)

        p("Accumulated waiting time:", acc_waittime)
        p("Actual waiting time:", act_waittime)
        p("Total waiting time:", acc_waittime + act_waittime)
        p("Number of waiting pods", n_waiting)

	total_running_time := float64(acc_runtime + act_runtime)
	total_waiting_time := float64(acc_waittime + act_waittime)

	slo := 0.5
	effective_runtime := (total_running_time - (slo * (total_running_time + total_waiting_time)))
	total_jobtime := (float64(n_running) * slo) + (float64(n_waiting) * (slo - 1))

	p(effective_runtime)
	p(total_jobtime)
	ttv :=  effective_runtime / total_jobtime

	p("TTV:", ttv)
	/*
        query_runtime_now := `sum(` + timestamp + ` - push_time_seconds{controller="` + controller_val + `"})`
        runtime_now, _ := newApi.Query(context.Background(), query_runtime_now, now)
	runtime_2 := int64(runtime_now.(model.Vector)[0].Value)

        query_waittime := `sum(waiting_time{controller="` + controller_val + `", state="running"})`
        waittime, _ := newApi.Query(context.Background(), query_waittime, now)
        waittime_1 := waittime.(model.Vector)[0].Value

	query_n_running := `count(running_time{controller="` + controller_val + `", state="running"})`
	running, _ := newApi.Query(context.Background(), query_n_running, now)

	var n_running float64

	if running.String() != "" {
	        n_running = float64(running.(model.Vector)[0].Value )
	} else {
		n_running = 0
	}

	p(runtime_1)
        p(runtime_2)
        p(waittime_1)
	p(n_running)
	*/
}
