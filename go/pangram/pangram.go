// Package pangram determines if a sentence is a pangram
package pangram

import "strings"

// IsPangram returns true if a sentence is a pangram
func IsPangram(input string) bool {
	if input == "" {
		return false
	}

	input = strings.ToLower(input)
	for _, char := range "abcdefghijklmnopqrstuvwxyz" {
		if !strings.ContainsRune(input, char) {
			return false
		}
	}
	return true
}
