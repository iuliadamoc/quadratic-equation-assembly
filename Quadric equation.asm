.model small
.stack 200h
.data
    a dw 0
    b dw 0
    c dw 0
	steagA db 0
	steagB db 0
	steagC db 0
	delta dw 0
	radical dw 0
    x1 dw 0
    x2 dw 0
	sqrt dw 0
	count dw 1
	mesaj db ' Introduceti coeficientii ecuatiei: $'
	mesaj1 db " Ecuatia este: $"
	mesaj2 db "x^2+$"
	mesaj3 db "x+$"
	mesaj4 db " Delta este: $"
	mesaj5 db " Radical din delta este: $"
	mesaj6 db " Solutia este: $"
	mesaj7 db " Delta negativ. Solutii complexe. $"
	mesaj8 db " A-ul este 0. Ecuatia este de gradul 1. $"
.code
		registerClear proc
        mov ax, 0
        mov bx, 0
        mov cx, 0
        mov dx, 0
        ret
		endp
		
    
main:
        call registerClear
		
		mov ax, @data
		mov ds, ax
		
		CereCoeficienti macro string
            mov ah, 9h
            mov dx, offset string
            int 21h
        endm
		
		linieNoua macro
			mov ah, 02h
			mov dl, 0ah
			int 21h
			mov dl, 0dh
			int 21h
		endm

		CereCoeficienti mesaj    ;Cerut de coeficienti pt ecuatie
		linieNoua
				
		mov cx, 10     
		mov bh, 0     

    ;INTRODUCEREA COEFICIENTILOR
    citireA:
			mov ah, 01h
			int 21h
			
			cmp al, 13      
			je citireB   
			
			cmp al, 45			
			jne nuEminusA		
				mov steagA, 1	
				jmp citireA
			nuEminusA:
			
			sub al, 48
			mov bl, al
			
			mov ax, a  
			mul cx
			
			
			add ax, bx
			mov a, ax
		jmp citireA
				
		mov ax, @data
		mov ds, ax
		
		mov cx, 10     
		mov bh, 0     
		
				
		citireB:
			mov ah, 01h
			int 21h
			
			cmp al, 13      
			je citireC
			
			cmp al, 45			
			jne nuEminusB		
				mov steagB, 1	
				jmp citireB
			nuEminusB:
			
			sub al, 48
			mov bl, al
			
			mov ax, b  
			mul cx
			
			
			add ax, bx
			mov b, ax
		jmp citireB
		
		mov ax, @data
		mov ds, ax
		
		mov cx, 10    
		mov bh, 0     
		
		citireC:
			mov ah, 01h
			int 21h
			
			cmp al, 13      
			je continua   
			
			cmp al, 45			
			jne nuEminusC		
				mov steagC, 1	
				jmp citireC
			nuEminusC:
			
			sub al, 48
			mov bl, al
			
			mov ax, c  
			mul cx
			
			
			add ax, bx
			mov c, ax
		jmp citireC

  continua:
  
	mov bl, steagA
	cmp bl, 1	;verificam daca este cu minus
	jne estePlusA	
		mov ax, 0
		mov bx, a
		sub ax, bx
		mov a, ax
	estePlusA:		
	
	mov bl, steagB
	cmp bl, 1	;verificam daca este cu minus
	jne estePlusB	
		mov ax, 0
		mov bx, b
		sub ax, bx
		mov b, ax
	estePlusB:		
	
	mov bl, steagC
	cmp bl, 1	
	jne estePlusC	
		mov ax, 0
		mov bx, c
		sub ax, bx
		mov c, ax
	estePlusC:		
	
	mov bx, 0
	
	cmp a, bx
	jne AnuEzero
	
	cmp a, bx
	je Azero
	
	Azero:
		mov dx, offset mesaj8   ;afisare sol 2 este
		  mov ah, 09h
		  int 21h
		  
	jmp exit1
	
	AnuEzero:
	
	;AFISARE ECUATIE
	  
  	mov dx, offset mesaj1   ;afisare ecuatia este
		  mov ah, 09h
		  int 21h
		  
		  ;afisare a
		  
	mov ax, a               
	
		cmp ax, 0		;vedem daca este negativ
		jge afisPozA	;sari daca e mai mare sau egal
		
			mov ah, 02	
			mov dl, 45	
			int 21h		
		
			mov ax, 0
			mov bx, a
			sub ax, bx
			
		afisPozA:
	
		mov bx, 10
		mov cx, 0
		
		descompuneA:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifreA
		jmp descompuneA
		
		afisareCifreA:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifreA

	mov dx, offset mesaj2      ;afisare x^2+
		  mov ah, 09h
		  int 21h
		  
		 ;afisare b
		 
	mov ax, b        
	
		cmp ax, 0		
		jge afisPozB	
		
			mov ah, 02	
			mov dl, 45	
			int 21h		
		
			mov ax, 0
			mov bx, b
			sub ax, bx
			
		afisPozb:
	
		mov bx, 10
		mov cx, 0
		
		descompuneB:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifreB
		jmp descompuneB
		
		afisareCifreB:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifreB	  
		  
	mov dx, offset mesaj3  ;afisare x+
		  mov ah, 09h
		  int 21h
		  
		  ;afisare c
		  
	mov ax, c         
	
		cmp ax, 0		
		jge afisPozC	
		
			mov ah, 02	
			mov dl, 45	
			int 21h		
		
			mov ax, 0
			mov bx, c
			sub ax, bx
			
		afisPozc:
	
		mov bx, 10
		mov cx, 0
		
		descompuneC:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifreC
		jmp descompuneC
		
		afisareCifreC:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifreC
		
	linieNoua
	
	;calculate discriminant
	mov dx, 0
	mov ax, b
	imul b
	mov delta, ax     ;delta=b^2
	mov dx, 0
	mov ax, a
	imul c
	
	mov dx, 0
	mov bx, ax
	mov ax, 4
	imul bx
	
	
	
	sub delta, ax     ;bx=b^2-4ac
	
	mov bx, 0
		cmp delta, bx
		jge continuare
		
		cmp delta, bx
		jl no_solutions
		
		no_solutions:
		mov dx, offset mesaj7   ;afisare *nu se poate*
		  mov ah, 09h
		  int 21h
		  jmp exit1
		
		continuare:
		
	mov dx, offset mesaj4  ;afisare *Delta este*
		  mov ah, 09h
		  int 21h
		
	;afisare delta
		mov ax, delta
		mov bx, 10
		mov cx, 0
		
		descompuneDelta:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifreDelta
		jmp descompuneDelta
		
		afisareCifreDelta:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifreDelta
		
	linieNoua
		
   Calcul_Radical:
	   mov ax, delta         
    mov bx, ax            

	
    loopIt :
        sub bx, count      ; numaratoarea incepe cu 1, 3, 5, 7, 9
        inc count           ; count = par
        inc count           ; count = impar
        inc sqrt            
        mov ax, sqrt
        cmp bx, 0
        js timetoReturn     
        jnz loopIt


    timetoReturn :
        mov radical, ax            
	
	;mov radical, bx
	
		mov dx, offset mesaj5   ;afisare radicalul este
		  mov ah, 09h
		  int 21h	
		  
		  ;afisare radical
		  
	mov ax, radical       
		mov bx, 10
		mov cx, 0
		
		descompuneradical:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifreradical
		jmp descompuneradical
		
		afisareCifreradical:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifreradical
		
	linieNoua
	
	
	
	mov bx, 0
	cmp delta, bx
	je CalculSolutie2
	
	mov dx, offset mesaj6   ;afisare sol 1 este
		  mov ah, 09h
		  int 21h
	
	;CalculSolutie1:
		
		mov bx, a
		mov ax, 2
		mul bx
		
		mov bx, ax
		
		mov ax, radical
		sub ax, b
		cwd
		idiv bx
		
		mov x1, ax
		
	;end CalculSolutie1
	
	mov ax, x1               ;afisare x1
	
		cmp ax, 0		;vedem daca este negativ
		jge afisPoz1x	
		
			mov ah, 02	
			mov dl, 45	
			int 21h		
		
			mov ax, 0
			mov bx, x1
			sub ax, bx
			
		afisPoz1x:
	
		mov bx, 10
		mov cx, 0
		
		descompune1x:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifre1x
		jmp descompune1x
		
		afisareCifre1x:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifre1x
		
	linieNoua	
	;am afisat prima solutie
	
	CalculSolutie2:
	
	mov dx, offset mesaj6   ;afisare sol 2 este
		  mov ah, 09h
		  int 21h
			
		mov bx, a
		mov ax, 2
		mul bx
		
		mov bx, ax
		
		mov ax, 0
		sub ax, radical
		sub ax, b
		cwd
		idiv bx
		
		mov x2, ax
		
	;end CalculSolutie2
	
	mov ax, x2               ;afisare x2
	
		cmp ax, 0		
		jge afisPoz2x	
		
			mov ah, 02	
			mov dl, 45	
			int 21h		
		
			mov ax, 0
			mov bx, x2
			sub ax, bx
			
		afisPoz2x:
	
		mov bx, 10
		mov cx, 0
		
		descompune2x:
			mov dx, 0
			div bx
			push dx
			inc cx
			cmp ax, 0
			je afisareCifre2x
		jmp descompune2x
		
		afisareCifre2x:
			pop dx
			add dl, 48
			mov ah, 02
			int 21h
		loop afisareCifre2x
	
	linieNoua
	;am afisat solutia 2
	
	jmp exit1
	
			
exit1:
    mov ah, 4ch
    int 21h
end main