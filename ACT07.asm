; ACT07.COM
; PROGRAMMED BY: @khalysst

.MODEL TINY
.386
.DATA
	a DB 0ah, 0dh, "            Odd & Even Numbers            $"
	b DB 0ah, 0dh, " Programmed by: @khalysst / GitHub, enjoy !$"
	c DB 0ah, 0dh, "Number 1: $"
	d DB 0ah, 0dh, "Number 2: $ "
	e DB 0ah, 0dh, "Number 3: $"
	f DB 0ah, 0dh, "Number 4: $"
	g DB 0ah, 0dh, "Number 5: $"
	h DB 0ah, 0dh, "Odd: $" 
	i DB 0ah, 0dh, "Even: $"
	PROMPT DB 0ah, 0dh, "Enter 5 Numbers: $"
	ATRY DB 0ah, 0dh, "Another Try [Y/N]: $"
	AGAIN DB 0ah, 0dh, "Only CHOOSE between Y/y, N/n. Please try AGAIN.$"
	SEP DB 0ah, 0dh, "============================================$"
	NUM DB 50 DUP(?)

.CODE
	ORG 100H
	

; ============================
	
BEGIN:
	; DECLARE ARRAY WITH THE POINTER SI REGISTER
	lea si,NUM 
	mov cx,5
	
	lea dx,SEP 
	mov ah,09h
	int 21h
	lea dx,a 
	mov ah,09h
	int 21h
	lea dx,b 
	mov ah,09h
	int 21h
	lea dx,SEP
	mov ah,09h
	int 21h
	
	; PROMPT USER TO ENTER ALL 5 NUMBERS
	lea dx,PROMPT 
	mov ah,09h
	int 21h
	
	push ax 
	call LINEFEED 
	pop ax
	
	; ASK FOR NUMBER 1
	lea dx,c 
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	
	call INPUT
	
	; ASK FOR NUMBER 2
	lea dx,d 
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	push ax 
	pop ax 
	
	call INPUT
	
	; ASK FOR NUMBER 3
	lea dx,e
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	call INPUT
	
	; ASK FOR NUMBER 4
	lea dx,f
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	call INPUT
	
	; ASK FOR NUMBER 5
	lea dx,g
	mov ah,09h
	int 21h
	mov ah,01h
	int 21h
	call INPUT
	
	call LINEFEED

; ============================

	xor ax,ax
	xor bx,bx
	xor cx,cx 
	
	; ASSIGNMENT OF VALUES IN REGISTERS
	lea si,NUM
	mov cx,5

	lea dx,h
	mov ah,09h
	int 21h
	
	; SEARCH FOR ODD OR EVEN NUMBERS AND CHECK IN THE LOOP
	
	ODD_CHECK:
		mov al,[si] 	; MOVE CONTENT OF THE ARRAY ELEMENT TO THE AL REGISTER 
		push ax
		TEST al,01		; ASSESS WHETHER IT IS ODD OR EVEN, 00 = EVEN, 01 = ODD, TEST IS AN IMPLIED AND INSTRUCTION
		JNZ PRINT_ODD	; IF IT IS NOT EQUAL TO = ODD
		JZ ODD_CONT		; IF IT EQUALS TO ZERO = EVEN 
		
	PRINT_ODD:
		pop dx			; PRINT THE NUMBER THAT WAS IN THE ARRAY
		mov ah,02h
		int 21h
		
		mov dl,20h
		mov ah,02h
		int 21h
		
	ODD_CONT:
	INC si				; INCREMENT THE POINTER, SI++
	LOOP ODD_CHECK
	

; ============================
	
	xor ax,ax 
	xor bx,bx
	xor cx,cx
	
	lea dx,i 
	mov ah,09h
	int 21h
	
	; REASSIGN VALUES IN REGISTERS
	lea si,NUM
	mov cx,5

	EVEN_CHECK:
		mov al,[si]
		push ax 
		TEST al,01		; ASSESS WHETHER IT IS ODD OR EVEN, 00 = EVEN, 01 = ODD		
		JZ PRINT_EVEN	; IF IT EQUALS TO ZERO = EVEN 
		JNZ EVEN_CONT	; IF IT IS NOT EQUAL TO = ODD
		
	PRINT_EVEN:
		pop dx
		mov ah,02h
		int 21h
		
		mov dl,20h
		mov ah,02h
		int 21h
		
	EVEN_CONT:
	INC si 
	LOOP EVEN_CHECK 
	
	call LINEFEED
	

; ============================
	
	TRY:
	
		lea dx,ATRY 
		mov ah,09h
		int 21h 
		mov ah,01h
		int 21h 
		
		cmp al,'Y' 
		JE BEGIN 
	
		cmp al,'y'
		JE BEGIN 
	
		cmp al,'n'
		JE EXIT 
	
		cmp al,'N'
		JE EXIT 
	
		lea dx,AGAIN
		mov ah,09h
		int 21h
		JMP TRY
		

; ============================

; ALL PROCEDURES 

INPUT:
	mov [si],al
	inc si
	RET
	
	
LINEFEED:
	mov ah,02h
	mov dl,0ah
	int 21h
	mov dl,0dh
	int 21h
	RET

; ============================

EXIT: 
	mov ah,4ch
	int 20h

END BEGIN 