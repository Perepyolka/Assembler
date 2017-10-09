.data
    matrix1:	.word 1, 5, -2, -1, 3, 6, 2, 4, 5, 8, 1, 10             #1*3+5*(-5)+(-2)*(-1)+(-1)*8 = -28
    hsize1:	.word 4						        #1*5+5*4+(-2)*1+(-1)*11 = 12								
    vsize1:	.word 3						        #1*(-3)+5*6+(-2)*4+(-1)*5 = 14
    matrix2:	.word 3, 5, -3, -5, 4, 6, -1, 1, 4, 8, 11, 5		#3*3+6*(-5)+2(-1)+4*8 = 9
    hsize2:     .word 3							#3*5+6*4+2*1+4*11 = 85
    vsize2:     .word 4							#3*(-3)+6*6+2*4+4*5 = 55
									#5*3+8*(-5)+1*(-1)+10*8 = 54
    result:     .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0		#5*5+884+1*1+10*11 = 168
    									#5*(-3)+8*(6)+1*4+10*5 = 87
    space:      .asciiz " "
    line:       .asciiz "\n"
    string:     .asciiz "Result: "
    
.text
    la $s1, matrix1 			#loading matrixes and parameters of them
    lw $s2, hsize1 
    lw $s3, vsize1
    la $s4, matrix2  
    lw $s5, hsize2
    lw $s6, vsize2
    la $s7, result
    
    bne $s2, $s6, exit			#end if width of first not equal to height of second
    
    addi $t0, $zero, 0			#counter for columns of first matrix
    addi $t1, $zero, 0			#counter for rows of first matrix
    addi $t2, $zero, 0			#counter for columns of second matrix
    addi $t3, $zero, 0			#counter for rows of second matrix
    addi $t4, $zero, 0 			#result
    addi $t5, $zero, 0 			
   
    mul $s0, $s2, $s3
   
   multloop:				#multiplication
	mul $t6, $t1, $s2
	add $t6, $t6, $t0
	sll $t6, $t6, 2			#next number
     	add $t6, $t6, $s1		#loading matrix 
     	lw $t7, 0($t6)
      	
      	mul $t8, $t2, $s5
      	add $t8, $t8, $t3		
      	sll $t8, $t8, 2			#next number
      	add $t8, $t8, $s4		#loading matrix
      	lw $t9, 0($t8)
      	
      	mul $t7, $t7, $t9
      	add $t4, $t4, $t7		#temporary result
	
      	addi $t2, $t2, 1 
      	add $t0, $t0, 1
      	bne $t0, $s2, multloop		#next row if counter grater then width of matrix
      	
      	mul $t6, $t1, $s2
      	add $t6, $t6, $t0	
      	beq $t6, $s0, checkend		
      	
      	addi $t0, $zero, 0		#counter to 0 
      	addi $t2, $zero, 0		#counter to 0 
      	addi $t3, $t3, 1
      	
      	sll $t6, $t5, 2
      	add $t6, $t6, $s7
      	sw $t4, 0($t6)
      	
    	addi $t4, $zero, 0		#counter to 0 
    	addi $t5, $t5, 1
      	
      	bne $t3, $s5, multloop		#next column
      	addi $t1, $t1,  1	
    	addi $t3, $zero, 0		#counter to 0 

	bne $t1, $s3, multloop		#next row
    
    checkend:
    	addi $t0, $zero, 0		#counter to 0 
    	addi $t3, $t3, 1
    	addi $t2, $zero, 0		#counter to 0 

      	sll $t6, $t5, 2
      	add $t6, $t6, $s7
      	sw $t4, 0($t6)
      	addi $t5, $t5, 1
      	addi $t4, $zero, 0		#counter to 0 

    	bne $t3, $s5, multloop		#next row, printing, if multiplication is ended
   printing:
    	mul $s0, $s5, $s3 
    
  	li $v0, 4
    	la $a0, string
    	syscall
    
    	li $v0, 4
    	la $a0, line
    	syscall

    	addi $t0, $zero, 0		#counter to 0 
    	addi $t6, $zero, 0 		#counter to 0 
   
    printloop:
    	bge $t0, $s0, exit

	sll $t1, $t0, 2
     	add $t1, $t1, $s7

     	li $v0, 1
     	lw $a0, 0($t1)
     	syscall
     		
     	li $v0, 4			#next number in row
     	la $a0, space	
     	syscall  
     	
     	addi $t0, $t0, 1
     	add $t6, $t6, 1
     	beq $t6, $s5, nextrow		#if row is ended, go to next row
     	j printloop
     	
    nextrow:
     	li $v0, 4
     	la $a0, line
     	syscall
     	li $t6, 0
     	j printloop
      
    exit:
    	li $v0, 10
    	syscall
