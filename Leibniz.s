#Practica 3. Principio de computadores
#
#Codigo en c++
#
#double error;
#std::cout << "Practica 3. PRINCIPIOS DE COMPUTADORES\n"
#             "Introduzca el error maximo permitido:";
#std::cin>>error;
#double resultado(0),numerador(1),parcial;
#int contador(0);
#do{
#   parcial =numerador/((2*contador) + 1);
#   resultado+=parcial;
#   numerador= -numerador;
#   contador++;
#}while(std::abs(parcial)>error);
#std::cout <<"Serie de Leibnis: "<<resultado<<"\n"
#            "Terminos calculados: "<<contador<<"\n";
#
########################################################
#   C++     -->     Ensamblador
#   error           $f0
#   resultado       $f2
#   numerador       $f4
#   parcial         $f6
#   contador        $t0
#
#   Variables auxiliares para Calculos
#   parcial2        $f8
#   dos             $f10
#   uno             $f14
########################################################

    .data
titulo:     .asciiz "Practica 3. PRINCIPIO DE COMPUTADORES\nIntroduzca el error maximo permitido:"
resultado:  .asciiz "Serie de Leibnis: "
terminos:   .asciiz "\nTerminos calculados: "

    .text

main:
    #Llamamos al sistema para mostrar el titulo de practica
    #Y pedimos que inserte el error
    li $v0,4
    la $a0,titulo
    syscall

    #Llamamos al sistema para recoger el valor del error
    #El sistema lo guarda en #f0
    li $v0,6
    syscall

    #Inicializamos las variables que lo necesitan
    li.s $f2,0.0  #Inicializamos a 0 a error con precision simple
    li.s $f4,1.0  #Inicializamos a 1 a numerador con precision simple
    li.s $f10,2.0 #Inicializamos a 2 a dos con precision simple
    li.s $f14,1.0 #Inicializamos a 1 a uno con precision simple
    li $t0,0      #Inicializamos a 0 a contador

    do:                     #creamos la etiqueta do para saltar con el bucle

        mtc1 $t0,$f6        #Copiamos el valor de contador en parcial
        cvt.s.w $f6,$f6     #Convertir el numero entero en presicion simple para poder operar con el
        mul.s $f6,$f6,$f10    #Multiplicar parcial por 2 y guardar en parcial
        add.s $f6,$f6,$f14    #Sumamos uno a parcial
        div.s $f6,$f4,$f6   #Dividimos el numerador entre el denominador y lo guardamos en parcial

        add.s $f2,$f2,$f6   #Sumamos a resultado el parcial

        neg.s $f4,$f4       #Negamos el numerador para una posible siguiente iteracion

        add $t0,$t0,1      #Incrementamos a uno contador

        abs.s $f8,$f6       #Calculamos el valor absoluto de parcial y lo guardamos en parcial2

        c.lt.s $f0,$f8      #Si error es menor que parcial2 activar flag
    bc1t do                 #Si flag esta activada saltar a etiqueta do

    #Llamamos al sistema para mostrar el texto de resultado
    li $v0,4
    la $a0,resultado
    syscall

    #Llamamos al sistema para mostrar el valor de la variable resultado
    li $v0,2
    mov.s $f12,$f2
    syscall

    #Llamamos al sistema para mostrar el texto terminos
    li $v0,4
    la $a0,terminos
    syscall

    #Llamamos al sistema para mostrar el valor de la variable resultado
    li $v0,1
    move $a0,$t0
    syscall

    li $v0,10
    syscall

    #2.- He elegido usar los registros pares para poder que encaso de ejecutarse en doble precision se simple de modificar
    #Mis registros elegidos son:  (basandome en mi codigo de c++)
    ########################################################
    #   C++     -->     Ensamblador
    #   error           $f0
    #   resultado       $f2
    #   numerador       $f4
    #   parcial         $f6
    #   contador        $t0
    #
    #   Variables auxiliares para Calculos
    #   parcial2        $f8
    #   dos             $f10
    #   uno             $f14
    ########################################################

    #3.- Para realizar el cambio a doble presision solo habria que cambiar las s de simple precicion de las instruciones
    # de punto flotante por una de d y a la hora de mostrar el resultado cargariamos un 3 envez de un 2 en a0 esto seria
    # en la linea 85. Las instruciones que habria que cambiar los a doble seria las lineas 54-57, 63-70, 74, 76, 86
    # Y no cambiaria la elecion de mis registros ya que esta preparado para soportar precicion doble
