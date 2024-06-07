.data
	hello: .ascii "Hello, world!\n"

.text
.globl _start

_start:
	la a0, hello
	li a1, 'H'
	sb a1, 0(a0)

	li a7, 64
	li a0, 1
	la a1, hello
	li a2, 14
	ecall

	li a7, 93
	li a0, 0
	ecall

