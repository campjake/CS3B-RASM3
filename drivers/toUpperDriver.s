	.data
sz1:	.asciz	"aaaa"

	.global _start
	.text

_start:
	LDR	X0,=sz1
	BL	toUpperCase
	LDR	X0, [X0]		// Just added for break
	MOV	X1, #0			// Does nothing
