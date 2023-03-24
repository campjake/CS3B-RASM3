// Style Sheet
// Programmer   : Jacob Campbell & Craig Shane
// RASM #       : 3
// Purpose      : String Library - String_lastIndexOf_1
// Date         : 3/24/2023

// Returns the index of the last occurrence of the specified character

// Preconditions	- Pass a pointer to a string in memory
//					- Pass a 1-byte character ascii value
//					- Pass the fromIndex int value

// Postconditions	- returns an index number in X0
// Use of malloc in substring1 means that many registers can be modified

	.text
	.global String_lastIndexOf_2

String_lastIndexOf_2:
	STR		LR, [SP, #-16]!		// Push LR

	MOV		X19, X1				// Copy char to X19
	MOV		X1, #0				// Set beginIndex
								// X2 has endIndex
	BL		substring1			// Create substring
	MOV		X1, #19				// Copy char back to X1

	BL		String_lastIndexOf_1 // Get last index of new substring

	LDR		LR, [SP], #16		// Pop LR
	RET