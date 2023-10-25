cursor MACRO row,col
    mov dh,row
    mov dl,col
    mov bh,0
    mov ah,02
    int 10
ENDM

print MACRO cadena
    mov ah,09
    lea dx,cadena
    int 21
ENDM

printchar MACRO char
    mov ah,02
    mov dl,char
    int 21
ENDM

delaym macro
    retraso:
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

limpiarPantalla macro
    mov ax,06
    mov cx,00
    mov dx,184f
    int 10
endm