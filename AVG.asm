.data

entMSG:	.asciiz "Welcome to test program.\n"
byeMSG:	.asciiz "\nGood bye"
avgMSG:	.asciiz "Average of the array is "

arr:	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
size:	.word 10

.text
.globl	main

main:	li $v0, 4
	la $a0, entMSG		# Prints first message. 
	syscall

	li $v0, 4
	la $a0, avgMSG		# Prints average message.
	syscall
		
	jal avg			# Operates function.
			
	li $v0, 1
	add $a0, $v1, $0	# Prints average value.
	syscall
	
	li $v0, 4
	la $a0, byeMSG		# Prints end message.
	syscall
	
	li $v0, 10		# End
	syscall

# Passing arguments are "$a1" for array and "$a2" for size.
# Return register is $v1.
# Returns the average value of the array of elements.
avg:	la   $a1, arr				# Function head. (Assigning arguments.)
	lw   $a2, size	 
	addi $t0, $t0, 0 			# Assigning values.
	
	avg_F: 	beq  $t0, $a2, avg_FD		# If iterator $t0 is same with size $a2.
		lw   $t1, 0($a1)		
		add  $v1, $v1, $t1		# Add a[i] to $v1.
		addi $t0, $t0, 1		# Increase iterator.
		addi $a1, $a1, 4		# Increase array pointer.
		j   avg_FD			# Jumps to beginning of the function.

	avg_FD:
		mul $t1, $a2, 4			
		sub $a1, $a1, $t1		# Goes to beginning position of array.
		div $v1, $v1, $a2		# Calculatess average value.
		jr  $ra				# Jumps to return address.
