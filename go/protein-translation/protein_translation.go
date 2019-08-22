package protein

import (
	"errors"
)

var ErrStop = errors.New("STOP")
var ErrInvalidBase = errors.New("Invalid base")

func FromCodon(codon string) (string, error) {
	switch codon {
	case "UGU", "UGC":
		return "Cysteine", nil
	case "UUA", "UUG":
		return "Leucine", nil
	case "AUG":
		return "Methionine", nil
	case "UUU", "UUC":
		return "Phenylalanine", nil
	case "UCU", "UCC", "UCA", "UCG":
		return "Serine", nil
	case "UGG":
		return "Tryptophan", nil
	case "UAU", "UAC":
		return "Tyrosine", nil
	case "UAA", "UAG", "UGA":
		return "", ErrStop
	}
	return "", ErrInvalidBase
}

func FromRNA(rna string) (proteins []string, err error) {
	for i := 0; i < len(rna); i += 3 {
		protein, err := FromCodon(rna[i : i+3])
		switch err {
		case ErrStop:
			return proteins, nil
		case ErrInvalidBase:
			return proteins, ErrInvalidBase
		default:
			proteins = append(proteins, protein)
		}
	}
	return proteins, nil
}
