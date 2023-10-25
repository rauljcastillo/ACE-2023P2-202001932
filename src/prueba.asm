.radix 16
.model small
.stack
.data
    msg db "hola $"
    sprite db 0,0,0,05,05,0,0,0
           db 0,0,0,05,05,0,0,0
           db 05,05,05,05,05,05,05,05
           db 05,05,05,05,05,05,05,05
           db 05,0,0,05,05,0,0,05
           db 0,0,0,05,05,0,0,0
           db 0,0,0,05,05,05,05,0
           db 05,05,05,0,0,05,05,05
    
    player_x dw 5
    positionx dw 5
    mensaje db 0ah dup("$")
.code
.startup 
    mov ah,0ah
    mov dx,offset mensaje
    int 21

    mov ah,02
    mov dl,0a
    int 21

    mov ah,09
    mov dx,offset mensaje+2
    int 21
    salir:

.exit
end