// Style Sheet
// Programmer   : Jacob Campbell & Craig Shane
// RASM #       : 3
// Purpose      : String Library - String_indexOf_1
// Date         : 3/21/2023

// Returns the index of first occurrence of the specified character in the string

// Preconditions 	- Pass a pointer to a string in memory through X0
//				 	- Pass a 1-byte character ascii value through X1
// Postconditions 	- Returns the index number of first occurrence of the character to X0
//					- If the character is not in the string, returns -1 to X0
// All registers except X3, X4, X5 are preserved

	.text
	.global String_indexOf_1

String_indexOf_1:
	MOV		X5, #0		// Initialize index counter i = 0
	
// while(szIn[i] != 0x00 &&
//		 szIn[i] != chIn)
// i++

LOOP:
	LDRB	W2, [X0, X5]	// Load szIn[i]
	CMP		X2, 0x00		// Check for null-terminator
	BEQ		NOT_FOUND		// Branch to NOT_FOUND
	CMP		X2, X1			// Check X2 == X1
	BEQ		END				// Branch to END
	ADD		X5, X5, #1		// i++

NOT_FOUND:
	MOV	X5, #-1				// Change return val to -1

END:
	MOV	X0, X5				// Put index val in X0
	RET