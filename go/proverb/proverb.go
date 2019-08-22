// Package proverb generates the old proverb "For want of a horseshoe nail, a kingdom was lost".
package proverb

import "fmt"

// Proverb generates the proverb from a given a list of inputs.
func Proverb(rhyme []string) (proverb []string) {
	lines := len(rhyme)
	if lines > 0 {
		proverb = make([]string, lines)
		for i, word := range rhyme[1:] {
			proverb[i] = fmt.Sprintf("For want of a %s the %s was lost.", rhyme[i], word)
		}
		proverb[lines-1] = fmt.Sprintf("And all for the want of a %s.", rhyme[0])
	}
	return
}
