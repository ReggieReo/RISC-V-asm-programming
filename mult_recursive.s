.data
newline: .string "\n"
.text
main:
    # pass the first argument to a0
    # pass second argument to a1
    li a0, 110
    li a1, 50
    # calling mult
    jal mult

    # print result
    mv s1, a0 # save result to s1
    # print result from mult
    addi a0, zero, 1
    mv a1, s1
    ecall

    # print space
    addi a0, x0, 4
    la a1, newline
    ecall

    # exit cleanly
    addi a0, x0, 10
    addi a1, x0, 0
    ecall # Terminate ecall

mult:
    # base case
    # compare a1, with 1, if two are equal you exit the mult fuction
    li t0, 1
    beq a1, t0 ,return

    # save ra (return address) before calling self
    addi sp, sp, -4
    sw ra, 0(sp) # storing ra value on to the stack

    # recirsive case
    # return a + mult(a, b-1)
    # save a0 on to the stack
    # we don't use a1 again so we don't save a1
    addi sp, sp, -4
    sw a0, 0(sp)    # save a0

    addi a1, a1, -1
    # pass the first arugemt to a0
    # pass the second argument to a1
    
    jal mult
    # by convention the result is in a0
    # restore a0 and a1 to the stack
    # exit from the recursive case
    mv t1, a0
    lw a0, 0(sp)
    addi sp, sp, 4

    add a0, a0, t1 # where t1 is return value a, a0 is the original value
    lw ra, 0(sp)
    addi sp, sp, 4
    j return
return:
    jr ra