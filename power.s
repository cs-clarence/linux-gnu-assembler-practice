# PURPOSE: Get the power of two operands
# INPUT: Hardcoded values (non-negative)
# OUTPUT: The value will be return as the program's exit code (0-255 only)
.section    .data

.section    .rodata
base:       .8byte 5
exponent:   .8byte 2

.section    .text
.globl      _start

_start:
# push the parameters in reverse order and call the function
push exponent # push the second argument
push base     # push the first argument
call power    # assign the address of the function to %rip (instruction pointer)
              # and pushes the return address of the called function

# visualization of the stack segment of the memory after pushing the return address
# exponent
# base
# return address <- %rsp

# exit the program
mov %rax, %rdi
mov $60, %rax
syscall

.type power, @function
power:
# establish the stack frame
push %rbp       # push the current base pointer register
mov %rsp, %rbp  # assign the value of stack pointer register 
                # as the new value of the base pointer register
                # we will use the base pointer to access the return address,
                # local variables, and parameters

# visualization of the stack segment of the memory after pushing %rbp
# exponent
# base
# return address
# old value of %rbp <- %rsp, %rbp

# copy the base and exponent parameters onto rbx and rcx respectively
mov 16(%rbp), %rbx  # base
mov 24(%rbp), %rcx  # exponent
mov %rbx, %rax      # store the return result to rax

cmp $0, %rcx        # if the rcx (exponent) is 0 then we return 1
je power_set_return_1

power_loop:         # loop to calculate the power
cmp $1, %rcx        
je power_return

imul %rbx, %rax
dec %rcx

jmp power_loop    # go back to the start of the loop

power_set_return_1: # special case if the exponent is set to 0
mov $1, %rax

power_return:       # reset the stackframe back to before 
                    # this function was called and transfer the control back
                    # to the calling function
                    # also transfers back the control to the calling function
mov %rbp, %rsp      # reset the %rsp back to its original value before the call
pop %rbp            # reset the %rbp back to its original value before the call
ret                 # this is equivalent to doing pop %rip
