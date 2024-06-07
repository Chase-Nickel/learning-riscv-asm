.data
	A: .asciz "64"
	B: .asciz "19"

.bss
	out: .space 128

.text
.globl _start

_start:
	la a0, A
	call sztoi

	la a1, out
	li a2, 128
	call itos

	add a2, a1, zero
	add a1, a0, zero

	li a7, 64
	li a0, 1
	ecall

	li a0, '\n'
	la a1, out
	sb a0, 0(a1)
	li a0, 1
	li a2, 1
	ecall

	li a7, 93
	li a0, 0
	ecall

# string-zero to integer
# a0: null terminated string
# out: a0 (integer)
# clobbers: a1, t0, t1
sztoi:
	add a1, a0, zero
	li a0, 0
	.L0sztoi:
	lb t0, 0(a1)
	beq t0, zero, .L1sztoi
	lb t0, 0(a1)
	li t1, '0'
	sub t0, t0, t1
	li t1, 10
	mul a0, a0, t1
	add a0, a0, t0
	li t0, 1
	add a1, a1, t0
	j .L0sztoi
	.L1sztoi:
	ret

# integer to string
# a0: integer
# a1: buffer
# a2: buffer length
# out: a0 (string)
#      a1 (length)
# clobbers: a2, a3, t0, t1
itos:
	add a3, a0, zero
	add a0, a1, a2
	beq a3, zero, .L2itos
	li a1, 0
	.L1itos:
	li t0, 1
	sub a0, a0, t0
	add a1, a1, t0
	li t0, 10
	div t1, a3, t0
	mul t1, t1, t0
	sub t1, a3, t1
	div a3, a3, t0
	li t0, '0'
	add t1, t0, t1
	sb t1, 0(a0)
	beq a3, zero, .L3itos
	j .L1itos
	.L2itos:
	li a1, 1
	sub a0, a0, a1
	li t0, '0'
	sb t0, 0(a0)
	.L3itos:
	ret

