;-------------------------------------	
;	LCD INTERFACING CODE IN 8BIT MODE
;====================================
LCD_DATA_PORT EQU	P0
RS	BIT	P2.0
EN 	BIT	P2.1
;====================================

ORG 0H

;------------------------------------
MAIN:
		ACALL	LCD_INIT
		MOV		DPTR, #STRING1
BACK1:	MOV		A, #00H
		MOVC	A, @A+DPTR
		JNZ		EXIT1
		
		ACALL	LCD_NEXT_ROW
		ACALL	DELAY

		MOV		R2,	#'2'
		MOV		R1, #'1'
		MOV		R0,	#'0'
L1:		MOV		DPTR, #STRING2
BACK2:	MOV		A, #00H
		MOVC	A, @A+DPTR
		JNZ		EXIT2	

		MOV		A, R1
		ACALL	LCD_WRITE_DATA
		ACALL	DELAY
		INC	R1
		MOV		A, #'='
		ACALL	LCD_WRITE_DATA
		ACALL	DELAY

		MOV		A, #00H
		MOV		A, R0
		ADD		A, R2
		SUBB	A, #48
		MOV		R0,	A
		ACALL	LCD_WRITE_DATA
		ACALL	DELAY
		ACALL	LCD_CLR
		ACALL	DELAY
		CJNE	R1, #'5', L1

LOOP:	SJMP	LOOP



EXIT1:	ACALL	LCD_WRITE_DATA
		ACALL	DELAY
		INC		DPTR
		SJMP	BACK1
		
EXIT2:	ACALL	LCD_WRITE_DATA
		ACALL	DELAY
		INC		DPTR
		SJMP	BACK2			


STRING1:	DB	"TABLE GENERATOR", 0
STRING2:	DB	"X*", 0
;-----------------------------------
MLOOP:
	SJMP MLOOP

;-----------------------------------
LCD_INIT:
	MOV		A, #38H					; THIS COMMAND TELLS LCD TO INITIALIZE 5x7 2LINE
	ACALL 	LCD_WRITE_CMD
	ACALL 	DELAY
	MOV		A, #0FH					; DISPLAY ON, CURSOR ON
	ACALL 	LCD_WRITE_CMD
	ACALL 	DELAY
	RET

LCD_CLR:
	MOV		A, #01H					; CLEAR ALL CHARACTERS FROM LCD DISPLAY #01H COMMAND IS USED
	ACALL 	LCD_WRITE_CMD
	RET

LCD_NEXT_ROW:
	MOV		A, #0C3H
	ACALL	LCD_WRITE_CMD
	RET	
	
LCD_WRITE_CMD:
	MOV		LCD_DATA_PORT, A		; THIS FUNCTION WILL PUT COMMAND INTO LCD'S COMMAND REGISTER
	CLR		RS
	SETB	EN
	NOP
	NOP
	NOP
	NOP
	CLR		EN
	RET	
	
LCD_WRITE_DATA:
	MOV 	LCD_DATA_PORT, A		; THIS FUNCTION WILL DISPLAY DATA ONTO LCD 
	SETB	RS
	SETB	EN
	NOP
	CLR		EN
	RET	
		
;===================================		
		
DELAY:
	MOV		R6, #255
D1L1:
	MOV		R7, #255
	DJNZ	R7, $
	DJNZ 	R6, D1L1
	RET

;===================================
END
