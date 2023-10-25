mover MACRO
    ;local bucle,salir,verificar,bajar,subir,retraso
    mov cx,02
    mov di,offset table
    bucle: 
        push cx
        push di
        call borrar
        pop di
        push di
        call verificar
        
        pop di
        pop cx
        inc di
        inc di
        loop bucle
    jmp salir
    
    verificar:
        xor dx,dx
        xor bx,bx
        mov dl,[di]
        cmp dx,27h
        jz bajar

    
        mov bl,[di]
        inc bl
        mov [di],bl

        mov ax,bx
        mov bx,08
        mul bx
        
        mov positionx,ax

        ;Colocar en Posicion y
        mov dl,[di+1]
        mov ax,dx
        mul bx
        mov positiony,ax

        call colision
        
        mov bx,offset sprite_carro
        call print_sprite
        ret

        bajar:
            mov dl,[di+1]
            cmp dl,18
            jz subir

            mov dx,0
            mov [di],dl         ;Si llega al final del carril que baje un carril y empiece desde la izquierda
            mov positionx,0

            xor bx,bx
            mov bl,[di+1]
            inc bl
            mov [di+1],bl
            mov ax,bx
            mov bx,08
            mul bx
            mov positiony,ax

            mov bx,offset sprite_carro
            call print_sprite
            ret
        subir:
            mov dx,0
            mov [di],dx
            mov dx,10
            mov [di+1],dx
            mov positionx,0
            mov positiony,10
            mov bx,offset sprite_carro
            call print_sprite
            ret
    colision:
        mov bx,positionx
        mov cx,positiony

        cmp bx,player_x
        jz one
        jmp notcolision
        one:
            cmp cx,player_y
            jz colision1
            jmp notcolision

        colision1:
            push positionx
            push positiony
            mov player_x,0
            mov player_y,0b0h
            mov positionx,0
            mov positiony,0b0h
            mov bx,offset spritej_carril
            call print_sprite
            call calcularvid1
            pop positiony
            pop positionx
            ret
        notcolision:
            ret


    borrar:
        mov dx,08
        xor bx,bx
        mov bl,[di]
        mov ax,bx
        mul dx

        mov positionx,ax

        mov bl,[di+1]
        mov dx,08
        mov ax,bx
        mul dx
        mov positiony,ax
        mov bx,offset sprite_carril
        call print_sprite
        ret

    retraso:
        mov di,0fah
        mov ah,01
        int 16
        uno:
            dec di
            jz salir1
            mov si,3e8h

            dos:
                dec si
                jnz dos
                jmp uno
        salir1:
            ret


    calcularvid1:
        ;Calcular vidas
            mov dx,03
            cmp dl,numvida
            jz vida2
            dec dx
            cmp dl,numvida
            jz vida1
            dec dx
            cmp dl, numvida
            jz gamover

            vida21:
                mov ah,09
                mov dx,offset mens1
                int 21
                mov di,offset vidas
                mov dx,'X'
                mov [di+7],dx
                cursor 0,10
                print vidas
                dec numvida
                ret

            vida11:
                mov di,offset vidas
                mov dl,'X'
                mov [di+4],dx
                dec numvida
                cursor 0,10h
                print vidas
                ret
            gamover1:
                mov di,offset vidas
                mov dl,'X'
                mov [di+1],dx
                cursor 0,10h
                print vidas
                dec numvida
                ret

    salir:
        call retraso
        ;pop positiony
        ;pop positionx
ENDM