package summultiples

import "math"

// SumMultiples finds the sum of all the unique multiples of particular numbers up to but not including that number
func SumMultiples(n int, divisors ...int) (sum int) {
	for i := 1; i < n; i++ {
		for _, d := range divisors {
			if math.Mod(float64(i), float64(d)) == 0 {
				sum += i
				break
			}
		}
	}
	return sum
}
