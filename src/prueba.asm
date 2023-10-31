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
    puntos db 05
.code
.startup 
    cmp puntos,03
    jz nada

    nada:
        
    

.exit
end