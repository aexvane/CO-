.data
    ent: .asciiz "Press 1 for signing in.\nPress 2 for signing out.\nPress 3 for total time.\n"
    login: .asciiz "Enter the signin time.\n"
    logout: .asciiz "Enter the logout time.\n"
    totalout: .asciiz "The total time is: "
    hrs: .asciiz " hours.\n"

.text
    
main:
    li $v0, 4
    la $a0, ent
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, 1, incall
    
    beq $t0, 2, outcall
    
    beq $t0, 3, totalcall

    incall:
        li $t3, 0

        whilein:
            beq $t3, 5, main

            jal in
            add $s0, $s0, $t1

            addi $t3, $t3, 1

            j whilein
    outcall:
        li $t3, 0

        whileout:
            beq $t3, 5, main

            jal out
            add $s1, $s1, $t2

            addi $t3, $t3, 1

            j whileout
    totalcall:
        jal total
        j end

    in:
        li $v0, 4
        la $a0, login
        syscall

        li $v0, 5
        syscall
        move $t1, $v0

        jr $ra
    out:
        li $v0, 4
        la $a0, logout
        syscall 

        li $v0, 5
        syscall
        move $t2, $v0

        jr $ra
    total:
        sub $s2, $s1, $s0
        div $s2, $s2, 60

        li $v0, 4
        la $a0, totalout
        syscall

        move $a0, $s2
        li $v0, 1
        syscall
        
        li $v0, 4
        la $a0, hrs
        syscall
        
        jr $ra
end:
    li $v0, 10
    syscall
