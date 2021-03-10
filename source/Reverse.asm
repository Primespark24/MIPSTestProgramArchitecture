.data
    string1: .asciiz "Hello World"  # string to reverse
    string2: .space 256  # string to put reversed string into

.text
.globl main

main:
    addi $sp, $sp, -48   	# stack frame
    sw   $ra, 0($sp)    	# store $ra

    la $s2, string2         # load string2
    la $s1, string1         # load string1

    GetChar:                # method to break up words
        lb $t0, ($s1)       # load current byte/char of word
        beq $t0, $s0, exit  # check if char is = to zero if not exit
        sb $t0, ($sp)       # store byte into stack
        addi $s1, $s1, 1    # increment position to get next char
        addi $sp, $sp, 4    # increment location in stack
        j GetChar           # jump back to top of method
    exit:

    lw $s2, string2         # load string2

    jr $ra            	# return to OS
