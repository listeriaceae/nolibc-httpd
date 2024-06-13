.intel_syntax noprefix

/* functions: rdi, rsi, rdx, rcx, r8, r9 */
/*  syscalls: rdi, rsi, rdx, r10, r8, r9 */
/*                           ^^^         */
/* stack grows from a high address to a low address */

#define c(x, n) \
.global x; \
x:; \
  add r11,n

c(wait4, 1)      /* 61 */
c(exit, 3)       /* 60 */
c(fork, 3)       /* 57 */
c(setsockopt, 4) /* 54 */
c(listen, 1)     /* 50 */
c(bind, 6)       /* 49 */
c(accept, 2)     /* 43 */
c(socket, 38)    /* 41 */
c(close, 1)      /* 03 */
c(open, 1)       /* 02 */
c(write, 1)      /* 01 */
.global read     /* 00 */
read:
  mov r10,rcx
  mov rax,r11
  syscall
  xor r11,r11
  ret

.global _start
_start:
  xor rbp,rbp
  xor r11,r11
  pop rdi     /* argc */
  mov rsi,rsp /* argv */
  call main
  call exit
