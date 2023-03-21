// Programmer: Gregory Shane
// CS3B - Spring 2023
// RASM3 - String_substring2
// Last modified: 3.21.2023

// substring2 subroutine: Takes a null terminated string and an index to start at. Dynamically
//  creates a new substring starting at the index to the end of the stirng. Address of new substring
//  is returned to x0.
//
//  Needs malloc/free
//  x0 must conatain the address of an null terminated string
//  x1 must contain the index.
//  LR must contain return address
//
//  All AAPCS registers are perserved.
//  various registers are modified due to malloc

	.global substring2	// sets starting point of subroutine

	.text

substring2:
	STR x19, [SP, #-16]!	// push
	STR x20, [SP, #-16]!	// push
	STR x21, [SP, #-16]!	// push
	STR x22, [SP, #-16]!	// push
	STR x30, [SP, #-16]!	// push

	MOV x19, x0		// copy string address
	MOV x20, x1		// copy starting index

	BL String_length	// x0 = string length
	MOV x21, x0		// copy string length
	SUB x0, x0, x1		// x0 = string length - starting index
	ADD x0, x0, #1		// add one for null

	BL malloc		// allocate memory
	MOV x22, x0		// copy ptr to memory

loop:
	LDRB w1, [x19, x20]	// load one byte starting at index
	STRB w1, [x0], #1	// store one byte to ptr

	ADD x20, x20, #1	// increase index
	CMP x20, x21		// compare against string length
	B.LT loop		// if less than loop back

	MOV w1, #0x00		// load null to x1
	STRB w1, [x0], #1	// add null to end of new string

	MOV x0, x22		// move ptr address to x0

	LDR x30, [SP], #16	// pop LR
	LDR x22, [SP], #16	// pop
	LDR x21, [SP], #16	// pop
	LDR x20, [SP], #16	// pop
	LDR x19, [SP], #16	// pop

	RET LR			// return

	.end
