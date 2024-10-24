.intel_syntax noprefix

.section .rodata
fmt_str: .string "%s\n"
hello_str: .string "hello"

.globl main
.text
main:
    sub rsp, 8
    lea rdi, [fmt_str + rip] 
    lea rsi, [hello_str + rip]
    call printf
    add rsp, 8
    ret
