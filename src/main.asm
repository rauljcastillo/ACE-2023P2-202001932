include nativas.asm

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
    m1 db "F1 Nueva partida ",0a,"$"
    m2 db "F2 Ultima partida",0a,"$"
    m3 db "F3 Salir",0a,"$"

    msg db "Ingrese opcion: $"

.code
.startup

	mov ah, 00
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
        cursor 0ah,0fh
        print m1

        cursor 0ah,
    ;mov ah,00
    ;int 16h

    
.exit
end