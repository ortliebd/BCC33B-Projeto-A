        .data
num_movimento:
        .word       0                   #int num_movimento
out1:   .asciiz     ") "
out2:   .asciiz     " --> "
out3:   .asciiz     "Informe o número de discos: "
out4:   .asciiz     "Executar novamente? (s/n) "
literal:.word       0x00000073          #'n'

        .text
        j           main

hanoi:
        addi        $sp, $sp, -32
        sw          $t1, 28($sp)
        sw          $t2, 24($sp)
        sw          $t3, 20($sp)
        sw          $a0, 16($sp)
        sw          $a1, 12($sp)
        sw          $a2, 8($sp)
        sw          $a3, 4($sp)
        sw          $ra, 0($sp)

IF:
        sgt         $t0, $a0, $zero     #if (qtd_discos > 0)
        beq         $t0, $zero, END_IF

        move        $t1, $a1
        move        $t2, $a2
        move        $t3, $a3

        addi        $a0, $a0, -1        #hanoi (qtd_discos - 1, col_A, col_C, col_B);
        move        $a2, $t3
        move        $a3, $t2
        jal         hanoi

        la          $t9, num_movimento  #++num_movimento
        lw          $s0, 0($t9)
        addi        $s0, $s0, 1
        sw          $s0, 0($t9)

        move        $t7, $a0            

        li          $v0, 1              #"%d"
        move        $a0, $s0
        syscall

        li          $v0, 4              #") "
        la          $a0, out1
        syscall
        
        li          $v0, 11             #"%c"
        move        $a0, $t1
        addi        $a0, $a0, 64
        syscall

        li          $v0, 4              #" --> "
        la          $a0, out2
        syscall

        li          $v0, 11             #"%c"
        move        $a0, $t3
        addi        $a0, $a0, 64
        syscall

        li          $v0, 11             #"\n"
        li          $a0, 10
        syscall
        
        move        $a0, $t7

        move        $a1, $t2            #hanoi (qtd_discos -1, col_B, col_A, col_C);
        move        $a2, $t1
        move        $a3, $t3
        jal         hanoi        
END_IF:
        lw          $ra, 0($sp)
        lw          $a3, 4($sp)
        lw          $a2, 8($sp)
        lw          $a1, 12($sp)
        lw          $a0, 16($sp)
        lw          $t3, 20($sp)
        lw          $t2, 24($sp)
        lw          $t1, 28($sp)
        addi        $sp, $sp, 32
        jr          $ra        
main:

DO:
        addi        $t0, $zero, 0       #num_movimento = 0;

        li          $v0, 4              #printf ("Informe o número de discos: ");
        la          $a0, out3
        syscall

        li          $v0, 5              #scanf ("%d", &n_discos);
        syscall
        move        $t0, $v0

        move        $a0, $t0            #hanoi (n_discos, 1, 2, 3);
        li          $a1, 1
        li          $a2, 2
        li          $a3, 3
        jal         hanoi

        li          $v0, 4              #printf ("Executar novamente? (s/n) ");
        la          $a0, out4
        syscall

        li          $v0, 12             #scanf (" %c", &exec_novamente);        
        syscall
        move        $t0, $v0

        li          $v0, 12
        syscall

        lw          $t1, literal
        beq         $t0, $t1, DO        
WHILE:
        
