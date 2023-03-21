// Programmer: Gregory Shane
// CS3B - SPring 2023
// RASM 3 - String_endsWith subroutine
// Last Modified: 3.19.2023

// String_endsWith subroutine: Takes a null terminate string, and a
//   null terminate suffix substring and compares to see if they match.
//   returns 0 (false) or 1 (true) to x0
//
//   x0 contains null terminated string
//   x1 contains null termintae suffix substring
//   LR contains return address
//
//   ALL AAPCS registers are perserved
//   x0 returns boolean reasult, x1 is modified

	.global endsWith	// sets starting point of subroutine

	.text

endsWith:
	STR x19, [SP, #-16]!	// PUSH
	STR x20, [SP, #-16]!	// PUSH
	STR x21, [SP, #-16]!	// PUSH

	STR x30, [SP, #-16]!	// PUSH LR

	MOV x19, x0		// copy string
	MOV x20, x1		// copy substring

	BL String_length	// sring.length()

	MOV x21, x0		// x21 = string.length()

	MOV x0,x20		// x0 = suffix
	BL String_length	// suffix.length()

	SUB x21, x21, x0	// x21 = string - suffix

compare:
	LDRB w0, [x19, x21]	// load string[i]
	LDRB w1, [x20], #1	// load suffix[i]

	CMP w1, #0x00		// compare if suffix[i] = null
	B.EQ true		// branch if true

	CMP w0,w1		// compare string[i] and suffic[i]
	ADD x21, x21, #1	// x21 += 1
	B.EQ compare		// branch back to compare if match

// false
	MOV x0, #0		// x0 = 0 (false)
	B  finished		// branch to finised

true:
	MOV x0, #1		// x0 = 1 (true)

finished:
	LDR x30, [SP], #16	// POP

	LDR x21, [SP], #16	// POP
	LDR x20, [SP], #16	// POP
	LDR x19, [SP], #16	// POP

	RET LR			// Return
	.end
