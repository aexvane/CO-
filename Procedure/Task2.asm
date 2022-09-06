.data
    num: .asciiz "Enter a number.\n"
    base: .asciiz "Enter the base.\n"
    num2: .asciiz "The numbers after conversion are:\n"
    space: .asciiz " ,"
.text
    li $v0, 4
    la $a0, num
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    li $v0, 4
    la $a0, base
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    li $v0, 4
    la $a0, num2
    syscall

    jal convert
    
convert:
    beqz $t0, end
        
    div $t0, $t1
    mfhi $t2      
    move $a0, $t2
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, space
    syscall
 
    div $t0, $t0, $t1    
    j convert
    jr $ra
end:
    li $v0, 10
    syscall
