.data 
	array: .space 400
	
	message1: .asciiz "Enter the length of the array:\n"
	message2: .asciiz "Enter numbers with Enter after each:\n"
	message3: .asciiz "\nEntered: "
	message4: .asciiz "\nResult: "
	space: .asciiz " "
	
.text
	main:
		li $v0, 4		#printing length
		la $a0, message1
		syscall
		
		li $v0, 5
		syscall
		beqz $v0, exit		#checking for 0
					#close if it is
		move $s0, $v0
				
		li $v0, 4
		la $a0, message2
		syscall
		jal  read
					#reading array
		li $v0, 4
		la $a0, message3
		jal  print
		
		jal bubblesort		#sorting
		
		li $v0, 4
		la   $a0, message4
		syscall			#answer
		jal print
		
	exit:
		li $v0, 10
		syscall
	
	read: 
		addi $t0, $zero, 0	#counter
		la $s1, array     	#load in array
	readnumber:
		move $t1, $t0
		sll  $t1, $t1, 2
		addu $t1, $t1, $s1
		
		li $v0, 5
		syscall
		
		sw   $v0, 0($t1)
		addi $t0, $t0, 1 	#counter
		blt  $t0, $s0, readnumber
		
		jr $ra
	
	print:	
		addi $s4, $zero, 0	#counter
		
	printnumber:
		move $s2, $s4
		sll  $s2, $s2, 2
		addu $s2, $s2, $s1
		lw   $s2, 0($s2)
	
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		addi $s4, $s4, 1	#counter
		blt  $s4, $s0, printnumber
		
		jr   $ra		
		

	bubblesort:
		addu $t5, $zero, $ra		#we need to return here,if we don't write 
		la   $s1, array			# this line ra is overwrtied and output is just zeroes
		move $s2, $s0			#counter
		subi $s2, $s2, 1		#counter
				
	kloop:
		addi $s3, $zero, 0		#counter
		
	jloop:
		move $s4, $s3	
		move $s5, $s3	
		addi $s5, $s5, 1	
		
		sll  $s4, $s4, 2
		sll  $s5, $s5, 2
		
		addu $s4, $s4, $s1	
		addu $s5, $s5, $s1	
		lw   $t6, 0($s4)	#loading numbers to compare
		lw   $t7, 0($s5)	
		
		blt  $t6, $t7, skip

		jal swap

	skip:
		
		addi $s3, $s3, 1
		blt  $s3, $s2, jloop
		
		subi $s2, $s2, 1
		bgez $s2, kloop
		
		jr   $t5		#return to swap
	swap:
		sw $t6, 0($s5)		#swapping
		sw $t7, 0($s4)
		
		jr $ra			#return to swap
