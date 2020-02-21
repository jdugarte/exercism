package diffsquares

// SquareOfSum returns the square of the sum of the first N natural numbers
func SquareOfSum(n int) (sum int) {
	for i := 1; i <= n; i++ {
		sum += i
	}
	return sum * sum
}

// SumOfSquares returns the sum of the squares of the first N natural numbers
func SumOfSquares(n int) (sum int) {
	for i := 1; i <= n; i++ {
		sum += i * i
	}
	return sum
}

// Difference returns the difference between the square of the sum and the sum of the squares of the first N natural numbers
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
