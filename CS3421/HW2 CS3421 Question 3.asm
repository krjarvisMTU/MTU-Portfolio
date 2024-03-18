# Kyle Jarvis, CS3421 R02 Spring 2024, Homework 2 Question 3

.text
.globl main

main:
    # Implementing nop in three different ways
    nop                                     # Direct use of nop
    sll $zero, $zero, 0                     # Using sll with zero shift
    or $zero, $zero, $zero                  # Moving zero to zero

    # Loading a 32-bit constant into $s3
    lui $at, upper16(<32-bit constant>)     # Load upper 16 bits of the constant into $at
    ori $s3, $at, lower16(<32-bit constant>)# OR lower 16 bits with $at and store in $s3

    # Integer division: s3 = s0 / s1
    div $s0, $s1
    mflo $s3                                # Move the quotient from LO to $s3

    
    li $v0, 10                              # Load the exit syscall code
    syscall                                 # Make the syscall to exit the program
