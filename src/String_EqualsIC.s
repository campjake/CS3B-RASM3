// Programmer: Gregory Shane
// CS3b - Spring 2023
// RASM3
// subroutine: String_EqualIgnoreCase
// Last Modified: 3.14.2023

// String_EqualsIC: Compares two strings ignoring case sensitivity if they match. 
//   Returns false (0) or true (1)
//
// X0 = must contain first null terminated string
// x1 = must contain second null terminated string
// LR = return address
//
// Returns retsults to x0
// ALL AAPCS Mandate Regiters are preserved

	.global String_EqualsIC

	.text
String_EqualsIC:
	STR x19,[SP, #-16]!     // Push
	STR x20,[SP, #-16]!	// Push
	STR x21,[SP, #-16]!	// Push
	STR x22,[SP, #-16]!	// Push

	STR x30,[SP, #-16]!	// Push LR

	MOV x19,x0		// x19 = s1
	MOV x20,x1		// x20 = s2

	BL  String_length	// string_leng(s1)
	MOV x21,x0		// x21 = s1.length()

	MOV x0,x1		// x0 = s2
	BL  String_length	// String_length(s2)
	MOV x22,x0		// x22 = s2.length()

	CMP x21, x22		// compare lengths
	B.NE  false		// Not equal Branch to false

	MOV x2,#0		// counter i = 0

// load char si[i] and s2[i]
check:
	CMP w2,w21		// compare i to string length
	B.EQ true		// if i = length branch to true

	LDRB w0,[x19],#1	// load char s1[i]
	LDRB w1,[x20],#1	// load char s2[i]

// check s1[i] for Uppercase
	CMP w0, #0x41		// compare si[i] to 'A'
	B.LT second		// branch if less than

	CMP w0, #0x5A		// compare s1[i] to 'Z'
	B.GT second		// branch if greater than

	ADD w0,w0,#0x20		// w0 = lowercase letter of w0

// check s2[i] for Uppercase
second:
	CMP w1,#0x41		// compare s2[i] to 'A'
	B.LT compare		// branch if less than

	CMP w1,#0x5A		// compare s2[2] to 'Z'
	B.GT compare		// branch if less than

	ADD w1,w1,#0x20		// w1 = lowercase letter of w1

// compare s1[i] and s2[i]
compare:
	ADD w2,w2,#1		// i++
	CMP w0,w1		// compare w0 and w1
	B.EQ check		// loop back if equal

// return false
false:
	MOV x0,#0		// load 0 (false) to x0
	B  finish
// retrun true
true:
	MOV x0,#1		// load 1 (true) to x0

finish:
	LDR x30, [SP], #16	// POP LR

	LDR x22, [SP], #16	// Pop
	LDR x21, [SP], #16	// Pop
	LDR x20, [SP], #16	// Pop
	LDR x19, [SP], #16	// Pop
	RET LR			// return

	.end
