	.data
sz1:	.asciz	"aaaa"

	.global _start
	.text

_start:
	LDR	X0,=sz1		// Load string
	BL	toUpperCase	// X0 points to sz1 all upper-case
	LDR	X2,=sz1		// Break here if needed
	LDR	X2, [X2]	// Check if its upper-case

// Setup prarameters to exit program and call Linux kernel to do so
        MOV     X0, #0		// Use return code 0
	MOV	X8, #93		// Service command 93
	SVC	0		// Bye-bye :)
