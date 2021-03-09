.data
    string1: .asciiz "Hello World"
    string2: .space 256

.text
.globl main

main:
    la $s1, string2
    la $s2, string1

    GetChar:
        lb $t0, ($s2)
        beqz $t0, secondstring
        sb $t0, 4($sp)
        addi $s1, $s1, 1
        addi $s2, $s2, 1
        addi $sp, $sp, -4
    exit:

    lw $s2, string2
exit:

