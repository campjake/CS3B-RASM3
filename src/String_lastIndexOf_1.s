// Style Sheet
// Programmer   : Jacob Campbell & Gregory Shane
// RASM #       : 3
// Purpose      : String Library - String_lastIndexOf_1
// Date         : 3/24/2023

// Returns the index of the last occurrence of the specified character

// Preconditions	- Pass a pointer to a string in memory
//					- Pass a 1-byte character ascii value

// Postconditions	- returns an index number in X0
// Only Registers X0, X1 are NOT preserved

	.text
	.global String_lastIndexOf_1

String_lastIndexOf_1:
	STR		X21, [SP, #-16]! // Push X21
	STR		X22, [SP, #-16]! // Push X22
	STR		LR, [SP, #-16]!	// Push LR
	
	MOV		X21, X0			// Copy string ptr to X21
	MOV		X22, X1			// Copy char to X22
	BL		String_length	// Get string length (i)
	SUB		X1, X0, #1		// Copy strlen - 1 to X1 to start at last char

LOOP:
	MOV		X0, X21			// Copy string ptr back to X0
	BL		charAt			// Get character at end
	CMP		X0, 0x00		// Check for null-terminator
	BEQ		NOT_FOUND		// Branch to NOT_FOUND
	CMP		X0, X22			// Check if X0 == X22
	BEQ		END				// Branch to END
	SUB		X1, X1, #1		// i--
	CMP		X1, #-1			// Check to see if we passed front of string
	BEQ		NOT_FOUND		// Branch to NOT_FOUND
	B		LOOP			// Branch to loop

NOT_FOUND:
	MOV		X0, #-1			// Return error code

END:
	MOV		X0, X1			// Copy index value to X0
	LDR		LR, [SP], #16	// Pop LR
	LDR		X22, [SP], #16  // Pop X22
	LDR		X21, [SP], #16	// Pop X21
	RET