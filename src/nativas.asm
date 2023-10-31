cursor MACRO row,col
    mov dh,row
    mov dl,col
    mov bh,0
    mov ah,02
    int 10
ENDM

print MACRO cadena
    mov ah,09
    mov dx,offset cadena
    int 21
ENDM

printchar MACRO char
    mov ah,02
    mov dl,char
    int 21
ENDM
;Delay para el encabezado principal
delaym macro
    local uno1,dos1,salir1
    mov di,3e8h
    uno1:
        dec di
        jz salir1
        mov si,9c4h
        dos1:
            dec si
            jnz dos1
            jmp uno1
        salir1:        
endm

delay5s macro
    local uno1,dos1,salir1
    mov di,0bb8h
    uno1:
        dec di
        jz salir1
        mov si,9c4h

        dos1:
            dec si
            jnz dos1
            jmp uno1
    salir1:
            
endm



limpiarPantalla macro
    mov ah,06
    mov al,0
    mov cx,00
    mov dx,184f
    int 10
endm

verificarUser macro
    mov si,offset buffer_user+2
    mov di,offset admin
    comparar_us:
        mov bl,[si]
        cmp bl,0dh
        jz temp1

        cmp bl,[di]
        jz labeltemp
        jmp salirv
    labeltemp:
        cmp bl,'$'
        jz labeltemp1
        inc di
        inc si
        jmp comparar_us
    temp1:
        inc si
        jmp comparar_us
    labeltemp1:
        mov si,offset buffer_pass+2
        mov di,offset passw
    
    comparar_p:
        mov bl,[si]
        cmp bl,0dh
        jz temp
        cmp bl,[di]
        jz labeltemp2
        mov cx,0
        jmp salirv
    temp:
        inc si
        jmp comparar_p

    labeltemp2:
        cmp bl,'$'
        jz validar
        inc si
        inc di
        jmp comparar_p
    
    validar:
        mov cx,01

    salirv:

endm

toascii macro
    local convertir,cifra1,cifra2,cifra3,cifra4,cifra5,salir1,complemento,sa
    mov di,offset numero
    convertir:  
        cmp ax,0a
        jb cifra1

        cmp ax,64
        jb cifra2

        cmp ax,3e8
        jb cifra3

        cmp ax,2710
        jb cifra4

        cmp ax,0ffff
        jb cifra5

        cifra1:
            add ax,30
            mov [di],al
            jmp salir1
        cifra2:
            mov bl,0a
            div bl

            add al,30
            add ah,30

            mov [di],al
            mov [di+1],ah
            jmp salir1

        cifra3:
            mov bl,64
            div bl
            add al,30
            mov [di],al
            inc di

            ;Segundo digito
            xor bx,bx
            mov al,ah
            mov ah,0

            mov bl,0a
            div bl

            add al,30
            add ah,30

            mov [di],al
            mov [di+1],ah
            jmp salir1
                
                
        cifra4:
            xor dx,dx
            mov bx,3e8
            div bx
                    
            add al,30
                    
            mov [di],al
            inc di
                    
            xor ax,ax
            mov ax,dx
            xor dx,dx
                    
            cmp ax,64
            jae cifra3
            mov bl,'0'
            mov [di],bl
            inc di       
            jmp cifra2
                    
        cifra5:
            mov bx,2710
            div bx
                    
            add al,30
            mov [di],al
            inc di
                    
            xor ax,ax
            mov ax,dx
            xor dx,dx
            jmp cifra4
        salir1:
endm