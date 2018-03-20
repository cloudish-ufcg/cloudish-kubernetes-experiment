package main

import (
	"fmt"

	"github.com/prometheus/client_golang/prometheus/push"
	"github.com/prometheus/client_golang/prometheus"
)

var (
	gatewayUrl = "10.11.4.159:31697/"
	fabioPushMetric = prometheus.NewGauge(prometheus.GaugeOpts{
		Name: "metric_push",
		Help: "Metric from fabio",
		ConstLabels: prometheus.Labels{"state":"runing", "test":"5","pod":"podfabio_1"},
	})
	fabioAddMetric = prometheus.NewGauge(prometheus.GaugeOpts{
                Name: "metric_pushadd",
                Help: "Metric from fabio",
                ConstLabels: prometheus.Labels{"state":"runing", "test":"7","pod":"podfabio_2"},
        })
)

func main() {

	fabioPushMetric.Set(5000)
	fabioAddMetric.Set(600)

	//if err := push.Collectors("fabio_job", push.HostnameGroupingKey(), gatewayUrl, fabioPushMetric); 
	//	err != nil {
	//		fmt.Println("Could not push to Pushgateway:", err)
	//}

	// Ṕusher-Push
	if err := push.New(gatewayUrl, "fabio_job").
		Collector(fabioPushMetric).
		Push(); err != nil {
		fmt.Println("Could not push to Pushgateway:", err)
	}

	if err := push.New(gatewayUrl, "fabio_job").
                Collector(fabioAddMetric).
                Add(); err != nil {
                fmt.Println("Could not push to Pushgateway:", err)
        }
}

