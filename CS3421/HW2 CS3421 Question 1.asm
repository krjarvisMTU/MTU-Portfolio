# Kyle Jarvis, CS3421 R02 Spring 2024, Homework 2 Question 1

.data
A: .word 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160  # Example array A
B: .word 1, 2, 3, 4, 5, 6, 7, 14, 9, 10, 11, 12, 13, 14, 15, 16  # Example array B
newline: .asciiz "\n"

.text
.globl main

main:
li $s1, 2

    la $s6, A   # Load the base address of array A into $s6
    la $s7, B   # Load the base address of array B into $s7

    # Load B[7]
    lw $t0, 28($s7)
    move $a0, $t0
    li $v0, 1
    syscall  # Print B[7]
    la $a0, newline
    li $v0, 4
    syscall  # Print newline

    # Load B[12]
    lw $t1, 48($s7)
    move $a0, $t1
    li $v0, 1
    syscall  # Print B[12]
    la $a0, newline
    li $v0, 4
    syscall  # Print newline

    sub $t2, $t0, $t1
    sll $t2, $t2, 2
    add $t4, $s6, $t2
    lw $t3, 0($t4)

    move $a0, $t3
    li $v0, 1
    syscall  # Print A[B[7]-B[12]]
    la $a0, newline
    li $v0, 4
    syscall  # Print newline

    add $s0, $s1, $t3  # $s1 contains some value for 'g'

    move $a0, $s0     # Move the result into $a0 for printing
    li $v0, 1         # Set $v0 to 1 for printing an integer
    syscall           # System call to print the integer in $a0
    
    la $a0, newline   # Load the address of the newline character into $a0
    li $v0, 4         # Set $v0 to 4 for printing a string
    syscall           # System call to print the newline