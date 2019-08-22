// Package twofer is an implementation of two for one (two-fer, or 2-fer for short):
// "One for X, one for me.", where X is a name or "you".
package twofer

import "fmt"

// ShareWith returns "One for X, one for me."
// If the given name is "Alice", the result will be "One for Alice, one for me."
// If no name is given, the result will be "One for you, one for me."
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}
