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
.code
.startup 
    mov dx,05
    cmp dx,player_x
    jz salir
    jmp salir1

    salir:
        mov ah,09
        mov dx,offset msg
        int 21
    salir1:

.exit
end