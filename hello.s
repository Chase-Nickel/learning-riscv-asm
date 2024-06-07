.data
    banana: .dword 0
    hello: .ascii "Hello, world!\n"

.text
.globl _start

_start:
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

	li a7, 64
	li a0, 1
	la a1, hello
	li a2, 14
	ecall

	li a7, 93
	li a0, 0
	ecall

