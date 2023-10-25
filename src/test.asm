include nativas.asm
include tablero.asm
include movc.asm
.radix 16
.model small
.stack
.data
    sprite db 0,0,0,05,05,0,0,0
           db 0,0,0,05,05,0,0,0
           db 05,05,05,05,05,05,05,05
           db 05,05,05,05,05,05,05,05
           db 05,0,0,05,05,0,0,05
           db 0,0,0,05,05,0,0,0
           db 0,0,0,05,05,05,0,0
           db 05,05,05,0,0,05,05,05

    sprite_carro db 13,0,0,13,13,0,0,13
                 db 0a,0a,0a,0a,0a,0a,0a,0a
                 db 0a,06,06,0a,0a,0a,0a,0a
                 db 0a,06,06,0a,0a,06,06,0a
                 db 0a,06,06,0a,0a,06,06,0a
                 db 0a,06,06,0a,0a,0a,0a,0a
                 db 0a,0a,0a,0a,0a,0a,0a,0a
                 db 1f,0,0,13,1f,0,0,13

    spritej_carril db 13,13,13,05,05,13,13,13
                   db 13,13,13,05,05,13,13,13
                   db 05,05,05,05,05,05,05,05
                   db 05,05,05,05,05,05,05,05
                   db 05,13,13,05,05,13,13,05
                   db 13,13,13,05,05,13,13,13
                   db 13,13,05,05,05,05,13,13
                   db 1f,05,05,13,1f,05,05,05

    sprite_banqueta db 17,17,17,17,17,17,17,17
                    db 17,17,17,1a,17,17,17,17
                    db 17,17,17,1a,17,17,17,17
                    db 17,17,17,1a,17,17,17,17
                    db 17,17,17,1a,17,17,17,17
                    db 17,17,17,1a,17,17,17,17
                    db 17,17,17,1a,17,17,17,17
                    db 17,17,17,17,17,17,17,17

    spritej_banqueta db 17,17,17,05,05,17,17,17
                    db 17,17,17,05,05,17,17,17
                    db 05,05,05,05,05,05,05,05
                    db 05,05,05,05,05,05,05,05
                    db 05,17,17,05,05,17,17,05
                    db 17,17,17,05,05,17,17,17
                    db 17,17,05,05,05,05,17,17
                    db 17,05,05,17,17,05,05,17

    sprite_carril   db 13,13,13,13,13,13,13,13
                    db 13,13,13,13,13,13,13,13
                    db 13,13,13,13,13,13,13,13
                    db 13,13,13,13,13,13,13,13
                    db 13,13,13,13,13,13,13,13
                    db 13,13,13,13,13,13,13,13
                    db 13,13,13,13,13,13,13,13
                    db 1f,1f,13,13,1f,1f,13,13
    clean db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
          db 0,0,0,0,0,0,0,0
    value dw 0a000h
    positionx dw 0      ;Posicion para carros y otros sprites
    positiony dw 0b0h   ;

    player_x dw 0   ;Posiciones actuales del jugador
    player_y dw 0
    table db 0a dup(0)
    msg db "Ingrese tecla: $"
    vidas db ' O ',' O ',' O ','$'
    numvida db 03
    mens1 db "$"

.code
.startup
    mov ah,0
    mov al,13h
    int 10
    cursor 0,10
    print vidas
    ;Di-> Fila (y)
    ;SI-> Columna (x)
    ;CL-> Color
    
    drawtab
    mov bx,offset spritej_carril
    mov player_x,0
    mov player_y,0b0h
    mov positionx,0
    mov positiony,0b0h
    call print_sprite 
    movimi:
        ;print msg
        mover 
        mov ah,01
        int 16
        ;Ejecutar la macro

        jz movimi       ;SI es 0 entonces no hay ningun caracter

        mov ah,0
        int 16
        cmp ah,48h
        jz up

        cmp ah,4dh
        jz right

        cmp ah,4bh
        jz left

        cmp ah,50h
        jz down
        up:
            call limpiar
            mov ax,08
            sub player_y,ax
            ;sub positiony,ax
            mov cx,02
            mov di,offset table
            call colision2
            mov bx,player_x
            mov positionx,bx

            mov bx,player_y
            mov positiony,bx
            ;mov bx,offset spritej_carril
            call imprimir
            mov ah,01
            jmp movimi

        right:
            call limpiar
            mov ax,08
            add player_x,ax
            ;add positionx,ax
            mov bx,player_x
            mov positionx,bx

            mov bx,player_y
            mov positiony,bx
            ;mov bx,offset spritej_carril
            call imprimir
            mov ah,01
            jmp movimi

        left:
            call limpiar
            mov ax,08
            sub player_x,ax
            mov bx,player_x
            mov positionx,bx

            mov bx,player_y
            mov positiony,bx

            call imprimir
            mov ah,01
            jmp movimi

        down:
            call limpiar
            mov ax,08
            add player_y,ax
            ;add positiony,ax
            mov bx,player_y
            mov positiony,bx

            mov bx,player_x
            mov positionx,bx
            ;mov bx,offset spritej_carril
            call imprimir
            mov ah,01
            jmp movimi

    print_sprite:
        mov di,positiony
        mov si,positionx
        mov cx,08

        fila:
            push cx
            mov cx,08
        colum: 
            push bx
            mov bl,[bx]
            
            call pintar_pixel 
            pop bx
            inc si
            inc bx
            loop colum

            pop cx
            mov si,positionx
            inc di
            
            loop fila
            ret 

        pintar_pixel:
            ;Row major
            push ds
            mov ds,value
            mov ax,140h
            mul di
            add ax,si
            push di
            mov di,ax
            mov [di],bl
            pop di
            pop ds
            ret 

        fin:
            jmp fin


    colision2:
        mov dx,08
        xor ax,ax
        mov al,[di]
        mul dx

        mov bx,player_x
        cmp ax,bx
        jz next
        jmp exitcolision2
        next:
            xor ax,ax
            mov dx,08
            mov al,[di+1]
            mul dx
            mov bx,player_y
            cmp ax,bx
            jz choque
            jmp exitcolision2
        choque:
            push positionx
            push positiony
            mov player_x,0
            mov player_y,0b0h
            mov positionx,0
            mov positiony,0b0h
            mov bx,offset spritej_carril
            call print_sprite
            call calcularvid
            pop positiony
            pop positionx
            ret


        exitcolision2:
            inc di
            inc di

        loop colision2
        ret

    calcularvid:
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

            vida2:
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

            vida1:
                mov di,offset vidas
                mov dl,'X'
                mov [di+4],dx
                dec numvida
                cursor 0,10h
                print vidas
                ret
            gamover:
                mov di,offset vidas
                mov dl,'X'
                mov [di+1],dx
                cursor 0,10h
                print vidas
                dec numvida
                ret

    limpiar:
        cmp player_y,08
        jz spritec

        cmp positiony,0b8h
        jz spritec

        mov bx,player_x
        mov positionx,bx
        mov bx,player_y
        mov positiony,bx

        mov bx,offset sprite_carril
        call print_sprite
        ret

        spritec:
            mov bx,offset sprite_banqueta
            call print_sprite
            ret
    
    ;Imprimir sprites en banqueta o en carril
    imprimir:
        cmp positiony,08
        jz spritem

        cmp positiony,0b8h
        jz spritem

        mov bx,offset spritej_carril
        call print_sprite
        ret

        spritem:
            mov bx,offset spritej_banqueta
            call print_sprite
            ret


.exit
end
