drawtab macro
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
    
    ;Row major para colocar el carro
    mov positionx,0
    mov positiony,18
    mov di,offset table
    push di
    mov ax,positionx
    mov bl,08
    div bl          ;Almaceno en table valores de 0 a 39 para columnas y 0 a 24 para filas 
    mov [di],al

    mov ax,positiony
    div bl
    mov [di+1],al
    mov bx,offset sprite_carro
    call print_sprite

    ;Segundo carro
    pop di
    inc di
    inc di
    mov positionx,0
    mov positiony,28

    mov ax,positionx
    mov bl,08
    div bl          ;Almaceno en table valores de 0 a 39 para columnas y 0 a 24 para filas 
    mov [di],al

    mov ax,positiony
    div bl
    mov [di+1],al
    mov bx,offset sprite_carro
    call print_sprite

    ;Fin
endm