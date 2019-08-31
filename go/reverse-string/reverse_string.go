// Package reverse reverses a string
package reverse

import (
	"strings"
)

// Reverse reverses the given input
func Reverse(input string) string {
	reversed := strings.Split(input, "")
	size := len(reversed)
	for i := size/2 - 1; i >= 0; i-- {
		opposite := size - 1 - i
		reversed[i], reversed[opposite] = reversed[opposite], reversed[i]
	}
	return strings.Join(reversed, "")
}
