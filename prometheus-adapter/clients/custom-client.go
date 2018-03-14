package main

import (
	"fmt"
	"context"
	"time"

	"golang.org/x/oauth2/google"
	clientset "k8s.io/client-go/kubernetes"

	. "github.com/onsi/ginkgo"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	instrumentation "k8s.io/kubernetes/test/e2e/instrumentation/common"

	gcm "google.golang.org/api/monitoring/v3"
	"k8s.io/apimachinery/pkg/labels"
	"k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/apimachinery/pkg/selection"
	"k8s.io/client-go/discovery"
	"k8s.io/kubernetes/test/e2e/framework"
	customclient "k8s.io/metrics/pkg/client/custom_metrics"
)

const (
	stackdriverExporterPod1  = "stackdriver-exporter-1"
	stackdriverExporterPod2  = "stackdriver-exporter-2"
	stackdriverExporterLabel = "stackdriver-exporter"
)

var _ = instrumentation.SIGDescribe("Stackdriver Monitoring", func() {
	BeforeEach(func() {
		framework.SkipUnlessProviderIs("gce", "gke")
	})

	f := framework.NewDefaultFramework("stackdriver-monitoring")
	var kubeClient clientset.Interface
	var customMetricsClient customclient.CustomMetricsClient
	var discoveryClient *discovery.DiscoveryClient

	It("should run Custom Metrics - Stackdriver Adapter [Feature:StackdriverCustomMetrics]", func() {
		kubeClient = f.ClientSet
		config, err := framework.LoadConfig()
		if err != nil {
			framework.Failf("Failed to load config: %s", err)
		}
		customMetricsClient = customclient.NewForConfigOrDie(config)
		discoveryClient = discovery.NewDiscoveryClientForConfigOrDie(config)
		//testAdapter(f, kubeClient, customMetricsClient, discoveryClient)
	})
})

func main() {

	//var discoveryClient *discovery.DiscoveryClient

	//config, err := framework.LoadConfig()
	//discoveryClient := discovery.NewDiscoveryClientForConfigOrDie(config)

	resources, err := discoveryClient.ServerResourcesForGroupVersion("custom.metrics.k8s.io/v1beta1")
	if err != nil {
		fmt.Println("Failed to retrieve a list of supported metrics: ", err)
	}
}
