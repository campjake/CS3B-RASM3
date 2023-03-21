// Programmer: Gregory Shane
// CS3B - Spring 2023
// RASM3 - String_startsWith(string, substring)
// last modified: 3.20.2023

// startsWith subroutine takes a null terminated string and a null terminated
//  substring, starts with index 0, an compares if they match. Returns a boolean
//  to x0.
//
// x0 must contain the address of a null terminated string
// x1 must contain the address of a null terminate substring
// LR must contain returning address.
// ALL AAPCS registers are perserved.
// Results returned in x0.

	.global startsWith	// sets starting point of subroutine

	.text

startsWith:
	STR x19, [SP, #-16]!	// PUSH
	STR x20, [SP, #-16]!	// PUSH
	STR x30, [SP, #-16]!	// PUSH LR

	MOV x19, x0		// x19 = copy of string
	MOV x20, x1		// x20 = copy of prefix substring

compare:
	LDRB w1, [x19], #1	// w1 = stirng[i]
	LDRB w2, [x20], #1	// w2 = prefix[i]

	CMP w2, #0x00		// compare w2 for null
	B.EQ true		// branch if found

	CMP w1, w2		// compare string[i] and prefix[i]
	B.EQ compare		// looop back if match

	MOV x0,#0		// x0 = 0 (false)
	B  finished		// branch to finished

true:
	MOV x0, #1		// x0 = 1 (true)

finished:
	LDR x30, [SP], #16	// POP LR
	LDR x20, [SP], #16	// POP
	LDR x21, [SP], #16	// POP

	RET LR			// Return
	.end
