include game.asm
include nativas.asm
include tablero.asm
include movc.asm
include reanudar.asm
.radix 16
.model small
.stack
.data
    texto db "Universidad de San Carlos de Guatemala $"
    fac db "Facultad de Ingenieria$"
    clas db "Arquitectura de Computadores",0a,"y Ensambladores 1$"
    secti db 'Seccion "A"','$'
    semestr db "Segundo Semestre 2023$"
    nom db "Nombre: Raul Josue Castillo Barco","$"
    carn db "Carne: 202001932$"
    m11 db "F1 Iniciar sesion$"
    m12 db "F2 Registrarse $"
    m13 db "F3 Salir $"
    m21 db "F1 Nueva partida $"
    m22 db "F2 Ultima partida$"
    m23 db "F3 Salir$"
    user db "Ingrese usuario: ",0a,"$"
    pass db "Ingrese password: ",0a,"$"
    ;msg db "Ingrese opcion: $"
    gmover db 0
    admin db "rcastillo$"
    passw db "202001932A*$"

    buffer_user db 14 dup('$')
    buffer_pass db 19 dup('$')
    puntaje db "Puntaje: $"
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
    puntos dw 0
    numero db 08 dup('$')
.code
.startup

	mov ah, 0
    mov al, 13h
	int 10
    
    cursor 0,0
    print texto

    cursor 01,0
    print fac

    cursor 02,0
    print clas

    cursor 04,0
    print secti

    cursor 04,0
    print semestr

    cursor 05,0
    print nom

    cursor 06,0
    print carn
    delaym
    limpiarPantalla

    menuprincipal:
        cursor 0a,0c
        print m11

        cursor 0c,0c
        print m12
        
        cursor 0e,0c
        print m13

        mov ah,0
        int 16

        cmp ah,3bh
        jz menu1
        jmp salirr
    
    menu1:
        limpiarPantalla
        cursor 08,0c
        print user

        cursor 09,0c
        mov ah,0a
        mov dx,offset buffer_user
        int 21

        printchar 0a

        cursor 0b,0c
        print pass

        cursor 0c,0c
        mov ah,0a
        mov dx,offset buffer_pass
        int 21

        verificarUser  ;Llamo a la macro
        cmp cx,01
        jz menu2
        jmp menu1
    
    menu2:
        limpiarPantalla
        cursor 07,0c
        print m21

        cursor 08,0c
        print m22

        cursor 09,0c
        print m23

        mov ah,0
        int 16

        cmp ah,3bh
        jz game
    
    game:
        limpiarPantalla
        modegame

    salirr:
    ;mov ah,00
    ;int 16h

    
.exit
end