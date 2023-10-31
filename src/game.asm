modegame macro
    cursor 0,10
    print vidas
    
    mov numero[0],'0'
    cursor 0,23
    print numero

    drawtab
    mov bx,offset spritej_banqueta
    mov player_x,0
    mov player_y,0b8h
    mov positionx,0
    mov positiony,0b8h
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

        cmp ah,01h
        jz pause


        up:
            call limpiar
            mov ax,08
            sub player_y,ax
            ;sub positiony,ax
            mov cx,02
            mov di,offset table
            call colision2
            cmp gmover,01
            jz fin_juego1
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
            mov cx,02
            mov di,offset table
            call colision2
            cmp gmover,01
            jz fin_juego1
            ;add positiony,ax
            mov bx,player_y
            mov positiony,bx

            mov bx,player_x
            mov positionx,bx
            ;mov bx,offset spritej_carril
            call imprimir
            mov ah,01
            jmp movimi

    pause:
        limpiarPantalla
        mov ah,0
        int 16

        cmp ah,01h
        jz salid_pause
        jmp pause
        salid_pause:
            limpiarPantalla
            reanu
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
            mov player_y,0b8h
            mov positionx,0
            mov positiony,0b8h
            mov bx,offset spritej_banqueta
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
                mov gmover,1 
                ret

    limpiar:
        cmp player_y,08h
        jz spritec

        cmp player_y,0b8h
        jz spritec

        mov bx,player_x
        mov positionx,bx
        mov bx,player_y
        mov positiony,bx

        mov bx,offset sprite_carril
        call print_sprite
        ret

        spritec:
            mov bx,player_x
            mov positionx,bx
            mov bx,player_y
            mov positiony,bx
            mov bx,offset sprite_banqueta
            call print_sprite
            ret
    
    ;Imprimir sprites en banqueta o en carril
    imprimir:
        cmp player_y,08
        jz spritem

        cmp player_y,0b8h
        jz spritem1

        mov bx,offset spritej_carril
        call print_sprite
        ret

        spritem:
            mov bx,offset spritej_banqueta
            call print_sprite

            call limpiar
            mov player_x,0
            mov player_y,0b8h
            mov positionx,0
            mov positiony,0b8h
            mov bx,offset spritej_banqueta
            call print_sprite

            ;pop positiony
            ;pop positionx
            
            cmp numvida, 03
            jz sumar100

            cmp numvida, 02
            jz sumar50

            cmp numvida,01
            jz sumar25
            ret

        sumar100:
            mov bx,64
            add puntos,bx
            mov ax,puntos
            toascii
            cursor 0,23
            print numero
            ret

        sumar50:
            mov bx,32
            add puntos,bx
            mov ax,puntos
            toascii
            cursor 0,23
            print numero
            ret
        sumar25:
            mov bx,19
            add puntos,bx
            mov ax,puntos
            toascii
            cursor 0,23
            print numero
            ret
        

        spritem1:
            mov bx,offset spritej_banqueta
            call print_sprite
            ret
    
    fin_juego1:
        limpiarPantalla
        mov gmover,0
        cursor 0a,0c
        print puntaje
        cursor 0c,0c
        print numero
        delay5s
        jmp menu2



endm