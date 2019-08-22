package romannumerals

import (
	"errors"
	"strings"
)

type unit struct {
	letter string
	value  int
}

type units []unit

var romanToNumeral = units{
	{"M", 1000},
	{"CM", 900},
	{"D", 500},
	{"CD", 400},
	{"C", 100},
	{"XC", 90},
	{"L", 50},
	{"XL", 40},
	{"X", 10},
	{"IX", 9},
	{"V", 5},
	{"IV", 4},
	{"I", 1},
}

func ToRomanNumeral(number int) (result string, err error) {
	if number <= 0 || number > 3000 {
		return "", errors.New("")
	}

	for _, numeral := range romanToNumeral {
		times := number / numeral.value
		if times > 0 {
			result += strings.Repeat(numeral.letter, times)
			number -= times * numeral.value
		}
	}
	return
}
