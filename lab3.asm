.data
    vector1:	.word 0, 5, 4, 3, 0, 1, 0
    pos1:	.word 0, 0, 0, 0, 0, 0, 0
    wth1:	.word 0, 0, 0, 0, 0, 0, 0
    vector2:	.word 3, 4, 2, 1, 0, 0, 1
    pos2:	.word 0, 0, 0, 0, 0, 0, 0
    wth2:	.word 0, 0, 0, 0, 0, 0, 0
    vectorL:	.word 7
    space:	.asciiz", "
    line:	.asciiz"\n"
.text
  main:
    la $s0, vector1
    la $s1, pos1
    la $s2, wth1
    lw $s3, vectorL
    addi $s4, $zero, 0
    la $s5, vector2
    la $s6, pos2
    la $s7, wth2
    la $t8, 0
    addi $t9, $zero, 1
    addi $t0, $zero, 0
    loadingvector:
      slt $t1, $t0, $s3
      beq $t1, $zero, endline
      sll $t1, $t0, 2
      add $t2, $t1, $s0
      lw $t3, 0($t2)
      li $v0, 1
      syscall
      add $a0, $t3, $zero
      li $v0, 4
      la $a0, space
      syscall
      beq $t3, $zero nothing
      add $t2, $t1, $s1
      sw $t9, 0($t2)
      sll $t1, $s4, 2
      add $t1, $t1, $s2
      sw $t3, 0($t1)
      addi $s4, $s4, 1
      j counter
      	nothing:
        
     	counter:
      	addi $t0, $t0, 1
      	j loadingvector
    endline:
    li $v0, 4
    la $a0, line
    syscall
    
    addi $t0, $zero, 0
    booling:
      slt $t1, $t0, $s3
      beq $t1, $zero, newline
      sll $t1, $t0, 2
      add $t1, $t1, $s1
      li $v0, 1
      lw $a0, 0($t1)
      syscall
      li $v0, 4
      la $a0, space
      syscall
      addi $t0, $t0, 1
      j booling
    newline:
    li $v0, 4
    la $a0, line
    syscall
    
    
   	addi $t0, $zero, 0
    printing:
    	slt $t1, $t0, $s4
    	beq $t1, $zero, newl
    	sll $t1, $t0, 2
      	add $t1, $t1, $s2
      	li $v0, 1
      	lw $a0, 0($t1)
      	syscall
      	li $v0, 4
      	la $a0, space
      	syscall 
    	addi $t0, $t0, 1
    	j printing
    newl:
    li $v0, 4
    la $a0, line
    syscall

    
    addi $t0, $zero, 0
    loading2vector:
    slt $t1, $t0, $s3
    beq $t1, $zero, end
      sll $t1, $t0, 2
      add $t2, $t1, $s5
      lw $t3, 0($t2)
      li $v0, 1
      add $a0, $t3, $zero
      syscall
      li $v0, 4
      la $a0, space
      syscall
      beq $t3, $zero nothing1
		add $t2, $t1, $s6
       		sw $t9, 0($t2)
        	sll $t1, $t8, 2
        	add $t1, $t1, $s7
        	sw $t3, 0($t1)
        	addi $t8, $t8, 1
    	j counter2
    	nothing1:
    		
    	counter2:
    addi $t0, $t0, 1
    j loading2vector
    end:
    la $a0, line
    li $v0, 4
    syscall
    
    li $t0, 0
    booling2:
      slt $t1, $t0, $s3
      beq $t1, $zero, end2
     
      sll $t1, $t0, 2
      add $t1, $t1, $s6
      li $v0, 1
      lw $a0, 0($t1)
      syscall
      li $v0, 4
      la $a0, space
      syscall
      
      addi $t0, $t0, 1
      j booling2
    end2:
    li $v0, 4
    la $a0, line
    syscall
    
    
   	addi $t0, $zero, 0
   	addi $t1, $zero, 0
    valuesofsecondvector:
    slt $t1, $t0, $t8
    beq $t1, $zero, EXIT2
    	sll $t1, $t0, 2
      	add $t1, $t1, $s7
      	lw $a0, 0($t1)
      	li $v0, 1
      	syscall
      	la $a0, space
      	li $v0, 4
      	syscall 
    addi $t0, $t0, 1
    j valuesofsecondvector
    EXIT2:
    		la $a0, line
    		li $v0, 4
    		syscall
    
    		la $a0, line
    		li $v0, 4
    		syscall
    
    addi $t0, $zero, 0
    addi $t1, $zero, 0
    addi $t2, $zero, 0
    addi $t3, $zero, 0	
	scalar:
	bgt $t0,$s3 endprogramm
	#slt $t5, $t0, $s3
	#beq $t5, $zero, endprogramm
		sll $t5, $t0, 2
		add $t6, $t5, $s1
		lw $t6, 0($t6)
		add $t7, $t5, $s6
		lw $t7, 0($t7)
		beq $t6, $zero, empty1
		beq $t7, $zero, empty2
			sll $t6, $t1, 2
			sll $t7, $t2, 2
			add $t6, $t6, $s2
			add $t7, $t7, $s7
			lw $t6, 0($t6)
			lw $t7, 0($t7)
		    	mul $t4, $t7, $t6
		    	add $t3, $t3, $t4
			addi $t2, $t2, 1
		empty2:
		addi $t1, $t1, 1
		j nothingtodo
		empty1:
		addi $t2, $t2, 1
		nothingtodo:
		addi $t0, $t0, 1
		j scalar
		
	 endprogramm:
	li $v0, 1
	move $a0, $t3
	syscall
			
