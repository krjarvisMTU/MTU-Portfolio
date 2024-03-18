# Kyle Jarvis, CS1142, 2/8/2023
# Parts of the main loop, and .data part of this program was assisted by the coaches at the CCLC
# Program 1 for MIPS

# $v0 8 is reading in our string

.text
	li $t0, 0 # word count
start:
	li $v0, 8 
	li $a1, 100 
	la $a0, string
	
	syscall

	li $t1, 0 # counter
	li $t3, 10 # end of a line

	loop:
		lb $t2, string($t1) # loading byte of index
		beq $t2, $t3, exit # exit if t2 is zero
		addi $t1, $t1, 1 #add one to t1
	
	
		beq $t2, ' ', counter # branch to counter if there is a space
		beq $t2, '/', counter # branch to counter if there is a slash
	
		b loop # branch back to loop2
	
		counter: 
			addi $t0, $t0, 1 # adds one to word count if there is a word
	
		b loop # jump back to loop 2
	
exit:
	addi $t0, $t0, 1
	bgtz $t1, start # branches if t1 (counter) is zero
	addi $t0, $t0, -1
	
	li $v0, 1
	move $a0, $t0
	syscall

.data

string: .space 110

