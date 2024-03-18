# Kyle Jarvis, CS1142, 2/8/2023
# Parts of the main loop, and .data part of this program was assisted by the coaches at the CCLC
# Program 3 for MIPS

.text

li $t9, 10
li $t5, 39
li $t6, 99
li $t3, 1
li $t7, 1
li $t4, 0

start:
# loading proper syscall functions
	li $v0, 8
	li $a1, 100
	la $a0, str
	syscall
# $t0 is iterator
	li $t0, 0 # index for line bytes
loop:
	li $t1, 0 # current word length
inner:
	lb $t2, str($t0) # goto $t0 index in str
	
	seq $s3, $t2, '\n'
	seq $s4, $t0, $zero
	and $s5, $s3, $s4
	bnez $s5, secondhalf # last line was empty
	
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
	beq $t2, '?', endWord
	beq $t2, '(', endWord
	beq $t2, ')', endWord
	beq $t2, ';', endWord
	
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




secondhalf:
	li $t0, 1 # iterator
	li $t1, 0 # smallest
	li $t2, 0 # biggest
	li $t3, 0 # mode
	li $t4, 0 # current byte
	li $t5, 100 # end of array
	li $t6, 0 # and for smallest
	li $t7, 0 # and for biggest
	li $t8, 0	
	li $t9, 0 # mode check
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0 # smallest check
	li $s6, 0 # biggest check
	li $s7, 0
	b smallest




smallest:
	lb $t8, arr($t0)
	addi $t0, $t0, 1
	beqz $t8, smallest
	addi $t0, $t0, -1
	move $t1, $t0
	li $t0, 99
	b biggest

biggest:
	lb $t8, arr($t0)
	addi $t0, $t0, -1
	beqz $t8, biggest
	addi $t0, $t0, 1
	move $t2, $t0
	li $t0, 1
	b mode

mode:
	beq $t0, $t5, print
	lb $t8, arr($t0)
	blt $t9, $t8, modechange
	addi $t0, $t0, 1
	b mode

modechange:
	move $t3, $t0
	move $t9, $t8
	addi $t0, $t0, 1
	b mode
	


print:		
	li $v0, 4
	la $a0, str1
	syscall # print smallest
	
	li $v0, 1
	move $a0, $t1
	syscall	# print smallest number
	
	li $v0, 4
	la $a0, str0 # goto new line
	syscall
	
	li $v0, 4
	la $a0, str2
	syscall	# print biggest
	
	li $v0, 1
	move $a0, $t2
	syscall	# print biggest number
	
	li $v0, 4
	la $a0, str0 # goto new line
	syscall
	
	li $v0, 4
	la $a0, str3
	syscall # print mode
	
	li $v0, 1
	move $a0, $t3
	syscall	# print mode number
	
done:
	li $v0, 10
	syscall

.data
str: .space 110
str1: .asciiz "word length minimum: "
str2: .asciiz "word length maximum: "
str3: .asciiz "word length mode: "
str0: .asciiz "\n"
arr: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0