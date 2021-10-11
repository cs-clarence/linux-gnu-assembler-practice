# PURPOSE: Get the factorial of a given number
# INPUT: Hardcoded values (non-negative and non-zero)
# OUTPUT: The value will be return as the program's exit code (0-255 only)
#         Use `echo $?` to get the exit code on a linux machine
.section    .data

.section    .rodata
input:      .8byte 5

.section    .text
.globl      _start

_start:
# push the parameters in reverse order and call the function
push input        # push input as the first argument
call factorial    # assign the address of the function to %rip (instruction pointer)
                  # and pushes the return address of the called function

add $8, %rsp      # clean the stack

# exit the program
mov %rax, %rdi    # set the return of the function as the exit code
mov $60, %rax     # set 60 (exit) as the system call number to %rax
syscall           # switch to kernel mode

/*
 * Computes the factorial of a number through recursion
 *
 * Parameters:
 *    param1 - the number to get the factorial of
 *
 * Return: the result of the factorial (stored in %rax)
 */
.type factorial, @function
factorial:
# create the stack frame
push %rbp       # push the current base pointer register
mov %rsp, %rbp  # assign the value of stack pointer register 
                # as the new value of the base pointer register
                # we will use the base pointer to access the return address,
                # local variables, and parameters

# copy the input to %rbx
mov 16(%rbp), %rax  # copy input to %rax


# if the input is less than or equals to 1 then we're done
cmp $1, %rax
jle return_factorial


// n! = n * (n - 1)!
# mov %rax, rbx # IMPORTANT: Never do this, it causes bugs
dec %rax          # decrement the value of %rax by 1
push %rax         # then call factorial with it
call factorial    # the value returned by the function will be stored in %rax

mov 16(%rbp), %rbx  # copy the input to %rbx

# IMPORTANT:  You might ask; 
#             Why pull the value again from the stack?
#             Why not just copy the value of from %rax?
#             Can we put the line above before the call to factorial?
# ANSWER:     Always assume that after a function call, the values we stored
#             in registers are altered or destroyed.
#             Therefore we must pull refresh the values of registers after a function call.

imul %rbx, %rax     # multiply the input to the result of factorial of (input - 1)

return_factorial:
mov %rbp, %rsp      # reset the %rsp back to its original value before the call
pop %rbp            # reset the %rbp back to its original value before the call
ret                 # this is equivalent to doing pop %rip
