// Programmer: Jake Campbell and Gregory Shane
// CS3B - Spring 2023
// RASM 3
// Purpose: Program is designed to take input of three strings from user and conduct
//          various string comparisons and manipulations. Displaying results back to terminal.
// Last Modified: 3.14.2023


	.global _start		// sets starting point for program

	.EQU SIZE, 21		// constant int = 21

	.data
szPrompt:	.asciz	"Input sentence: "

szInput1:	.skip	21	// input for string1
szInput2:	.skip	21	// input for string2
szInput3:	.skip	21	// input for string3
szOutput:	.skip	21	// output string

str4ptr:	.quad	0	// string4 pointer
szSubstring:	.quad	0	// pointer for substring
bChar:		.byte	0	// char (for results of charAt subroutine)
concatPtr1:	.quad	0	// ptr for concat1
concatPtr2:	.quad	0	// ptr for concat2


szLength1:	.asciz	"S1.length() = "
szLength2:	.asciz	"S2.length() = "
szLength3:	.asciz	"S3.length() = "

szEqual1:	.asciz	"String_equals(s1,s3) = "
szEqual2:	.asciz	"String_equals(s1,s1) = "
szEqIC1:	.asciz	"String_equalsIgnoreCase(s1,s3) = "
szEqIC2:	.asciz	"String_equalsIgnoreCase(s1,s2) = "

szStrCopy:	.asciz	"s4 = String_copy(s1)\n"
szSub1:		.asciz	"String_substring_1(s3,4,14) = "
szSub2:		.asciz	"String_substring_2(s3,7) = "

szStr1:		.asciz	"s1 = "
szStr4:		.asciz	"s4 = "

szCharAt:	.asciz	"String_charAt(s2,4) = "

szStartsWith1:	.asciz	"String_startswWith_1(s1, 11, \"hat.\") = "
szStarts1:	.asciz	"hat."
szStartsWith2:	.asciz	"String_startsWith_2(s1, \"Cat\") = "
szStarts2:	.asciz	"Cat"

szEndsWith:	.asciz	"String_endsWith(s1, \"in the hat.\") = "
szEnds:		.asciz	"in the hat."

szIndexOf1:	.asciz	"String_indexOf_1(s2, 'g') = "
szIndexOf2:	.asciz	"String_indexOf_2(s2, 'g', 9) = "
szIndexOf3:	.asciz	"String_indexOf_3(s2, \"eggs\") = "

szLastIndexOf1:	.asciz	"String_lastIndexOf_1(s2, 'g') = "
szLastIndexOf2:	.asciz	"String_lastIndexOf_2(s2, 'g', 6) = "
szLastIndexOf3:	.asciz	"String_lastIndexOf_3(s2, \"egg\") = "
szIndexOfSubstring1:	.asciz	"eggs"
szIndexOfSubstring2:	.asciz	"egg"
szIndexOfIndex:		.skip	21

szReplace:	.asciz	"String_replace(s1, 'a', 'o') = "
szLower:	.asciz	"String_toLowerCase(s1) = "
szUpper:	.asciz	"String_toUpperCase(s1) = "

szConcat1:	.asciz	"String_concat1(s1, \" \");\n"
szConcat2:	.asciz	"String_concat2(s1, s2) = "
szSpace:	.asciz	" "

szTrue:		.asciz 	"TRUE"
szFalse:	.asciz	"FALSE"
chDq:		.byte	34	// ascii double quotes
chQt:		.byte	39	// ascii single quotes
chCr:		.byte	10	// ascii carriage return

	.text
// Prompting inputs
_start:
	LDR x0, =szPrompt	// points to szPrompt
	BL  putstring		// displays to terminal

	LDR x0,=szInput1	// points to szInput1
	MOV x1,#SIZE		// max input size is 21 characters
	BL  getstring		// CIN >> string1

	LDR x0,=szPrompt	// points to szPrompt
	BL  putstring		// displays to terminal

	LDR x0,=szInput2	// points to szInput2
	MOV x1,#SIZE		// max input size is 21 characters
	BL  getstring		// CIN >> string2

	LDR x0,=szPrompt	// points to szPrompt
	BL  putstring		// displays to terminal

	LDR x0,=szInput3	// points to szInput3
	MOV x1,#SIZE		// max input size is 21 characters
	BL  getstring		// CIN >> string3

// Converting string_length and displaying
	LDR x0,=szInput1	// points to szInput1
	BL  String_length	// string1.length()
	LDR x1,=szOutput	// points to szOutput
	BL  int64asc		// convers length and stores in szOutput

	LDR x0,=szLength1	// points to szLength1
	BL  putstring		// displays to terminal
	LDR x0,=szOutput	// points to szOutput
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0, =chCr		// points to carriage return
	BL  putch		// displays to terminal

	LDR x0,=szInput2	// points to szInput2
	BL  String_length	// string2.length()
	LDR x1,=szOutput	// points to szOutput
	BL  int64asc		// converts length and stores in szOutput

	LDR x0,=szLength2	// points to szLength2
	BL  putstring		// displays to terminal
	LDR x0,=szOutput	// points to szOutput
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

	LDR x0,=szInput3	// points to szInout3
	BL  String_length	// string3.length()
	LDR x1,=szOutput	// points to szOutput
	BL  int64asc		// converts length and stores in szOutput

	LDR x0,=szLength3	// points to szLength3
	BL  putstring		// displays to terminal
	LDR x0,=szOutput	// points to szOutput
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
// string_equals:
	LDR x0,=szEqual1	// points to szEqual1
	BL  putstring		// display to terminal

	LDR x0,=szInput1	// points to string1
	LDR x1,=szInput3	// points to string3
	BL  String_Equals	// String_equals(s1,s3)

	CMP x0,#1		// compare x0 to #1 (true)
	B.EQ trueEQ		// branch if equal

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	B   Eq2			// brnach to next part

trueEQ:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// String_equals:
Eq2:
	LDR x0,=szEqual2	// points to szEqual2
	BL  putstring		// displays to terminal

	LDR x0,=szInput1	// points to string1
	LDR x1,=szInput1	// points to strin1
	BL  String_Equals	// string_equals(s1,s1)

	CMP x0,#1		// compare x0 to #1 (true)
	B.EQ trueEq2		// branch if equal

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	B   EqIC		// branch to next part

trueEq2:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to cariage return
	BL  putch		// displays to terminal

// String_EqualsIgnoreCase(s1,s3)
EqIC:
	LDR x0,=szEqIC1		// points to szEqIC1
	BL  putstring		// displays to terminal

	LDR x0,=szInput1	// points to string1
	LDR x1,=szInput3	// points to string3
	BL  String_EqualsIC	// string_equalsIgnoreCase(s1,s3)

	CMP x0,#1		// compare to #1 (true)
	B.EQ trueEqIC		// branch if equals

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// display to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	B  EqIC2		// branch to next part

trueEqIC:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// display to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to termainl

// String_EqualsIgnoreCase(s1,s2)
EqIC2:
	LDR x0,=szEqIC2		// points to szEqIC2
	BL  putstring		// displays to terminal

	LDR x0,=szInput1	// points to string1
	LDR x1,=szInput2	// points to string2
	BL  String_EqualsIC	// string_equalsIgnoreCase(s1,s2)

	CMP x0,#1		// compare x0 to #1 (True)
	B.EQ trueEqIC2		// branch if equals

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	B   copy		// branch to next part

trueEqIC2:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// string_copy
copy:
	LDR x0,=szInput1	// points to string1
	BL  String_copy		// String_copy(s1)

	LDR x1,=str4ptr		// points to strign4
	STR x0,[x1]		// stores address of string4

	LDR x0,=szStrCopy	// points to szStrCopy
	BL  putstring		// displays to terminal

	LDR x0,=szStr1		// points to szStr1
	BL  putstring		// displays to terminal
	LDR x0,=szInput1	// points to szInput1
	BL putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

	LDR x0,=szStr4		// points to szStr4
	BL  putstring		// displays to terminal
	LDR x0,=str4ptr		// points sto str4ptr
	LDR x0,[x0]		// loads address stored for string4
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// free up memory from copy
	LDR x0,=str4ptr		// points to str4ptr
	LDR x0,[x0]		// loads address stored
	BL  free		// free allocated memory

// substring_1
	LDR x0,=szInput3	// points to string3
	MOV x1, #4		// starting index = 4
	MOV x2, #14		// ending index = 14
	BL  substring1		// substring(s3, 4, 14)

	LDR x1,=szSubstring	// points to subString
	STR x0,[x1]		// stores address of substring

	LDR x0,=szSub1		// points to szSub1
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// display to terminal
	LDR x0,=szSubstring	// points to szSubstring
	LDR x0,[x0]		// loads address stored
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// Free allocated memory
	LDR x0,=szSubstring	// points to szSubstring
	LDR x0,[x0]		// loads address stored
	BL  free		// free allocated memory

// substring_2
	LDR x0,=szInput3	// points to string3
	MOV x1, #7		// starting index = 7
	BL  substring2		// strng_substring2(s3, 7)

	LDR x1,=szSubstring	// points to szSubstring
	STR x0, [x1]		// stores address to substring

	LDR x0,=szSub2		// points to szSub2
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=szSubstring	// points to szSubstring
	LDR x0,[x0]		// loads address stored
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// free allocated memory
	LDR x0,=szSubstring	// points to szSubstring
	LDR x0,[x0]		// loads address stored
	BL  free		// free allocated memory

// charAt
	LDR x0,=szInput2	// points to strign2
	MOV x1, #4		// index = 4
	BL  charAt		// stirng_charAt(s2,4)

	LDR x1,=bChar		// points to bChar
	STR x0, [x1]		// stores results of charAt to bChar

	LDR x0,=szCharAt	// points to szCharAt
	BL  putstring		// display to terminal
	LDR x0,=chQt		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=bChar		// points to bChar
	BL  putch		// displays to terminal
	LDR x0,=chQt		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=chCr		// point to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// display to terminal

// String_startsWithIndex
	LDR x0,=szStartsWith1	// points to szStartsWith1
	BL  putstring		// display to terminal

	LDR x0,=szInput1	// points to string1
	LDR x1, =szStarts1	// points to prefix substring
	MOV x2, #11		// starting index = 11
	BL  startsWithIndex	// string_startsWithIndex(s1, 11, "hat.")

	CMP  x0, #1		// compare results to 1 (true)
	B.EQ trueSWI		// brnach if equals

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

	B   startsWith2		// branch to next part

trueSWI:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// Stirng_starWith
startsWith2:
	LDR x0,=szStartsWith2	// points to szStartsWtih2
	BL  putstring		// displays to terminal

	LDR x0,=szInput1	// points to string1
	LDR x1, =szStarts2	// points to prefix substring 2
	BL  startsWith		// string_startsWith(s1, "Cat")

	CMP x0, #1		// compare results with #1 (true)
	B.EQ trueSW		// branch if equals

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

	B  endsW		// branch to next part

trueSW:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// string_endsWith
endsW:
	LDR x0,=szEndsWith	// points to szEndsWith
	BL  putstring		// displays to temrinal

	LDR x0,=szInput1	// points to string1
	LDR x1,=szEnds		// points to suffix substring
	BL  endsWith		// string_endsWith(s1, "in the hat.")

	CMP x0, #1		// compare results to #1 (true)
	B.EQ trueEW		// branch if equals

// false
	LDR x0,=szFalse		// points to szFalse
	BL  putstring		// display to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch

	B  indexOf		// branch to next part

trueEW:
	LDR x0,=szTrue		// points to szTrue
	BL  putstring		// display to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// display to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// string_indexOf
indexOf:
//String_indexOf_1
	LDR	X0,=szIndexOf1	// *X0 = szIndexOf1
	BL	putstring		// Print szIndexOf1

	LDR	X0,=szInput2	// *X0 = Green eggs and ham.
	MOV	X1, #'g'		// X1 = 'g'
	BL	String_indexOf_1	// X0 = i

	LDR	X1,=szIndexOfIndex	// X1 = string ptr for index
	BL	int64asc			// X1 points to index

	LDR	X0,=szIndexOfIndex		// *X0 = index string
	BL	putstring			// Print index value

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

// String_IndexOf_2
	LDR	X0,=szIndexOf2		// *X0 = szIndexOf2
	BL	putstring			// Print szIndexOf2

	LDR	X0,=szInput2	// *X0 = Cat in the hat
	MOV	X1, 0x67		// X1 = 'g'
	MOV	X2, #9			// X2 = 9

	BL	String_indexOf_2	// X0 = index
	LDR	X1,=szIndexOfIndex	// X1 = string ptr for index
	BL	int64asc			// X1 points to index

	LDR	x0,=szIndexOfIndex		// *X0 = index string
	BL	putstring			// Print index value

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

// String_indexOf_3
	LDR	X0,=szIndexOf3		// *X0 = szIndexOf3
	BL	putstring			// Print szIndexOf3

	LDR	X0,=szInput2			// *X0 = Green eggs and ham.
	LDR	X1,=szIndexOfSubstring1	// X1 = 'eggs'

	BL	String_indexOf_3	// X0 = index
	LDR	X1,=szIndexOfIndex	// X1 = string ptr for index
	BL	int64asc			// X1 points to index

	LDR	X0, =szIndexOfIndex		// *X0 = index string
	BL	putstring			// Print index value

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

// String_lastIndexOf_1
	LDR	X0,=szLastIndexOf1	// *X0 = szLastIndexOf1
	BL	putstring			// Print szLastIndexOf1

	LDR	X0,=szInput2	// *X0 = Green eggs and ham
	MOV	X1, 0x67		// X1 = 'g'

	BL	String_lastIndexOf_1	// X0 = i
	LDR	X1,=szIndexOfIndex	// X1 = string ptr for index
	BL	int64asc			// X1 points to index

	LDR	X0, =szIndexOfIndex		// *X0 = index string
	BL	putstring			// Print index value

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

// String_lastIndexOf_2
	LDR	X0,=szLastIndexOf2		// *X0 = szIndexOf2
	BL	putstring			// Print szIndexOf2

	LDR	X0,=szInput2	// *X0 = Cat in the hat
	MOV	X1, 0x67		// X1 = 'g'
	MOV	X2, #6			// X2 = 6

	BL	String_lastIndexOf_2	// X0 = index
	LDR	X1,=szIndexOfIndex	// X1 = string ptr for index
	BL	int64asc			// X1 points to index

	LDR	X0, =szIndexOfIndex		// *X0 = index string
	BL	putstring			// Print index value

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

// String_lastIndexOf_3
	LDR	X0,=szLastIndexOf3		// *X0 = szIndexOf3
	BL	putstring			// Print szIndexOf3

	LDR	X0,=szInput2			// *X0 = Cat in the hat
	LDR	X1,=szIndexOfSubstring2		// X1 = 'egg'

	BL	String_lastIndexOf_3	// X0 = index
	LDR	X1,=szIndexOfIndex	// X1 = string ptr for index
	BL	int64asc			// X1 points to index

	LDR	X0, =szIndexOfIndex		// *X0 = index string
	BL	putstring			// Print index value

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed

	LDR	X0,=chCr			// Load line feed
	BL	putch				// Print line feed


// string_Replace
	LDR x0,=szInput1	// points to szInput1
	MOV x1, #'a'		// old char = a
	MOV x2, #'o'		// new char = o
	BL  String_replace	// String_replace(s1,'a','o')

	LDR x0,=szReplace	// points to szReplace
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=szInput1	// points to szInput1 (changed)
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// String_toLower
	LDR x0,=szLower		// points to szLower
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal

	LDR x0,=szInput1	// points to szInput1
	BL  toLowerCase		// String_toLowerCase(s1)
	BL  putstring		// display new string to terminal

	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// String_toUpper
	LDR x0,=szUpper		// points to szUpper
	BL  putstring		// displays to terminal
	LDR x0,=chDq		// points to double quote
	BL  putch		// displays to terminal

	LDR x0,=szInput1	// points to szInput1
	BL  toUpperCase		// string_toUpperCase(s1)
	BL  putstring		// displays new string to terminal

	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// String_concat
	LDR x0,=szConcat1	// point to szConcat1
	BL  putstring		// display to terminal

	LDR x0,=szConcat2	// point to szConcat2
	BL putstring		// display to terminal

	LDR x0,=chDq		// points to double quotes
	BL  putch

	LDR x0,=szInput1	// point to string1
	LDR x1,=szSpace		// point to szSpace
	BL  String_concat	// String_concat1(s1, " ")

	LDR x1,=concatPtr1	// point to concatPtr1
	STR x0, [x1]		// store address

	LDR x1,=szInput2	// point to szInput2
	BL  String_concat	// String_concat(s1, s2)

	LDR x1,=concatPtr2	// points to concatPtr2
	STR x0,[x1]		// store address
	BL  putstring		// display to terminal
	LDR x0,=chDq		// points to double quotes
	BL  putch		// displays to terminal

	LDR x0,=chCr		// points to carriage return
	BL  putch		// display to terminal
	LDR x0,=chCr		// points to carriage return
	BL  putch		// displays to terminal

// free allocated memeory
	LDR x0,=concatPtr1	// points to concatPtr1
	LDR x0, [x0]		// loads stored address
	BL  free		// free allocated memory

	LDR x0,=concatPtr2	// points to concatPtr2
	LDR x0,[x0]		// loads stored address
	BL  free		// free allocated memory

// preparing to exit program
	MOV x0,#0		// return code 0
	MOV x8,#93		// code #93 to terminate
	SVC 0			// call Linux to end program

	.end
