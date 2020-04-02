//package webclient_application

package main


import (
	"fmt"
	"time"

	vegeta "github.com/tsenart/vegeta/lib"
)

func main() {
	rate := vegeta.Rate{Freq: 2500, Per: time.Second}
	duration := 100 * time.Second
	targeter := vegeta.NewStaticTargeter(vegeta.Target{
		Method: "GET",
		//URL:    "http://localhost:9100/",
		URL:    "http://10.11.5.56:30555/",
	})
	attacker := vegeta.NewAttacker()

	var metrics vegeta.Metrics
	for res := range attacker.Attack(targeter, rate, duration, "Big Bang!") {
		metrics.Add(res)
	}
	metrics.Close()

	fmt.Printf("Mean: %s\n", metrics.Latencies.Mean)
	fmt.Printf("50th percentile: %s\n", metrics.Latencies.P50)
	fmt.Printf("90th percentile: %s\n", metrics.Latencies.P90)
	fmt.Printf("95th percentile: %s\n", metrics.Latencies.P95)
	fmt.Printf("99th percentile: %s\n", metrics.Latencies.P99)
	fmt.Printf("Max percentile: %s\n", metrics.Latencies.Max)
	fmt.Printf("Total: %s\n", metrics.Latencies.Total)

}
