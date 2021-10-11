# PURPOSE: Test the stack of a program
.section .data
.section .rodata
.section .text
.globl _start
_start:
push $2 # push the value 2 onto the stack
pop %rdi # pop the value on the top of the stack and assign that value to %rdi
mov $60, %rax # assign 60 to the system call number
syscall # open kernel mode
