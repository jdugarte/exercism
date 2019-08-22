// Package isogram determines if a word or phrase is an isogram
package isogram

import (
	"strings"
	"unicode"
)

type checked struct{}
type register map[rune]checked

// IsIsogram returns true if a word or phrase is an isogram
func IsIsogram(input string) bool {
	chars := register{}
	for _, char := range strings.ToLower(input) {
		if unicode.IsLetter(char) {
			if _, exists := chars[char]; exists {
				return false
			}
			chars[char] = checked{}
		}
	}
	return true
}
