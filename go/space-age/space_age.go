// Package space includes planet age function
package space

// Planet is name of the planet
type Planet string

const secondsPerYearOnEarth = 31557600

var orbitalPeriod = map[Planet]float64{
	"Earth":   1,
	"Mercury": 0.2408467,
	"Venus":   0.61519726,
	"Mars":    1.8808158,
	"Jupiter": 11.862615,
	"Saturn":  29.447498,
	"Uranus":  84.016846,
	"Neptune": 164.79132,
}

// Age calculates how old someone would be on any of the planets
// of the Solar System given their age in seconds
func Age(seconds float64, planet Planet) float64 {
	return seconds / orbitalPeriod[planet] / secondsPerYearOnEarth
}
