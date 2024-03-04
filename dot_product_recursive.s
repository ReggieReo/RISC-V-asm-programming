.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
dot: .string "The dot product is: "
newline: .string "\n"

.text
main:
    addi s0, zero, 0    # result = s0
    la a0, a            # a0 = &a
    la a1, b            # a2 = &b
    li a2, 5            # size = 5
    mv s0, a0 # move result from a0 to s0
    jal dot_product_recursive
    # print result
    mv a1, a0
    addi a0, zero, 1
    ecall
    # exit cleanly
    addi a0, x0, 10
    addi a1, x0, 0
    ecall # Terminate ecall

dot_product_recursive:
    # a0 = &a
    # a1 = &b
    # a2 = size
    # get a, and b 0
    # get value of a[0] b[0]
    lw t1, 0(a0) # t1 = a[0]
    lw t2, 0(a1) # t2 = b[0]
    mul t3, t1, t2 # a[0] * b[0]
    # check basecase
    li t0, 1 # t0 = 1
    # if_ a2 == 1 jump to exit_base_case
    beq a2, t0, exit_base_case
    
    # save return address
    addi sp, sp, -4
    sw  ra, 0(sp)

    # a0 = a+1
    # a1 = b+1
    # a2 = size-1
    addi a0, a0, 4
    addi a1, a1, 4
    addi a2, a2, -1
    # save t3 before calling dot_product_recursive because t3 will be change
    addi sp, sp, -4
    sw  t3, 0(sp)

    # return result of function is in a0, but t3 is changed from calling it
    jal dot_product_recursive

    # load original t3 before calling dot_product_recursive
    lw t3, 0(sp)
    addi sp, sp, 4

    # compute return result
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
    add a0, a0, t3
    
    # load return address and jump
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

exit_base_case:
    # return a[0]*b[0]
    mul a0, t1, t2 
    jr ra