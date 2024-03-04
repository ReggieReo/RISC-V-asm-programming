.data
A: .word 11, 22, 33, 44, 55
newline: .string "\n"
space: .string " "

.text
main:
    la a0, A # loading the starting address of array a to a0
    li a1, 5
    jal print_array
        # exit gracefully
    addi a0, x0, 10
    addi a1, x0, 0
    ecall # Terminate ecall

print_array:
    addi t0, zero, 0 # let the i value be in t0

loop1:
    bge t0, a1, exit1 # a1 is size
    slli t1, t0, 2 # t1 has the i*4 value
    add t2, t1, a0 # a0 is base address t1 is i*4 so we get &A[i]
    lw t3, 0(t2) # t3 has the value of A[i]

    # allocate stack for saving a0, a1
    addi sp, sp, -8
    # save value of a1, and a0
    sw a1, 4(sp)
    sw a0, 0(sp)

    # print A[i]
    addi a0, zero, 1
    mv a1, t3
    ecall

    # print space
    addi a0, x0, 4
    la a1, space
    ecall

    # load value of a1, and a0
    lw a1, 4(sp)
    lw a0, 0(sp)
    # delete space of stack
    addi sp, zero, -8
    addi sp, sp, 8

    addi t0, t0, 1 # i++
    j loop1


exit1:
    # print newline
    addi a0, x0, 4
    la a1, newline
    ecall
    jr ra

    

