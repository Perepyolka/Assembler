.data
 	s1: .word 14
.text
	lw $t0, s1
	main:
		addi $s0, $zero, 1  
		addi $s2, $zero, 1
		loop:
			addi $s0, $s0, 1
			bgt $s0, $t0, else
			mul $s2, $s0, $s2
			j loop
			
			else:
			li $v0, 1
			move $a0, $s2  
			syscall 