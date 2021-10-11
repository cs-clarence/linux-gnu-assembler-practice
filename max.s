# PURPOSE: Find the element with the greatest value in the list
# VARIABLES:
#   %rax - will hold the system call number
#   %rcx - will hold the index of the element being inspected in the list 
#   %rdx - will hold the value of the element being inspected in the list
#   %rdi - will hold the value of highest seen value

.section .data # section for bytes of memory for read and writable memory
  data_items: .8byte 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 0 # 0 is the terminating element
  # this way of terminating a list should be changed for a better mechanism
  # data_items is a symbol/label, it is no more than tool to represent a data or instruction
  # labels will be substituted by the action memory address that it represents when assembled
  # data_items will represent the address of the first element of the list
  # .8byte direction will reserve memory for the list of numbers 
  # then initialize the value of the numbers to those memory

.section .text # section for bytes of memory that is intended to be read-only
  .globl _start

  _start:
    mov $0, %rcx # since this is the start of the inspect, assign 0 to the index
    mov data_items(, %rcx, 8), %rdx # get the element positioned at index from data_items
    mov %rdx, %rdi # currently, the highest value is the first one in the list

  start_loop:
    cmp $0, %rdx # check to see if we've hit the end of the list (the current value is 0)
    je exit_loop # if yes, exit the loop (je = jump if equal)

    inc %rcx # if not, increment the value of the current index by 1

    mov data_items(, %rcx, 8), %rdx # assign the value of the next element in the list to %rdx

    cmp %rdi, %rdx  # compare values of rdx to rdi 
    jle start_loop  # if current element (%rdx) is less than the current highest value (rdi)
                    # there's nothing to do so go back to the start of the loop
                    # (jle = jump if less than or equal)

    mov %rdx, %rdi  # if the comparision in the previous lines fails, 
                    # it means that the current value is higher than the highest value seen previously
                    # so set the current value as the highest

    jmp start_loop  # unconditional jump to start of the loop

  exit_loop:
    mov $60, %rax # exit system call
    syscall
