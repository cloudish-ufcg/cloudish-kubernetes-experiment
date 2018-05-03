package main

import (
	"encoding/csv"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"strconv"
	"strings"
	"time"
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

				// TODO call util func to create a yaml (a string) based on the controller name and requeriments

				if timestamp == time_ref {
					fmt.Println(timestamp, time_ref, controller_name)
					// TODO call kubernetes client to create the pod
					// TODO call a gorotine to manage the controller termination
				} else {
					wait_time := int(timestamp - time_ref)
					time_ref = timestamp
					fmt.Println("")
					time.Sleep(time.Duration(wait_time) * time.Second)
					fmt.Println(timestamp, time_ref, controller_name)
					// TODO call kubernetes client to create the pod
					// TODO call a gorotine to manage the controller termination
				}

			}
		}
	}

	// TODO wait the experiment timeout and terminate all controllers
}
