// Package anagram creates lists of possible anagrams
package anagram

import (
	"sort"
	"strings"
)

// Detect returns a correct list of anagrams, given a word and a list of possible anagrams
func Detect(subject string, candidates []string) (result []string) {
	encoded := encode(subject)
	for _, word := range candidates {
		if strings.ToLower(subject) != strings.ToLower(word) && encoded == encode(word) {
			result = append(result, word)
		}
	}
	return result
}

func encode(word string) string {
	word = strings.ToLower(word)
	letters := strings.Split(word, "")
	sort.Strings(letters)
	return strings.Join(letters, "")
}
