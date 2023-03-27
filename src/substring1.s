// Programmer: Gregory Shane and Jacob Campbell
// CS3B - Spring 2023
// RASM3 - substring with starting and ending index
// Last modified: 3.2.2023

// substring subroutine takes a null terminated string, starting index,
//  and ending index to dynamically create a new substring.

// subroutine requires malloc/free
// x0 must contain the address of a null terminate string
// x1 must contain the starting index
// x2 must conatain the ending index
// LR must contain the returning address

// ALL AAPCS registers are preserved
// various registers modified due to malloc

	.global substring1	// sets starting point of subroutine

	.text
substring1:
	STR x19, [SP, #-16]!	// PUSH
	STR x20, [SP, #-16]!	// PUSH
	STR x21, [SP, #-16]!	// PUSH
	STR x22, [SP, #-16]!	// PUSH
	STR x30, [SP, #-16]!	// PUSH LR

	MOV x19, x0		// copy string address
	SUB x0, x2, x1		// x20 = end - start
	ADD x0, x0, #1		// add 1 for null
	MOV x20, x1		// copy starting index
	MOV x21, x2		// copy ending index

	BL  malloc		// allocate memory
	MOV x22, x0		// x22 copy of address
loop:
	LDRB w1, [x19, x20]	// load w1 with string[i]
	STRB w1, [x0], #1	// store w1 into new string[i]

	ADD  x20, x20, #1	// i++
	CMP  x20, x21		// compare i and length
	B.LT loop		// loop back if (i < lenngth)

	MOV  w2, #0X00		// move a null into w2
	STRB w2, [x0], #1	// add null to end of new string
	MOV  x0, x22		// move starting address of new string

	LDR x30, [SP], #16	// POP LR
	LDR x22, [SP], #16	// POP
	LDR x21, [SP], #16	// POP
	LDR x20, [SP], #16	// POP
	LDR x19, [SP], #16	// POP

	RET LR			// Return
	.end
