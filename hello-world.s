# PURPOSE: Print "Hello, World" to the console
# status code back to the Linux kernel
#
# INPUT: none
#
# OUTPUT: returns a status code. This can be viewed
# by typing echo $? on a linux terminal
# after running the program
#
# VARIABLES:
# %rax holds the system call number (sys_write (1) and sys_exit (60))
# %rdi holds the file handler code and exit code
# %rsi holds text string to print
# %rdx holds the length of the string
.section .data

.section .rodata
msg: .ascii "Hello, World\n"
msglen: .8byte 13

.section .text

.globl _start # tells the assembler to not discard this symbol after assembly because this linker will need it during linking

_start: # a symbol with a colon after is a label, it is used to assign instructions or data to a symbol
mov $1, %rax # this is the linux kernel command number (system call) for writing
# ?ax is always used as the register to be loaded with system call numbers
mov $1, %rdi # %rdi is register for file handler code for sys_write, file handler code 1 is stdout
mov $msg, %rsi
mov msglen, %rdx
syscall # write the string

mov $60, %rax # now set the system call number to 60 (exit)
mov $0, %rdi # set the exit code to 0
syscall
