// Style Sheet
// Programmer   : Jacob Campbell & Gregory Shane
// RASM #       : 3
// Purpose      : String Library - String_indexOf_2
// Date         : 3/21/2023

// Returns the index of first occurrence of the specified character in the string
// FROM the index number given provided by the user

// Preconditions 	- Pass a pointer to a string in memory through X0
//				 	- Pass a 1-byte character ascii value through X1
//					- Pass an int fromIndex val to determine starting point through X2
// Postconditions 	- Returns the index number of first occurrence of the character to X0
//					- If the character is not in the string, returns -1 to X0
// All registers except X3, X4, X5 are preserved

	.text
	.global String_indexOf_2

String_indexOf_2:

// while(szIn[i] != 0x00 &&
//		 szIn[i] != chIn)
// i++

LOOP:
	LDRB	W3, [X0, X2]	// Load szIn[i]
	CMP		X3, 0x00		// Check for null-terminator
	BEQ		NOT_FOUND		// Branch to NOT_FOUND
	CMP		X3, X1			// Check X2 == X1
	BEQ		END				// Branch to END
	ADD		X2, X2, #1		// i++
	B   	LOOP			// Branch to LOOP

NOT_FOUND:
	MOV	X2, #-1				// Change return val to -1

END:
	MOV	X0, X2				// Put index val in X0
	RET
