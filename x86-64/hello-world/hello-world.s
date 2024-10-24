.intel_syntax noprefix

.section .rodata
hello:
    .string "hello world\n"

.text
.globl _start
_start:
    mov rax, 1
    mov rdi, 0
    lea rsi, hello[rip]
    mov rdx, 13
    syscall
    mov rax, 60
    mov rdi, 0
    syscall

