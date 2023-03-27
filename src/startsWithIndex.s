// Programmer: Gregory Shane and Jacob Campbell
// CS3B - Sptring 2023
// RASM3 - String_startsWithIndex
// last modified: 3.20.2023

// startsWithIndex subroutine takes a null terminated string and a null
//   terminated prefix substring and compares for if the match. Returns a boolean
//   value into x0.
//
//   x0 must contain address of null terminated string
//   x1 must contain address of null terminate prefix substring
//   x2 must contain index to start from
//   LR must contain returning address
//   ALL AAPCS registers are preserved, x0 and x1 are modified.
//   Results return to x0

	.global startsWithIndex		//sets starting point of subroutine

	.text
startsWithIndex:
	STR x19, [SP, #-16]!	// PUSH
	STR x20, [SP, #-16]!	// PUSH

	STR x30, [SP, #-16]!	// PUSH LR

	MOV x19, x0 		// copy string
	MOV x20, x1 		// copy substring

compare:
	LDRB w0, [x19, x2]	// load string[index]
	LDRB w1, [x20], #1	// load prefix[i]

	CMP w1, #0x00		// compare for prefix[i] = null
	B.EQ true		// brnch if true

	CMP w0, w1		// compare string[index] and prefix[i]
	ADD w2, w2, #1		// index ++
	B.EQ compare		// loop back

// not equal -- Returns false
	MOV x0, #0		// x0 = 0 (false)
	B   finished		// brnach to finished

// equal -- Retunrs true
true:
	MOV x0, #1		// x0 = 1 (true)

finished:
	LDR x30, [SP], #16	// POP LR
	LDR x20, [SP], #16	// POP
	LDR x19, [SP], #16	// POP

	RET LR			// Return
	.end
