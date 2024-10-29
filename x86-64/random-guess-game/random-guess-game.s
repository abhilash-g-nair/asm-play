.intel_syntax noprefix

.section .rodata
prompt_msg: .string "Guess a number from 0 to 9: "
correct_num_msg: .string "Correct number: "
guessed_correct_msg: .string "You guessed correct!\n"
guessed_wrong_msg: .string "You guessed wrong!\n"
newline_char: .byte 10

.bss
read_buf: .zero 1
rand_uint_buf: .zero 4
buf: .zero 32

.globl _start
.text
_start:
    push rbx
    push r12

    lea rdi, [prompt_msg + rip]
    call str_print

    mov rax, 0
    mov rdi, 0
    lea rsi, [read_buf +  rip]
    mov rdx, 1
    syscall

    xor ebx, ebx
    mov bl, BYTE PTR [read_buf]
    sub bl, 48

    mov rax, 318
    lea rdi, [rand_uint_buf + rip]
    mov rsi, 4
    mov rdx, 0
    syscall

    mov eax, DWORD PTR [rand_uint_buf + rip]
    mov edi, 10
    div edi
    mov r12d, edx

    lea rdi, [correct_num_msg + rip]
    call str_print

    mov edi, r12d
    lea rsi, [buf + rip]
    call uint_to_str
    lea rdi, [buf + rip]
    call str_print
    lea rdi, [newline_char + rip]
    mov rsi, 1
    call write_to_stdout

    cmp ebx, r12d
    je L7
    lea rdi, [guessed_wrong_msg + rip]
    call str_print
    jmp L8
L7:
    lea rdi, [guessed_correct_msg + rip]
    call str_print
L8:
    pop rbx
    pop r12

    mov rax, 60
    mov rdi, 0
    syscall

#rem in edx, quotient in eax
uint_to_str:
    mov r11d, 10
    xor r10, r10
    mov eax, edi
L6:
    xor edx, edx
    div r11d
    add edx, 48
    mov BYTE PTR [rsi + r10], dl
    add r10, 1
    test eax, eax
    jnz L6 
    mov BYTE PTR [rsi + r10], 0
    mov rdi, rsi
    call str_reverse
    ret

str_print:
    push rbx
    mov rbx, rdi
    call str_len
    mov rsi, rax
    mov rdi, rbx
    call write_to_stdout
    pop rbx
    ret

write_to_stdout:
    mov rdx, rsi
    mov rsi, rdi
    mov rdi, 1
    mov rax, 1
    syscall
    ret

str_len:
    xor rax, rax
L1:
    cmp BYTE PTR [rdi + rax], 0
    je L2
    add rax, 1
    jmp L1
L2:
    ret

    
str_reverse:
    push rbx
    mov rbx, rdi #rbx stores the str address
    call str_len
    test rax, rax
    jz L3 #return if str_len returns 0
    mov rdi, rbx #rdi will have start of str
    lea rsi, [rbx + rax - 1] #rsi will have end of str
    shr rax, 1
L4:
    test rax, rax
    jz L3
    mov dl, BYTE PTR [rdi]
    mov cl, BYTE PTR [rsi]
    mov BYTE PTR [rdi], cl
    mov BYTE PTR [rsi], dl
    add rdi, 1
    sub rsi, 1
    sub rax, 1
    jmp L4
L3:
    pop rbx
    ret

    
