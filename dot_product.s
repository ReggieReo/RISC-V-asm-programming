.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
dot: .string "The dot product is: "
newline: .string "\n"

.text
main:
    # Registers NOT to be used x0 to x4 and x10 to 17; reasons to be explained later
    addi x5, zero, 0    # set x5 = i = 0
    addi x6, zero, 0    # set x6 to sop = 0
    la   x7, a          # &a
    la   x8, b          # &b
    addi x9, zero, 5    # x9 = len of arr = 5
loop:
    bge  x5, x9, exit
    slli x18, x5, 2     # set x18 to i*4
    add  x19, x18, x7   # (&a[i]) add i*4 to the base address off array a and put it to x19
    lw   x20, 0(x19)    # a[i]
    add  x21, x18, x8   # (&b[i]) add i*4 to the base address off array b and put it to x21
    lw   x22, 0(x21)    # b[i]
    mul  x23, x20, x22  # x23 = a[i] * b[i]
    add  x6, x6, x23    # sop += a[i] * b[i];
    addi x5, x5, 1      # i++
    j loop
exit:
    addi a0, zero, 4
    la, a1, dot
    ecall
    addi a0, zero, 1 
    add a1, x0, x6 # print sop
    ecall
    addi a0, zero, 4
    la, a1, newline
    ecall
    addi a0, zero, 10
    addi a1, zero, 0
    ecall