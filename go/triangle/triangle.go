// Package triangle provides triabgle info functions.
package triangle

import "math"

// Kind of triangles
type Kind int

// Values for the Kind constant
const (
	NaT Kind = iota // not a triangle
	Equ             // equilateral
	Iso             // isosceles
	Sca             // scalene
)

// KindFromSides returns the kind of a triangle.
func KindFromSides(a, b, c float64) Kind {
	switch {
	case a <= 0 || b <= 0 || c <= 0: // negative sides
		return NaT
	case a+b < c || b+c < a || a+c < b: // side lengths violate triangle inequality
		return NaT
	case math.IsNaN(a + b + c): // Not a Number
		return NaT
	case math.IsInf(a+b+c, 0): // Infinite
		return NaT
	case a == b && b == c: // all sides same length
		return Equ
	case a == b || b == c || a == c: // at least two sides of same length
		return Iso
	}
	return Sca
}
