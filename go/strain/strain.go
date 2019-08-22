package strain

type Ints []int
type Lists [][]int
type Strings []string

func (collection Ints) Keep(predicate func(int) bool) (result Ints) {
	for _, element := range collection {
		if predicate(element) {
			result = append(result, element)
		}
	}
	return
}

func (collection Ints) Discard(predicate func(int) bool) (result Ints) {
	negatedPredicate := func(element int) bool { return !predicate(element) }
	return collection.Keep(negatedPredicate)
}

func (collection Lists) Keep(predicate func([]int) bool) (result Lists) {
	for _, element := range collection {
		if predicate(element) {
			result = append(result, element)
		}
	}
	return
}

func (collection Strings) Keep(predicate func(string) bool) (result Strings) {
	for _, element := range collection {
		if predicate(element) {
			result = append(result, element)
		}
	}
	return
}
