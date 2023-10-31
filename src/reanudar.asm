reanu macro
    local pintar_carril,pintar_aceras1,pintar_aceras2,interior
    mov positionx,0
    mov positiony,8
    mov cx,28
    
    pintar_aceras1:
        mov bx,offset sprite_banqueta
        push cx
        call print_sprite
        mov dx,08
        pop cx
        
        add positionx,dx
        loop pintar_aceras1

    mov positionx,0
    mov positiony,10
    mov cx,15h
    pintar_carril:
        push cx
        mov cx,28
        
        interior:
            mov bx,offset sprite_carril
            push cx
            call print_sprite
            pop cx
            mov dx,08
            add positionx,dx
            loop interior
            
            pop cx
            mov positionx,0
            mov dx,08
            add positiony,dx
            loop pintar_carril

    mov positionx,0
    mov positiony,0b8h
    mov cx,28
    
    pintar_aceras2:
        mov bx,offset sprite_banqueta
        push cx
        call print_sprite
        mov dx,08
        pop cx
        add positionx,dx
        loop pintar_aceras2



    mov bx,player_x
    mov positionx,bx
    mov bx,player_y
    mov positiony,bx
    mov bx,offset spritej_carril
    call print_sprite

    mov cx,02
    mov di,offset table
    pintar_carro:
        xor ax,ax
        mov al,[di]
        mov bx,08
        mul bx
        mov positionx,ax

        xor ax,ax
        mov al,[di+1]
        mov bx,08
        mul bx
        mov positiony,ax
        mov bx,offset sprite_carro
        call print_sprite
        inc di
        inc di
        loop pintar_carro
endm