.intel_syntax noprefix

.section .rodata
str1: .string "hello\n"
str2: .string "world\n"

.globl _start
.text
_start:
    lea rdi, [str1 + rip]
    call toy_puts
    mov rax, 60
    mov rdi, 0
    syscall

toy_puts:
    mov rsi, rdi
    mov rdx, 0
L1:
    cmp BYTE PTR [rsi + rdx], 0
    je L2
    add rdx, 1
    jmp L1
L2:
    mov rax, 1
    mov rdi, 1
    syscall
    ret

