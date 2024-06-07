# void swap(int *xp, int *yp) {
#     int t0 = *xp;
#     int t1 = *yp;
#     *xp = t1;
#     *yp = t0;
# }

swap:
    # a0 = int *xp
    # a1 = int *yp
    lw t0, 0(a0)
    lw t1, 0(a1)
    sw t1, 0(a0)
    sw t0, 0(a1)
    ret
