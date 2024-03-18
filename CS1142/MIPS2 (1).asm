# Kyle Jarvis, CS1142, 2/8/2023
# Parts of the main loop, and .data part of this program was assisted by the coaches at the CCLC
# Program 2 for MIPS

.text

li $t9, 10
li $t5, 39
li $t6, 99
li $t3, 1
li $t7, 1

start:
# loading proper syscall functions
	li $v0, 8
	li $a1, 100
	la $a0, str
	syscall
#$t0 is iterator
	li $t0, 0 # index for line bytes
loop:
	li $t1, 0 # current word length
inner:
	lb $t2, str($t0 # goto $t0 index in str
	
	seq $s3, $t2, '\n'
	seq $s4, $t0, $zero
	and $s5, $s3, $s4
	bnez $s5, printloop # last line was empty
	
	beq $t2, $t5, isWord
	beq $t2, '-', isWord
	
	sge $s0, $t2, 'A'
	sle $s1, $t2, 'Z'
	and $s2, $s0, $s1
	bnez $s2, isWord
	sge $s0, $t2, 'a'
	sle $s1, $t2, 'z'
	and $s2, $s0, $s1
	bnez $s2, isWord
	
	beq $t2, ' ', endWord
	beq $t2, '/', endWord
	beq $t2, '\n', endWord
	beq $t2, ',', endWord
	beq $t2, '.', endWord
	beq $t2, '!', endWord
	beq $t2, ':', endWord
	
	beq $t2, '\n', start
	beq $t2, $zero, start
	
	addi $t0, $t0, 1 # no important characters, goto loop for new word
	b loop
isWord:
	addi $t1, $t1, 1
	addi $t0, $t0, 1
	b inner
	
endWord:
	lb $t8, arr($t1)
	addi $t8, $t8, 1
	sb $t8, arr($t1)
	addi $t0, $t0, 1
	b loop







printloop:
	bgt $t3, $t6, done # check if all words have been looked at
	lb $t5, arr($t3)
	beqz $t5, increment # check if no words exist
	
	li $v0, 1
	move $a0, $t7
	syscall	# print word legnth
	
	li $v0, 4
	la $a0, str1
	syscall	#print formatting
	
	li $v0, 1
	lb $a0, arr($t3)
	syscall	# print word count
	
	li $v0, 4
	la $a0, str2 # goto new line
	syscall
	
increment:
	addi $t7, $t7, 1
	addi $t3, $t3, 1
	b printloop
	
	
	
done:
	li $v0, 10
	syscall

.data
str: .space 110
str1: .asciiz "-character words: "
str2: .asciiz "\n"
arr: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
