.data
arr1: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
arr2: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
newline: .string "\n"

.text
main:
# Registers NOT to be used x0 to x4 and x10 to 17; reasons to be explained later
    addi x5, zero, 10   # let x5 = size set to10
    addi x6, zero, 0    # let x6 = sum set to 0
    addi x7, zero, 0    # let x7 = sum2 set to 0
    # init condition i = 0; i < size; i++
    addi x8, zero, 0    # let x8 = i set to 0
    la x9, arr1         # loading the address of arr1 to x9
loop1:
    bge x8, x5, exit_loop1
    # arr1[i] = i + 1
    # we need to calculate &arr[i]
    # we need base address of arr1
    # then, we add an offset of i*4 to the base address
    slli x18, x8, 2     # set x18 to i*4
    add x19, x18, x9    # add i*4 to the base address off arr1 and put it to x19 (arr1[i])
    addi x20, x8, 1     # set x20 to i+1
    sw x20, 0(x19)      # arr1[i] = i + 1
    addi x8, x8, 1      # i++
    j loop1
    
exit_loop1:
    addi x8, zero, 0    # let x8 = i set to 0 again
    la x21, arr2         # loading the address of arr2 to x21
    
loop2:
    bge x8, x5, exit_loop2
    # arr2[i] = 2*i
    # we need to calculate &arr[i]
    # we need base address of arr1
    # then, we add an offset of i*4 to the base address
    slli x18, x8, 2     # set x18 to i*4
    add x19, x18, x21   # add i*4 to the base address off arr2(x21) and put it to x19 (arr1[i])
    add x20, x8, x8     # set x20 to 2*i(i+i)
    sw x20, 0(x19)      # arr2[i] = 2*i
    addi x8, x8, 1      # i++
    j loop2
exit_loop2:
    addi x8, zero, 0 # set i = zero

loop3:
    bge x8, x5, exit_loop3 # if i >= size jump to exit3
    # sum1 + arr1[i]
    # need &arr1[i]
    slli x18, x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address of arr1 and put it to x19
    lw x20, 0(x19) # x20 = arr1[i]
    add x6, x6, x20 # sum1 = sum1 + arr1[i]
    
    # sum2 + arr2[i]
    add x19, x18, x21 # add i*4 to the base address of arr2 and put it to x19
    lw x20, 0(x19) # x20 = arr2[i]
    add x7, x7, x20 # sum2 = sum2 + arr2[i]
    
    addi x8, x8, 1 # i++
    j loop3 # jump to loop3
    
exit_loop3:
    addi a0, zero, 1 
    add a1, x0, x6 # print sum1
    ecall
    addi a0, zero, 4
    la, a1, newline
    ecall
    addi a0, zero, 1 
    add a1, x0, x7 # print sum2
    ecall
    addi a0, zero, 10
    addi a1, zero, 0 # print sum2
    ecall