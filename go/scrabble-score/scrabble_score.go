// Package scrabble calculates the score of a given a word in scrabble.
package scrabble

import "unicode"

// Score calculates the score of a given a word in scrabble.
func Score(input string) (points int) {
	for _, letter := range input {
		switch unicode.ToUpper(letter) {
		case 'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T':
			points++
		case 'D', 'G':
			points += 2
		case 'B', 'C', 'M', 'P':
			points += 3
		case 'F', 'H', 'V', 'W', 'Y':
			points += 4
		case 'K':
			points += 5
		case 'J', 'X':
			points += 8
		case 'Q', 'Z':
			points += 10
		}
	}
	return
}
