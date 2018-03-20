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
	"context"
	"time"
	//"reflect"

	promApi "github.com/prometheus/client_golang/api/prometheus/v1"
	"github.com/prometheus/client_golang/api"

	"github.com/prometheus/common/model"
)


var cfg = api.Config {
	Address: "http://localhost:32518",
	RoundTripper: api.DefaultRoundTripper,
}

func main() {

	promClient, _ := api.NewClient(cfg)
	newApi := promApi.NewAPI(promClient)

	query := "metric_pushadd"
	res, _ := newApi.Query(context.Background(), query, time.Now())

	//fmt.Println(err)
	fmt.Println(res)
	//fmt.Println(reflect.TypeOf(res))

	vectorVal := res.(model.Vector)
	fmt.Println(len(vectorVal))
	fmt.Println(vectorVal[0])

	metric := vectorVal[0].Metric
	value := vectorVal[0].Value
	timestamp := vectorVal[0].Timestamp


	//for _, elem := range vectorVal {
	//	fmt.Println(elem.Metric)
	//	fmt.Println(elem.Value)
	//	fmt.Println(elem.Timestamp)
	//}
}
