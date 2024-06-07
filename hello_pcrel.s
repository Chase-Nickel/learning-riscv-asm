.section .data
    msg: .ascii "Hello, World!\n"

.section .text
.globl _start
_start:
    addi a7, zero, 64
    addi a0, zero, 1
    1:
    auipc a1, %pcrel_hi(msg)
    addi a1, a1, %pcrel_lo(1b)
    addi a2, zero, 14
    ecall

    addi a7, zero, 93
    addi a0, zero, 0
    ecall

