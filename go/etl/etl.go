package etl

import "strings"

type dataIn map[int][]string
type dataOut map[string]int

func Transform(input dataIn) dataOut {
	output := dataOut{}
	for key, values := range input {
		for _, value := range values {
			output[strings.ToLower(value)] = key
		}
	}
	return output
}
