package accumulate

type converterFunction func(string) string

func Accumulate(given []string, converter converterFunction) []string {
	expected := make([]string, len(given))
	for i, s := range given {
		expected[i] = converter(s)
	}
	return expected
}
