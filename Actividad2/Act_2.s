        ; Programa que calcula la secuencia de Fibonacci (Fn)
        ; Para n en el rango 0 <= n <= 47
        ; Los resultados se almacenan en memoria SRAM
        ; AGUILAR ANDRADE ANGEL DE JESUS

; Definición de nombres para registros
nmax      RN r0    ; número de entrada (n)
i         RN r1    ; contador de iteraciones
ptr       RN r2    ; puntero en SRAM
prev  RN r3    ; Fn-2
current  RN r4    ; Fn-1
next  RN r5    ; Fn = Fn-1 + Fn-2

; ---------------- Área de variables ----------------
        AREA mis_variables, DATA, READWRITE
        ALIGN
numero   DCD 9                ; valor de n (ejemplo n=9)
result   DCD 0x12345678       ; inicio de resultados
         SPACE 200            ; espacio suficiente para n=47

; ---------------- Área de programa ----------------
        AREA Actividad_2, CODE, READONLY
        ENTRY
        EXPORT __main

__main

        ; cargar n desde variable
        LDR r2, =numero
        LDR nmax, [r2]

        ; apuntar a resultados
        LDR ptr, =result

        ; guardar F0 = 0
        MOV prev, #0
        STR prev, [ptr], #4

        ; si n == 0, termina
        CMP nmax, #0
        BEQ fin

        ; guardar F1 = 1
        MOV current, #1
        STR current, [ptr], #4

        ; si n == 1, termina
        CMP nmax, #1
        BEQ fin

        ; inicializar contador
        MOV i, #2

ciclo
        ; next = prev + current
        ADD next, prev, current
        STR next, [ptr], #4

        ; actualizar valores
        MOV prev, current
        MOV current, next

        ; incrementar contador
        ADD i, i, #1
        CMP i, nmax
        BLE ciclo

fin
        B fin

        END
