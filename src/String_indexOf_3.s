// Style Sheet
// Programmer	: Jacob Campbell & Greg Shane
// RASM #		: 3
// Purpose		: String Library
// Date			: 3/22/2023

// indexOf_3(String string1, String subString): int
// Preconditions	- Pointer to a string in X0
//					- Pointer to a substring in X1
// Postconditions	- Returns an int in X0 for wher the first occurrence of the
//						substring X1 in the string from X0
// All Registers except X0, X1, X2, X4-7, X9 are preserved

	.text
	.global String_indexOf_3

String_indexOf_3:
	STR		LR, [SP, #-16]!	// Push LR

	MOV		X2, #0		// Initialize i
 	MOV		X4, X0		// szIn to X4
 	MOV		X5, X1		// szSubStr to X5

LOOP:
	LDRB	W1, [X5]			// W1 = szSubStr[0]
	BL		String_indexOf_2	// Find index where matching char
	CMP		X0, #-1				// Check if hit null term
	BEQ		END					// Branch to end
	
	MOV		X6, X0				// X6 = i
	LDR		X0, [X4, X6]		// X0 = szIn[i -> end]
	MOV		X1, X5				// X1 = *szSubStr

	BL		String_Equals		// Check if equal
	CMP		X0, #1				// if True
	BEQ		END					// Branch to return index value i
	// else	
	ADD		X2, X6, #1			// X2 = ++i
	MOV		X0, X4				// X0 = *szIn
	B		LOOP				// Branch to LOOP

END:
	LDR		LR, [SP], #16		// POP LR
	RET