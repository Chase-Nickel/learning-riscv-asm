.data
    var_a: .word 4 # int a = 4;
    var_b: .dword 0 # int *b;
    const_out: .ascii "0123456789"
    new_line: .ascii "\n"

.text
.globl _start

_start:
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop

    1:
    auipc ra, %pcrel_hi(write_a)
    jalr ra, ra, %pcrel_lo(1b)
    2:
    auipc ra, %pcrel_hi(write_newline)
    jalr ra, ra, %pcrel_lo(2b)
    3:
    auipc ra, %pcrel_hi(foo)
    jalr ra, ra, %pcrel_lo(3b)
    4:
    auipc ra, %pcrel_hi(write_a)
    jalr ra, ra, %pcrel_lo(4b)
    5:
    auipc ra, %pcrel_hi(write_newline)
    jalr ra, ra, %pcrel_lo(5b)

    addi a7, x0, 93
    addi a0, x0, 0
    ecall


write_a:
    addi a7, x0, 64
    addi a0, x0, 1
    1:
    auipc a1, %pcrel_hi(const_out)
    addi a1, a1, %pcrel_lo(1b)
    2:
    auipc t0, %pcrel_hi(var_a)
    addi t0, t0, %pcrel_lo(2b)
    lw a2, 0(t0)
    addi a2, a2, 1
    ecall
    ret

write_newline:
    addi a7, x0, 64
    addi a0, x0, 1
    1:
    auipc a1, %pcrel_hi(new_line)
    addi a1, a1, %pcrel_lo(1b)
    addi a2, x0, 1
    ecall
    ret


# void foo(void) {
#     int a = 4;
#     int *b;
#
#     b = &a;
#     *b = 7;
# }
foo:
    # b = &a;
    1:
    auipc t0, %pcrel_hi(var_b)  # load the upper 20 bits of the address of b
    addi t0, t0, %pcrel_lo(1b) # load the lower 11 bits of the address of b

    2:
    auipc t1, %pcrel_hi(var_a)  # load the upper 20 bits of the address of a
    addi t1, t1, %pcrel_lo(2b) # load the lower 11 bits of the address of a

    sd t1, 0(t0) # store &a into b

    # *b = 7;
    3:
    auipc t0, %pcrel_hi(var_b)  # load the upper 20 bits of the address of b
    addi t0, t0, %pcrel_lo(3b) # load the lower 11 bits of the address of b

    ld t1, 0(t0) # load the value of b (&a)
    addi t2, x0, 7
    sw t2, 0(t1) # store 7 into a

    ret

