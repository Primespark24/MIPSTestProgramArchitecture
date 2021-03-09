.data
    string1: .asciiz "Hello World"
    string2: .space 256

.text
.globl main

main:
    addi $sp, $sp, -48   	# stack frame
    sw   $ra, 0($sp)    	# store $ra

    la $s2, string2
    la $s1, string1

    GetChar:
        lb $t0, ($s1)
        beq $t0, $s0, exit
        sb $t0, ($sp)
        addi $s1, $s1, 1
        addi $sp, $sp, 4
        j GetChar
    exit:

    lw $s2, string2

    jr $ra            	# return to OS
