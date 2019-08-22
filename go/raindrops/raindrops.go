// Package raindrops converts a number to PlingPlangPlong raindrops
package raindrops

import "strconv"

type drop struct {
	factor int
	text   string
}

var raindrops = []drop{
	{3, "Pling"},
	{5, "Plang"},
	{7, "Plong"},
}

// Convert generates a string, the contents of which depend on the number's factors.
//
// - If the number has 3 as a factor, output 'Pling'.
//
// - If the number has 5 as a factor, output 'Plang'.
//
// - If the number has 7 as a factor, output 'Plong'.
//
// - If the number does not have 3, 5, or 7 as a factor, just pass the number's digits straight through.
func Convert(number int) (rain string) {
	for _, drop := range raindrops {
		if number%drop.factor == 0 {
			rain += drop.text
		}
	}

	if len(rain) == 0 {
		rain = strconv.Itoa(number)
	}

	return rain
}
