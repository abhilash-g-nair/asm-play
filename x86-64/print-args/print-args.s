.intel_syntax noprefix

.globl _start

.section .rodata
newln: .byte '\n'
str0: .string "arg count: "

.bss
print_buf: .zero 32

.text
_start:
    lea rdi, [str0 + rip]
    call print_str
    mov edi, DWORD PTR [rsp]
    lea rsi, [print_buf + rip]
    call i32_to_str
    lea rdi, [print_buf + rip]
    call print_str
    call print_newln
    mov rbx, 8
.L8:
    mov rdi, QWORD PTR [rsp + rbx]
    test rdi, rdi
    je .L7
    call print_str
    call print_newln
    add rbx, 8
    jmp .L8
.L7:
    mov rdi, 0
    mov rax, 60
    syscall

i32_to_str:
    xor r8, r8
    mov r11, rsi
    mov eax, edi
    test eax, eax
    jns .L4
    add r11, 1
    mov BYTE PTR [rsi + r8], 45
    add r8, 1
    neg eax
.L4:
    mov edi, 10
    xor edx, edx
    div edi
    add edx, 48
    mov BYTE PTR [rsi + r8], dl
    add r8, 1
    test eax, eax
    jne .L4
    mov BYTE PTR [rsi + r8], 0
    mov r9, rsi
    add r9, r8
    shr r8, 1
    xor r10, r10
.L6:
    cmp r8, r10
    je .L5
    mov al, BYTE PTR [r11]
    mov cl, BYTE PTR [r9 - 1]
    mov BYTE PTR [r11], cl
    mov BYTE PTR [r9 - 1], al
    add r10, 1
    add r11, 1
    sub r9, 1
    jmp .L6
.L5:
    ret

print_str:
    xor rdx, rdx
.L2:
    cmp BYTE PTR [rdi + rdx], 0
    je .L1
    add rdx, 1
    jmp .L2
.L1:
    test rdx, rdx
    je .L3
    mov rsi, rdi
    mov rdi, 1
    mov rax, 1
    syscall
.L3:
    ret

print_newln:
    mov rax, 1
    mov edi, 1
    lea rsi, [newln + rip]
    mov rdx, 1
    syscall
    ret
