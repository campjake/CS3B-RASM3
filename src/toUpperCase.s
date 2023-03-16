// Style Sheet
// Programmer   : Jacob Campbell & Craig Shane
// RASM #       : 3
// Purpose      : String Library
// Date         : 3/15/2023

// toUpperCase(string1:String):String
// Description: 	Converts a case-insensitive string to upper-case
//			while leaving numeric & special characters as is

// Preconditions: 	X0 - Holds the address of a string in memory
//			X0 - Must be less than 512 characters long

// Post-conditions:	X0 - Contains the address of the upper-case string in memory
//			X1 - Contains the null terminated string, all upper-case
// The string is CONVERTED to upper-case, so the mixed-case version is NOT saved
// Upper-case string will be at the same address as mixed-case string
// All registers are preserved except X1 & X2

	.data
szOut:	.skip	21		// Will contain the address pointed to in X0
	.global toUpperCase
	.text

toUpperCase:
// Get base address and check for empty string, which also satisfies
// the conditions to enter the while loop
	LDR	X1,=szOut	// *X1 = szOut


// while(szIn[i] != 0x00)			- Loop through string until we hit null byte
// if(szIn[i] < 0x7B && szIn[i] > 0x60)		- Only modify with hex vals 'a' - 'z'
// szIn[i++] -= 0x20				- Convert by subtracting 0x20
// X1 contains the null-terminated string
// X0 will have an empty array
LOOP:
	LDRB	W2, [X0], #1	// Load szIn[i] and offset by numBytes in X3
							// Use ! to overwrite value with null

// Check hex value for letter-case
	CMP		X2, #'z'		// Check if greater than 'z'
	BGT		STORE			// True - Branch to continue
	CMP		X2, #'a'		// Check if less than 'a'
	BLT		STORE			// True - Branch to continue
	SUB		W2, W2, 0x20	// Change to upper-case

STORE:
	STRB	W2, [X1], #1
	CMP		W2, 0x00
	BNE		LOOP
	
	

END:
	STR	X1, [X0]			// Returns the converted string in X0
	RET						// Return to the calling function
