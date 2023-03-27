// Style Sheet
// Programmer   : Jacob Campbell & Gregory Shane
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
	STR		X19, [SP, #-16]!	// Push X19
	STR		X20, [SP, #-16]!	// Push X20
	STR		X21, [SP, #-16]!	// Push X21
	STR		LR, [SP, #-16]!		// Push LR

	MOV		X19, X1			// Copy char to X19
	MOV		X1, #0			// Set beginIndex
						// X2 has endIndex
	BL		substring1		// Create substring with dynamic memory
	MOV		X20, X0			// Copy addreess of dyn alloc string so we don't lose it
	MOV		X1, X19			// Copy char back to X1

	BL		String_lastIndexOf_1	// Get last index of new substring
	MOV		X21, X0			// Copy index to X21 so we don't lose it

	MOV		X0, X20			// Load the dyn allocated string to X0
	BL		free			// Free the dynamically allocated mem

	MOV		X0, X21			// Copy index back to X0 for return

	LDR		LR, [SP], #16		// Pop LR
	LDR		X21, [SP], #16		// Pop X21
	LDR		X20, [SP], #16		// Pop X20
	LDR		X19, [SP], #16		// Pop X19

	RET					// Return to calling fcn

	.end
