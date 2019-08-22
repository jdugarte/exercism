// Package hamming calculates the Hamming difference between two DNA strands
package hamming

import "errors"

// Distance returns the Hamming difference between two DNA strands
func Distance(a, b string) (distance int, err error) {
	if len(a) != len(b) {
		return 0, errors.New("sequences of different lengths")
	}

	runedA, runedB := []rune(a), []rune(b)
	for i, letter := range runedA {
		if letter != runedB[i] {
			distance++
		}
	}
	return distance, nil
}
