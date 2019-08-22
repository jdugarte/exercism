// Package strand provides a RNA transcription of a DNA strand
package strand

var dnaToRna = map[rune]byte{
	'G': 'C',
	'C': 'G',
	'T': 'A',
	'A': 'U',
}

// ToRNA generates the RNA complement of a DNA strand
func ToRNA(dna string) string {
	rna := make([]byte, len(dna))
	for i, letter := range dna {
		rna[i] = dnaToRna[letter]
	}
	return string(rna)
}
