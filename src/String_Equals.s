// Programmer: Gergory Shane
// CS3B - Spring 2023
// RASM3
// Subroutine: String_equals
// Last Modified: 3.13.2023

// Subrtoutine: String_Equals: Compares two strings, and returns a 0 (false) and 1 (true) on comparison
// x0 must contain address of first null terminated string
// x1 must contain address of second null terminated string
// LR must contain return address
//
// Results return in x0

	.global String_Equals

	.text
String_Equals:
	STR x19, [SP, #-16]!	// Push
	STR x20, [SP, #-16]!	// Push
	STR x21, [SP, #-16]!	// Push
	STR x22, [SP, #-16]!	// Push

	STR x30, [SP, #-16]! 	// preserving register

	MOV x19,x0		// x19 = Str1
	MOV x20,x1		// x20 = Str2

	BL String_length	// calculates string length
	MOV x21, x0		// x21 = Str1.length

	MOV x0,x20		// x0 = str2
	BL String_length	// caculates string length
	MOV x22, x0		// x22 = Str2.length

	CMP x21,x22		// compare lengths
	B.NE false		// if not equal return false

	MOV w2,#0		// counter i = 0
check:
	CMP w2,w21		// i == str1.length()
	B.EQ true		// branch if true

	LDRB w0,[x19], #1	// load char str1[i]
	LDRB w1,[x20], #1	// load char str2[i]

	ADD w2,w2,#1		// i++

	CMP w0,w1		// compare str1[i] and str2[i]
	B.EQ check		// loop back if equals
false:
	MOV x0,#0		// x0 = 0 (false)
	B   finish

true:
	MOV x0,#1		// x0 = 1 (true)

finish:
	LDR x30, [SP], #16	// POP register

	LDR x22, [SP], #16	// Pop
	LDR x21, [SP], #16	// POP
	LDR x20, [SP], #16	// Pop
	LDR x19, [SP], #16	// Pop

	RET LR			// return

	.end
