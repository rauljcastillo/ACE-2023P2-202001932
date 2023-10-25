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
    m11 db "F1 Iniciar sesion$"
    m12 db "F2 Registrarse $"
    m13 db "F3 Salir $"
    m21 db "F1 Nueva partida $"
    m22 db "F2 Ultima partida$"
    m23 db "F3 Salir$"
    user db "Ingrese usuario: ",0a,"$"
    pass db "Ingrese password: ",0a,"$"
    key
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
        cursor 0a,1e
        print m11

        cursor 0c,1e
        print m12
        
        cursor 0e,1e
        print m13
        
        mov ah,0
        int 16

        cmp ah,3bh
        jz menu1
    
    menu1:
        print user

    ;mov ah,00
    ;int 16h

    
.exit
end