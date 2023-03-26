// Style Sheet
// Programmer   : Jacob Campbell & Greg Shane
// RASM #       : 3
// Purpose      : String Library - String_lastIndexOf_1
// Date         : 3/24/2023

// This function returns the index of the last occurrence of string str

// Preconditions	- X0 contains a pointer to the string
//					- X1 contains a substring to check if its in X0
// Postconditions	- X0 will contain the index of where the matching substring starts

// Due to the use of malloc, all caller-saved registers MAY be changed

	.text
	.global String_lastIndexOf_3

String_lastIndexOf_3:
	STR		X19, [SP, #-16]!	// Push X19
	STR		X20, [SP, #-16]!	// Push X20
	STR		X21, [SP, #-16]!	// Push X21
	STR		X22, [SP, #-16]!	// Push X22
	STR		X23, [SP, #-16]!	// Push X23
	STR		X24, [SP, #-16]!	// Push X24
	STR		LR, [SP, #-16]!		// Push LR

	MOV		X19, X0				// Copy string
	MOV		X20, X1				// Copy substring
	MOV		X21, #0				// init i = 0
	MOV		X22, #0				// init j = 0

// Check for matching char, starting at last index of string
// minus the length of substring (it cannot match before then)
	BL		String_length		// String length of string
	MOV		X23, X0				// Save string length to X23

	MOV		X0, X1				// Move substring to X0
	BL		String_length		// String length of substr in X0
	SUB		X21, X0, X23		// i = string_length - substring_length

	LDRB	W2, [X20]			// Get base address of substring

LOOP:
	LDRB	W1, [X19, X21]		// W1 = char of string[i]
	CMP		W1, 0x00			// Check if hit null term
	BEQ		NOT_FOUND			// Branch to NOT_FOUND

	
	MOV		X24, X21			// Copy i to X24
	SUB		X21, X21, #1		// i--
	CMP		X21, #-1			// Check if we passed front of string
	BEQ		NOT_FOUND			// Branch to NOT_FOUND

	CMP		W1, W2				// string[i] == substring[0]
	BNE		LOOP				// Branch back to LOOP

COMPARE:
	LDRB	W1, [X19, X24]		// Load string[k]
	LDRB	W3, [X20, X22]		// Load substring[j]

	CMP		W2, 0x00			// Check for null term
	BEQ		FOUND				// Branch if found

	ADD		X24, X24, #1		// k++
	ADD		X22, X22, #1		// j++

	CMP		W1, W2				// string[k] == string[j]
	BEQ		COMPARE				// Branch back to COMPARE

	LDRB	W2, [X20]			// Load substring base address
	MOV		X22, #0				// init j = 0
	BNE		LOOP				// Branch back to loop

NOT_FOUND:
	MOV		X0, #-1				// Return -1 if not found
	B		END					// Branch to end

FOUND:
	SUB		X0, X21, #1			// i--

END:
	LDR		LR, [SP], #16		// Pop LR
	LDR		X24, [SP], #16		// Pop X24
	LDR		X23, [SP], #16		// Pop X23
	LDR		X22, [SP], #16		// Pop X22
	LDR		X21, [SP], #16		// Pop X21
	LDR		X20, [SP], #16		// Pop X20
	LDR		X19, [SP], #16		// Pop X19
	RET