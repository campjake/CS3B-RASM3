// Style Sheet
// Programmer   : Jacob Campbell & Gregory Shane
// RASM #       : 3
// Purpose      : String Library
// Date         : 3/15/2023

// toLowerCase(string1:String):String
// Description: 	Converts a case-insensitive string to lower-case
//			while leaving numeric & special characters as is

// Preconditions: 	X0 - Holds the address of a string in memory
//					X0 - Must be less than 512 characters long

// Post-conditions:	X0 - Contains the address of the lower-case string in memory
//					X1 - Contains the size of the string in BYTES, including the null-terminator
// The string is CONVERTED to lower-case, so the mixed-case version is NOT saved
// Upper-case string will be at the same address as mixed-case string
// All registers are preserved except X0 - X2

	.global toLowerCase
	.text

toLowerCase:
// Get base address and check for empty string, which also satisfies
// the conditions to enter the while loop
	MOV	X1, #0	// Index counter for byte offset


// while(szIn[i] != 0x00)			- Loop through string until we hit null byte
// if(szIn[i] < 0x41 && szIn[i] > 0x5A)		- Only modify with hex vals 'a' - 'z'
// szIn[i++] += 0x20				- Convert by adding 0x20
// X1 contains the size in bytes
// X0 has the lower-case string
LOOP:
	LDRB	W2, [X0, X1]			// Load szIn[i] and offset by numBytes in X3

						// Use ! to overwrite value with null
// Check hex value for letter-case
	CMP		X2, #'Z'		// Check if greater than 'Z'
	BGT		STORE			// True - Branch to continue
	CMP		X2, #'A'		// Check if less than 'A'
	BLT		STORE			// True - Branch to continue
	ADD		W2, W2, 0x20		// Change to lower-case

STORE:
	STRB	W2, [X0, X1]			// Overwrite szIn[i] with upper-case character
	ADD		X1, X1, #1		// i++
	CMP		W2, 0x00		// Check if we hit the null byte
	BNE		LOOP			// Back to while() if no the null byte

END:
	RET					// Return to the calling function
	.end
