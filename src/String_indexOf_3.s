// Style Sheet
// Programmer	: Jacob Campbell & Greg Shane
// RASM #		: 3
// Purpose		: String Library
// Date			: 3/22/2023

// indexOf_3(String string1, String subString): int
// Preconditions	- Pointer to a string in X0
//					- Pointer to a substring in X1
// Postconditions	- Returns an int in X0 for where the first occurrence of the
//						substring X1 in the string from X0
// All Registers except X0, X1, X2, X4-7, X9 are preserved

	.text
	.global String_indexOf_3

String_indexOf_3:
	STR		X19, [SP, #-16]!	// Push X19
	STR		X20, [SP, #-16]!	// Push X20
	STR		X21, [SP, #-16]!	// Push X21
	STR		X22, [SP, #-16]!	// Push X22
	STR		X23, [SP, #-16]!	// Push X23
	STR		LR, [SP, #-16]!		// Push LR

	MOV		X19, #0		// Initialize i
 	MOV		X20, X0		// szIn to X20
 	MOV		X21, X1		// szSubStr to X21

	MOV		X0, X1			// Put szSubStr in X0
	BL		String_length	// Get string length of szsubstr
	MOV		X22, X0			// Save it to X22

LOOP:
// Find where a matching character is
	MOV		X0, X20				// *X0 = szIn
	LDRB	W1, [X21]			// W1 = szSubStr[0]
	MOV		X2, X19				// Copy beginIndex to X2
	BL		String_indexOf_2	// Find index where matching char
	CMP		X0, #-1				// Check if hit null term
	BEQ		END					// Branch to end
	MOV		X1, X0				// X1 = i (index of matching character)

// Create a substring of length substr from the original string
// Error check to make sure we don't go out of bounds
	MOV		X0, X20				// Retrieve szIn
	BL		String_length		// Get string length

	MOV		X2, X22				// Retrieve length of substr
	ADD		X2, X2, X1			// Offset end index by start index

// Error check
	CMP		X0, X2				// Check if string lengths match
	BNE		INCR				// Don't go out of bounds if not the same
	MOV		X0, X20				// Retrieve szIn b/c its safe to make substring
	BL		substring1			// Create a substring to check for a match

// Invoke String_Equals to check if the strings match	
	MOV		X1, X21				// X1 = *szSubStr

	BL		String_Equals		// Check if equal
	CMP		X0, #1				// if True
	BEQ		END					// Branch to return index value i

INCR:
	ADD		X19, X19, #1		// ++i
	B		LOOP				// Branch to LOOP

END:
	LDR		LR, [SP], #16		// POP LR
	LDR		X22, [SP], #16		// POP X22
	LDR		X21, [SP], #16		// POP X21
	LDR		X20, [SP], #16		// Pop X20
	LDR		X19, [SP], #16		// Pop X19

	RET