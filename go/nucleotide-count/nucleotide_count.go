// Package dna generates a histogram of valid nucleotides
package dna

import "fmt"

// Histogram is a mapping from nucleotide to its count in given DNA.
type Histogram map[byte]int

// DNA is a list of nucleotides
type DNA []byte

// Counts generates a histogram of valid nucleotides in the given DNA.
// Returns an error if dna contains an invalid nucleotide.
func (dna DNA) Counts() (Histogram, error) {
	histogram := Histogram{'A': 0, 'C': 0, 'G': 0, 'T': 0}
	for _, letter := range dna {
		if _, valid := histogram[letter]; !valid {
			return nil, fmt.Errorf("invalid nucleotide %q", letter)
		}
		histogram[letter]++
	}
	return histogram, nil
}
