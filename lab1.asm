.data
	s1: .word 5
	s2: .word 10
	s3: .word 15
	s4: .word 20
.text
	lw $t0, s1
	lw $t1, s2
	lw $t2, s3
	lw $t3, s4
	
	add $t4, $t0, $t1
	sub $t5, $t2, $t3
	sub $t6, $t4, $t5
	
	li $v0, 1
	move $a0, $t6
	syscall 
