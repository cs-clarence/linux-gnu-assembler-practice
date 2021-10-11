# PURPOSE: Simple program that exits and returns a
# status code back to the Linux kernel
#
# INPUT: none
#
# OUTPUT: returns a status code. This can be viewed
# by typing
#
# echo $?
#
# after running the program
#
# VARIABLES:
# %rax holds the system call number
# %rdi holds the return status
#
.section .data

.section .text

.globl _start # tells the assembler to not discard this symbol after assembly because this linker will need it during linking

_start: # a symbol with a colon after is a label, it is used to assign instructions or data to a symbol
mov $60, %rax # this is the linux kernel command
# number (system call) for exiting
# a program
# ?ax is always used as the register to be loaded with system call numbers

mov $0, %rdi # this is the status number we will
# return to the operating system.
# Change this around and it will
# return different things to
# echo $?
# ?bx is needed to be loaded with a exit status number for an exit system call

syscall # this enters the kernel mode to run the specified system call command (exit)
// operating systems features are accessed through system calls
