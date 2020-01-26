ORG 00H

	MOV P2, #0FFH		   ; TURN ALL THE LED'S OFF

	AGAIN:

	MOV P2, #00000000B	   ; GLOW ALL THE LEDS
	ACALL DELAY
	MOV P2, #00000001B	   ; TURN LED1 OFF
	ACALL DELAY
	MOV P2, #00000011B	   ; TURN LED 1, 2 OFF
	ACALL DELAY
	MOV P2, #00000111B	   ; TURN LED 1, 2, 3 OFF 
	ACALL DELAY
	MOV P2, #00001111B	   ; TURN LED 1, 2, 3, 4 OFF
	ACALL DELAY
	MOV P2, #00011111B
	ACALL DELAY
	MOV P2, #00111111B
	ACALL DELAY
	MOV P2, #01111111B
	ACALL DELAY


	MOV P2, #11111110B	   ; TURN LED 1 ON
	ACALL DELAY
	MOV P2, #11111100B	   ; TURN LED 1, 2 ON
	ACALL DELAY
	MOV P2, #11111000B	   ; TURN LED 1, 2, 3 ON
	ACALL DELAY
	MOV P2, #11110000B
	ACALL DELAY
	MOV P2, #11100000B
	ACALL DELAY
	MOV P2, #11000000B
	ACALL DELAY
	MOV P2, #10000000B
	ACALL DELAY
	
	LJMP AGAIN


		DELAY:
		MOV R1, #5H
HERE3:  MOV R2, #50H
HERE2:	MOV R3, #50H
HERE :	DJNZ R3, HERE
		DJNZ R2, HERE2
		DJNZ R1, HERE3
		RET					; RETURN TO CALLING BLOCK
		END
