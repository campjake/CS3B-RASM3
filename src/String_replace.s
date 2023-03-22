// Programmer: Gregory Shane
// CS3B - Spring 2023
// RASM3 - String Replace
// Last modified: 3.22.2023

// String_replace subrotuine takes a null terminate string, the letter to replace, and the new
//  letter to replace it with and replaces all instances within the string. This modifies the string
//  directly, and returns th address to x0.
//
//  x0 must contain null terminated string
//  x1 must contain old char to be replaced
//  x2 must contain new char to replace with
//  LR must contain return address
//  ALL AAPCS Mandated registers are preserved.

	.global String_replace

	.text

String_replace:
	STR x20, [SP, #-16]!	// PUSH
	STR x21, [SP, #-16]!	// PUSH
	STR x30, [SP, #-16]!	// PUSH

	MOV x19, #0		// i = 0
compare:
	LDRB w20, [x0, x19]	// load string[i]

	CMP  x20, #0x00		// check for null
	B.EQ finished		// branch if found

	CMP  w20, w1		// check for match
	B.EQ change		// branch back if not

	ADD x19, x19, #1	// i++
	B    compare		// branch back

change:
	STRB w2, [x0, x19]	// store new letter
	ADD  x19, x19, #1	// i++
	B    compare		// brnach back

finished:
	LDR x30, [SP], #16	// POP LR
	LDR x21, [SP], #16	// POP
	LDR x20, [SP], #16	// POP

	RET			// return
	.end
