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
// All Registers except X0 - X3 are preserved

	.text
	.global String_indexOf_3

String_indexOf_3:
	STR		X19, [SP, #-16]!	// Push X19
	STR		X20, [SP, #-16]!	// Push X20
	STR		X21, [SP, #-16]!	// Push X21
	STR		X22, [SP, #-16]!	// Push X22
	STR		X23, [SP, #-16]!	// Push X23
	STR		LR, [SP, #-16]!		// Push LR

	MOV		X19, X0		// Copy string
 	MOV		X20, X1		// Copy substring
 	MOV		X21, #0		// init i = 0
	MOV		X22, #0		// init j = 0

	LDRB	W2, [X20]	// Get base address of substring

LOOP:
// Find where a matching character is
	LDRB	W1, [X19, X21]		// Get a char of string at index i
	CMP		X1, 0x00			// Check if hit null term
	BEQ		NOT_FOUND			// Branch to NOT_FOUND
	
	CMP		W1, W2				// CMP characters of string and substring
	MOV		X23, X21			// Copy i to X23
	ADD		X21, X21, #1		// i++
	BNE		LOOP				// Branch back to loop

COMPARE:
	LDRB	W1, [X19, X23]		// Load string[k]
	LDRB	W3, [X20, X22]		// Load substring[j]

	CMP		W2, 0x00			// Check for null term
	BEQ		FOUND				// Branch if found

	ADD		X23, X23, #1		// k++	(k is copy of i)
	ADD		X22, X22, #1		// j++

	CMP		W1, W2				// string[k] == string[j]
	BEQ		COMPARE				// Branch back to COMPARE

	LDRB	W2, [X20]			// Load substring base address
	MOV		X22, #0				// init j = 0
	B.NE	LOOP				// Branch back to LOOP

NOT_FOUND:
	MOV		X0, #-1				// Return -1 if not found
	B		END					// Branch to end

FOUND:
	SUB		X0, X21, #1			// i--

END:
	LDR		LR, [SP], #16		// Pop LR
	LDR		X23, [SP], #16		// Pop X23
	LDR		X22, [SP], #16		// Pop X22
	LDR		X21, [SP], #16		// Pop X21
	LDR		X20, [SP], #16		// Pop X20
	LDR		X19, [SP], #16		// Pop X19
	RET