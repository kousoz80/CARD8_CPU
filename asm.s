 org 0
EOF: = 255
ERROR: = -1
NULL: = 0
SPACE: = 32
CR: = 13
LF: = 10
PLUS: = 43
MINUS: = 45
ESC: = 27
NaN: = 0x800000
STACK_SIZE: = 8000
SIZEOF_CHAR: = 1
SIZEOF_SHORT: = 1
SIZEOF_INT: = 3
SIZEOF_LONG: = 3
KEY_DATA: = 0xfffffd
PRT_STB: = 0xfffffe
PRT_DATA: = 0xffffff
_start:
 x=__stack_top
 sp=x
 call main
_end_loop:
 jmp _end_loop
mul:
 x=r0+2
 a=(x)
 x=__0x800000+2
 a&=(x)
 x=r1+2
 a+=(x)+cf
 x=__sgn
 (x)=a
 x=(r0)
 x-=(__0x800000)
 jc mul1
 x=0
 x-=(r0)
 (r0)=x
mul1:
 x=(r1)
 x-=(__0x800000)
 jc mul2
 x=0
 x-=(r1)
 (r1)=x
mul2:
 call umul
 x=__sgn
 a=(x)
 x=__0x800000+2
 a&=(x)
 jz mul3
 x=0
 x-=(__ans)
 (__ans)=x
mul3:
 ret
umul:
 x=0
 (__ans)=x
umul1:
 a&=(x)
 x=r1+2
 ror (x)
 x--
 ror (x)
 x--
 ror (x)
 jnc umul2
 x=(__ans)
 x+=(r0)
 (__ans)=x
umul2:
 a&=(x)
 x=r0
 rol (x)
 x++
 rol (x)
 x++
 rol (x)
 x=0
 x+=(r1)
 jnz umul1
 ret
div:
 x=0
 x+=(r1)
 jz div_zero
 x=r0+2
 a=(x)
 x=__0x800000+2
 a&=(x)
 x=r1+2
 a+=(x)+cf
 x=__sgn
 (x)=a
 x=(r0)
 x-=(__0x800000)
 jc div1
 x=0
 x-=(r0)
 (r0)=x
div1:
 x=(r1)
 x-=(__0x800000)
 jc div2
 x=0
 x-=(r1)
 (r1)=x
div2:
 call udiv
 x=__sgn
 a=(x)
 x=__0x800000+2
 a&=(x)
 jz div3
 x=0
 x-=(__ans)
 (__ans)=x
div3:
 ret
udiv:
 x=(r1)
 x-=(r0)
 jb div_under
 x=0
 (__ans)=x
 x+=(r0)
 jz div_zero
udiv1:
 x=__ans+2
 ror (x)
 x--
 ror (x)
 x--
 ror (x)
 x=r0
 rol (x)
 x++
 rol (x)
 x++
 rol (x)
 x=(r1)
 x-=(r0)
 jnb udiv1
udiv2:
 a&=(x)
 x=r0+2
 ror (x)
 x--
 ror (x)
 x--
 ror (x)
 x=(r1)
 x-=(r0)
 jb udiv3
 (r1)=x
udiv3:
 x=__ans
 rol (x)
 x++
 rol (x)
 x++
 rol (x)
 jc udiv2
 ret
div_zero:
 x=NaN
 (__ans)=x
 ret
div_under:
 x=0
 (__ans)=x
 ret
getchar:
 x=KEY_DATA
 a=0
 (x)=a
getchar1:
 a=0
 a|=(x)
 jz getchar1
 x=r0
 (x)=a
 a=0
 x++
 (x)=a
 x++
 (x)=a
 call putchar
 ret
putchar:
 x=r0
 a=(x)
 x=PRT_DATA
 (x)=a
 a=1
 x=PRT_STB
 (x)=a
 ret
prints:
 x=(r0)
 (__p6)=x
__prints1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p6)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L214
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 ret
L214:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p6)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call putchar
 x=(__p6)
 x++
 (__p6)=x
 jmp __prints1
printd:
 call dec
 call prints
 ret
nl:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=32
 (r0)=x
 call putchar
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=LF
 (r0)=x
 call putchar
 ret
cls:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=32
 (r0)=x
 call putchar
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=12
 (r0)=x
 call putchar
 ret
inkey:
 x=KEY_DATA
 a=(x)
 x=r0
 (x)=a
 a=0
 x++
 (x)=a
 x++
 (x)=a
 x=KEY_DATA
 ret
inputs:
 x=(r0)
 (__p6)=x
__inputs1:
 call getchar
 x=__p5
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__p5
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=LF
 (r0)=x
 x=(r1)
 x-=(r0)
 jz __inputs2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__p5
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(__p6)
 y=r0
 a=(y)
 (x)=a
 x=(__p6)
 x++
 (__p6)=x
 jmp __inputs1
__inputs2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(__p6)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__p5
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 ret
strcmp:
 x=(r0)
 (__p2)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r0)
 (__p1)=x
__strcmp1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x-=(r0)
 jz L255
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
L255:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L256
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L256:
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 jmp __strcmp1
strncmp:
 x=(r0)
 (__p3)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (__p2)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (__p1)=x
__strncmp1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L263
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L263:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x-=(r0)
 jz L264
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
L264:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L265
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L265:
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 x=(__p3)
 x--
 (__p3)=x
 jmp __strncmp1
strcpy:
 x=(r0)
 (__p2)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r0)
 (__p1)=x
__strcpy1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(__p2)
 y=r0
 a=(y)
 (x)=a
 x=(r0)
 (__p3)=x
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz __strcpy1
 ret
strncpy:
 x=(r0)
 (__p3)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (__p2)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (__p1)=x
__strncpy1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L281
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(__p2)
 y=r0
 a=(y)
 (x)=a
 ret
L281:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(__p2)
 y=r0
 a=(y)
 (x)=a
 x=(r0)
 (__p4)=x
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 x=(__p3)
 x--
 (__p3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz __strncpy1
 ret
strcat:
 x=(r0)
 (__p2)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r0)
 (__p1)=x
__strcat1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L291
 x=(__p2)
 x++
 (__p2)=x
 jmp __strcat1
L291:
__strcat2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(__p2)
 y=r0
 a=(y)
 (x)=a
 x=(r0)
 (__p3)=x
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz __strcat2
 ret
strncat:
 x=(r0)
 (__p3)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (__p2)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (__p1)=x
__strncat1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L301
 x=(__p2)
 x++
 (__p2)=x
 jmp __strncat1
L301:
__strncat2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L303
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(__p2)
 y=r0
 a=(y)
 (x)=a
 ret
L303:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(__p2)
 y=r0
 a=(y)
 (x)=a
 x=(r0)
 (__p4)=x
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 x=(__p3)
 x--
 (__p3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz __strncat2
 ret
strstr:
 x=(r0)
 (__p2)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r0)
 (__p1)=x
__strstr1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L313
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 ret
L313:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r0)
 (__p3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 x=(r0)
 (__p4)=x
__strstr2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x-=(r0)
 jz L317
 x=(__p1)
 x++
 (__p1)=x
 jmp __strstr1
L317:
 x=(__p3)
 x++
 (__p3)=x
 x=(__p4)
 x++
 (__p4)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz __strstr2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 ret
strlen:
 x=(r0)
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (__p2)=x
__strlen1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L326
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 ret
L326:
 x=(__p1)
 x++
 (__p1)=x
 x=(__p2)
 x++
 (__p2)=x
 jmp __strlen1
atoi:
 x=(r0)
 (__p2)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r0)
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (__p3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (__p4)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=PLUS
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L333
 x=(__p1)
 x++
 (__p1)=x
L333:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=MINUS
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L334
 x=(__p1)
 x++
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r0)
 (__p3)=x
L334:
__atoi1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (__p5)=x
__atoi2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p5)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L338
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p3)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 ret
L338:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S2
 x+=(__p5)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x-=(r0)
 jz L339
 x=(__p5)
 x++
 (__p5)=x
 jmp __atoi2
L339:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 call umul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p5)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (__p4)=x
 x=(__p1)
 x++
 (__p1)=x
 jmp __atoi1
itoa:
 x=(r0)
 (__p2)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r0)
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L345
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S3
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__nbuf
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__nbuf
 (r0)=x
 ret
L345:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__nbuf
 (r0)=x
 x=(r0)
 (__p3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (__p4)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r0)
 (__p5)=x
__itoa1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p5)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz __itoa2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p5)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 call udiv
 x=(__ans)
 (r0)=x
 x=(r0)
 (__p5)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 call umul
 x=(__ans)
 (r0)=x
 x=(r0)
 (__p4)=x
 jmp __itoa1
__itoa2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 call udiv
 x=(__ans)
 (r0)=x
 x=(r0)
 (__p5)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p5)
 (r0)=x
 call umul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r0)
 (__tmp)=x
 x=(r1)
 (r0)=x
 x=(__tmp)
 (r1)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S4
 x+=(__p5)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=(__p3)
 y=r0
 a=(y)
 (x)=a
 x=(__p3)
 x++
 (__p3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p2)
 (r0)=x
 call udiv
 x=(__ans)
 (r0)=x
 x=(r0)
 (__p4)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p4)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz __itoa2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(__p3)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__nbuf
 (r0)=x
 ret
bin:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=2
 (r0)=x
 call itoa
 ret
oct:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=8
 (r0)=x
 call itoa
 ret
dec:
 x=(r0)
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L369
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call itoa
 ret
L369:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=0
 x-=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call itoa
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=MINUS
 (r0)=x
 x=__sign
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=__sign
 (r0)=x
 ret
hex:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=16
 (r0)=x
 call itoa
 ret
restore:
 x=(r0)
 (read_p)=x
 ret
read:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(read_p)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=3
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (read_p)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1+-1+-1
 x+=(read_p)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 ret
abs:
 x=(r0)
 (__p1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L383
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 ret
L383:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(__p1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 ret
__000:
 int 0
__001:
 int 1
__0x800000:
 int 0x800000
__NaN:
 int NaN
VARIABLE: = 1
COMMAND: = 2
FUNCTION: = 3
NUMBER: = 4
DELIMIT: = 5
STRING: = 6
LABEL: = 7
EOL: = 8
COUNT: = 9
ARRAY: = 10
DONE: = 1
TERMINATE: = 2
QUIT: = 3
MAX_TEXT_LENGTH: = 255
MAX_STR_LENGTH: = 64
ARRAY_SIZE: = 4096
PROG_SIZE: = 65536
NUM_VAR_SIZE: = SIZEOF_LONG
STR_VAR_SIZE: = MAX_STR_LENGTH
VALUE_SIZE: = MAX_STR_LENGTH+SIZEOF_LONG
FOR_STACK_SIZE: = 1024
GOSUB_STACK_SIZE: = 1024
CALC_STACK_SIZE: = 8192
LABEL_HEADER: = 64
A_QUOT: = 39
DBL_QUOT: = 34
EOF_STRING:
 int 255
 = 0
Program.length: += SIZEOF_LONG
Program.lineno: += SIZEOF_LONG
Program.text: += SIZEOF_LONG
Program.SIZE: += 0
 = 0
_ForStack.var: += SIZEOF_LONG
_ForStack.limit: += SIZEOF_LONG
_ForStack.step: += SIZEOF_LONG
_ForStack.program: += SIZEOF_LONG
_ForStack.token_p: += SIZEOF_LONG
_ForStack.SIZE: += 0
 = 0
_GosubStack.program: += SIZEOF_LONG
_GosubStack.token_p: += SIZEOF_LONG
_GosubStack.SIZE: += 0
 = 0
_Command.keyword: += SIZEOF_LONG
_Command.func: += SIZEOF_LONG
_Command.SIZE: += 0
 = 0
_Function.keyword: += SIZEOF_LONG
_Function.func: += SIZEOF_LONG
_Function.SIZE: += 0
 = 0
Value.type: += SIZEOF_LONG
Value.data: += SIZEOF_LONG
Value.SIZE: += 0
Command:
 int S5
 int cmd_run
 int S6
 int cmd_if
 int S7
 int cmd_for
 int S8
 int cmd_next
 int S9
 int cmd_goto
 int S10
 int cmd_gosub
 int S11
 int cmd_return
 int S12
 int cmd_print
 int S13
 int cmd_input
 int S14
 int cmd_clear
 int S15
 int cmd_new
 int S16
 int cmd_end
 int S17
 int cmd_list
 int S18
 int cmd_run
 int S19
 int cmd_stop
 int S20
 int cmd_cont
 int S21
 int cmd_then
 int S22
 int cmd_else
 int NULL
 int NULL
Function:
 int S23
 int func_abs
 int S24
 int func_sgn
 int S25
 int func_chrs
 int S26
 int func_asc
 int S27
 int func_mids
 int S28
 int func_lefts
 int S29
 int func_rights
 int S30
 int func_inputs
 int S31
 int func_inkeys
 int S32
 int func_strs
 int S33
 int func_hexs
 int S34
 int func_bins
 int S35
 int func_octs
 int S36
 int func_val
 int S37
 int func_len
 int S38
 int func_instr
 int NULL
 int NULL
clear_program:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=(r0)
 (EndProg)=x
 ret
serch_line:
 x=(r0)
 (xmode)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (xlineno)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r0)
 (jj)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=(r0)
 (pp)=x
serch_line1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz serch_line4
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xmode)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L496
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xlineno)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz serch_line3
L496:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xmode)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jz serch_line2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xlineno)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L498
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(jj)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xlineno)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz serch_line3
L498:
serch_line2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r0)
 (jj)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (xx)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xx)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (pp)=x
 jmp serch_line1
serch_line3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xlineno)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 ret
serch_line4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 ret
exec_basic:
 x=(r0)
 (CurrentProg)=x
 call clear_value
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 (r0)=x
 call exec_basic2
 ret
exec_basic2:
 x=(r0)
 (TokenP)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (status)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L519
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S47
 (r0)=x
 call assertError
L519:
exec_basic2_1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(BreakFlg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz exec_basic2_2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (BreakFlg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r0)
 (BreakProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 (r0)=x
 x=(r0)
 (BreakToken)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S48
 (r0)=x
 call assertError
exec_basic2_2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=COMMAND
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz exec_basic2_3
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenCode)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_Command.SIZE
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r0)
 (no)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=Command
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(no)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=_Command.func
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=$+10
 push x
 x=(r0)
 jmp (x)
 x=(r0)
 (status)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(status)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L531
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(status)
 (r0)=x
 ret
L531:
 jmp exec_basic2_1
exec_basic2_3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L534
 call cmd_let
 jmp exec_basic2_1
L534:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz exec_basic2_4
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L537
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 ret
L537:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L539
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 ret
L539:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 jmp exec_basic2_1
exec_basic2_4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz exec_basic2_5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=58
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L545
 call getToken
 jmp exec_basic2_1
L545:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S53
 (r0)=x
 call assertError
exec_basic2_5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S55
 (r0)=x
 call assertError
 ret
assertError:
 x=(r0)
 (mesg)=x
 x=(StackSave)
 sp=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L556
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(mesg)
 (r0)=x
 call prints
 call nl
 jmp basic_entry
L556:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S58
 (r0)=x
 call prints
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 call printd
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S59
 (r0)=x
 call prints
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(mesg)
 (r0)=x
 call prints
 call nl
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(SysError)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L559
 ret
L559:
 jmp basic_entry
getToken:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=TokenText
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
getToken1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=32
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz getToken2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L566
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r0)
 (TokenType)=x
 ret
L566:
 x=(TokenP)
 x++
 (TokenP)=x
 jmp getToken1
getToken2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=A_QUOT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L570
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r0)
 (TokenType)=x
 ret
L570:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DBL_QUOT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz getToken4
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r0)
 (TokenType)=x
 x=(TokenP)
 x++
 (TokenP)=x
getToken3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L575
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S63
 (r0)=x
 call assertError
L575:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DBL_QUOT
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L576
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(TokenP)
 x++
 (TokenP)=x
 x=(ii)
 x++
 (ii)=x
 jmp getToken3
L576:
 x=(TokenP)
 x++
 (TokenP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 ret
getToken4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call is_symbol_char0
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz getToken20
getToken5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call is_symbol_char
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L585
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(TokenP)
 x++
 (TokenP)=x
 x=(ii)
 x++
 (ii)=x
 jmp getToken5
L585:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
getToken6:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S68
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L589
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r0)
 (TokenType)=x
 ret
L589:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=Command
 (r0)=x
 x=(r0)
 (pp)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
getToken7:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=_Command.keyword
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (qq)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(qq)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz getToken8
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(qq)
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L595
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=COMMAND
 (r0)=x
 x=(r0)
 (TokenType)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r0)
 (TokenCode)=x
 ret
L595:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_Command.SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (pp)=x
 x=(ii)
 x++
 (ii)=x
 jmp getToken7
getToken8:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=Function
 (r0)=x
 x=(r0)
 (pp)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
getToken8x:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=_Function.keyword
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (qq)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(qq)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz getToken9
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(qq)
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L605
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=FUNCTION
 (r0)=x
 x=(r0)
 (TokenType)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r0)
 (TokenCode)=x
 ret
L605:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_Function.SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (pp)=x
 x=(ii)
 x++
 (ii)=x
 jmp getToken8x
getToken9:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r0)
 (TokenType)=x
 ret
getToken20:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (cc)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=48
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz getToken30
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=57
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz getToken30
getToken21:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r0)
 (TokenType)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r0)
 (TokenValue)=x
getToken22:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenValue)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=48
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (TokenValue)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(TokenP)
 x++
 (TokenP)=x
 x=(ii)
 x++
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=48
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L623
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=57
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz getToken22
L623:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 ret
getToken30:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r0)
 (TokenType)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc)
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(TokenP)
 x++
 (TokenP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (bb)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=61
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz getToken31
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=60
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L633
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(TokenP)
 x++
 (TokenP)=x
 jmp getToken33
L633:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=62
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L634
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(TokenP)
 x++
 (TokenP)=x
 jmp getToken33
L634:
getToken31:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=60
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz getToken32
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=61
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L637
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(TokenP)
 x++
 (TokenP)=x
 jmp getToken33
L637:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=62
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L638
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(TokenP)
 x++
 (TokenP)=x
 jmp getToken33
L638:
getToken32:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=62
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz getToken33
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=61
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L641
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(bb)
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(TokenP)
 x++
 (TokenP)=x
L641:
getToken33:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=TokenText
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 ret
checkToken:
 x=(r0)
 (token)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(token)
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L649
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S74
 (r0)=x
 call assertError
L649:
 call getToken
 ret
is_space:
 x=(r0)
 (cc1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=32
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L655
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
L655:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=9
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L656
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
L656:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
is_symbol_char0:
 x=(r0)
 (cc1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=97
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L660
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=122
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz is_symbol_char0_1
L660:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=65
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L661
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=90
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz is_symbol_char0_1
L661:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=95
 (r0)=x
 x=(r1)
 x-=(r0)
 jz is_symbol_char0_1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=64
 (r0)=x
 x=(r1)
 x-=(r0)
 jz is_symbol_char0_1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
is_symbol_char0_1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
is_symbol_char:
 x=(r0)
 (cc1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=48
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L669
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=57
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz is_symbol_char1
L669:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=97
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L670
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=122
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz is_symbol_char1
L670:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=65
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L671
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=90
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz is_symbol_char1
L671:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=95
 (r0)=x
 x=(r1)
 x-=(r0)
 jz is_symbol_char1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=36
 (r0)=x
 x=(r1)
 x-=(r0)
 jz is_symbol_char1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=64
 (r0)=x
 x=(r1)
 x-=(r0)
 jz is_symbol_char1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
is_symbol_char1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
is_digit:
 x=(r0)
 (cc1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=48
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L680
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L680:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=57
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(cc1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L681
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L681:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 ret
edit_line:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 call strlen
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=SIZEOF_LONG*2+1
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (plen)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz edit_line1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (EndProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
edit_line1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call serch_line
 x=(r0)
 (prog)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz edit_line4
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz edit_line5
edit_line2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (ofset)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ofset)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (EndProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ofset)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz edit_line3
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 x+=(ofset)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
edit_line3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 x+=(ofset)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
edit_line4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (EndProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
edit_line5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(ii)
 x+=(plen)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (EndProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
del_line:
 x=(r0)
 (pline)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call serch_line
 x=(r0)
 (prog)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L770
 ret
L770:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (plen)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (EndProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(prog)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 x+=(plen)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
divide_line:
 x=(r0)
 (txt)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (xx)=x
 x=(r1)
 (r0)=x
 x=(r2)
 (r1)=x
 x=(r3)
 (r2)=x
 x=(r0)
 (pp)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (lx)=x
divide_line1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call is_space
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L784
 x=(pp)
 x++
 (pp)=x
 jmp divide_line1
L784:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call is_digit
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jz divide_line2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(xx)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(txt)
 (r0)=x
 call strcpy
 ret
divide_line2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call is_digit
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz divide_line3
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(lx)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=48
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (lx)=x
 x=(pp)
 x++
 (pp)=x
 jmp divide_line2
divide_line3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call is_space
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L798
 x=(pp)
 x++
 (pp)=x
 jmp divide_line3
L798:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L799
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(lx)
 (r0)=x
 x=(xx)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(txt)
 y=r0
 a=(y)
 (x)=a
 ret
L799:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(txt)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(lx)
 (r0)=x
 x=(xx)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 ret
clear_variable:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=25
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=NumVarArea
 x+=(ii)
 x+=(ii)
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=25*STR_VAR_SIZE
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STR_VAR_SIZE
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=StrVarArea
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY_SIZE
 (r0)=x
 x=(r0)
 (ii+3)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (ii+6)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=$+16
 (r0)=x
 x=(r0)
 (ii+9)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=ArrayArea
 x+=(ii)
 x+=(ii)
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+3)
 (r0)=x
 x=(r1)
 x-=(r0)
 jz $+125
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+6)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii+9)
 (r0)=x
 x=(r0)
 jmp (x)
 ret
get_var_adr:
 x=(r0)
 (xvname)=x
 call strlen
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L817
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 ret
L817:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=2
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L818
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 ret
L818:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xvname)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=64
 (r0)=x
 x=(r1)
 x-=(r0)
 jz get_var_adr2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jz get_var_adr1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 x+=(xvname)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=36
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L821
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S90
 (r0)=x
 call assertError
L821:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xvname)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (index)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r0)
 (var_type)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(index)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=97
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STR_VAR_SIZE
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=StrVarArea
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 ret
get_var_adr1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xvname)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (index)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r0)
 (var_type)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(index)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=97
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=SIZEOF_LONG
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NumVarArea
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 ret
get_var_adr2:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY
 (r0)=x
 x=(r0)
 (var_type)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S94
 (r0)=x
 call checkToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r0)
 push x
 call eval_expression
 pop x
 (r0)=x
 x=(r0)
 (sign)=x
 call get_number
 x=(r0)
 (index)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(index)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L837
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S95
 (r0)=x
 call assertError
L837:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY_SIZE
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(index)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L838
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S96
 (r0)=x
 call assertError
L838:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S97
 (r0)=x
 call checkToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(index)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=SIZEOF_LONG
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ArrayArea
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 ret
cmd_clear:
 call clear_value
 call clear_variable
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ForStackArea
 (r0)=x
 x=(r0)
 (ForStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_if:
 call eval_expression
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz cmd_if1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S103
 (r0)=x
 call checkToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L852
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
L852:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenValue)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call serch_line
 x=(r0)
 (pp)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L854
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S104
 (r0)=x
 call assertError
L854:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_if1:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S106
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_if2
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L864
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
L864:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenValue)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call serch_line
 x=(r0)
 (pp)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L866
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S107
 (r0)=x
 call assertError
L866:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_if2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_if1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_return:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=GosubStackArea
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L875
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S109
 (r0)=x
 call assertError
L875:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_GosubStack.SIZE
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (GosubStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=_GosubStack.token_p
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (TokenP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=_GosubStack.program
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (CurrentProg)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_gosub:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=GosubStackArea
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=GOSUB_STACK_SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L884
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S111
 (r0)=x
 call assertError
L884:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L885
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S112
 (r0)=x
 call assertError
L885:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenValue)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call serch_line
 x=(r0)
 (pp1)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp1)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L887
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S113
 (r0)=x
 call assertError
L887:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=_GosubStack.program
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=_GosubStack.token_p
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(GosubStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_GosubStack.SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (GosubStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp1)
 (r0)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_next:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ForStackArea
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L898
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S115
 (r0)=x
 call assertError
L898:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_ForStack.SIZE
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (ForStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_next1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call get_var_adr
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.var
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L902
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S116
 (r0)=x
 call assertError
L902:
 call getToken
cmd_next1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.var
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (for_var)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.step
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(for_var)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(for_var)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(for_var)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.limit
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.step
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 call mul
 x=(__ans)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz cmd_next2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.token_p
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (TokenP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.program
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_ForStack.SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ForStackP)=x
 call getToken
cmd_next2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_for:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ForStackArea
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=FOR_STACK_SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L917
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S118
 (r0)=x
 call assertError
L917:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L918
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S119
 (r0)=x
 call assertError
L918:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call get_var_adr
 x=(r0)
 (for_var)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(for_var)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.var
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 call cmd_let
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S123
 (r0)=x
 call checkToken
 call clear_value
 call eval_expression
 call get_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.limit
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S125
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_for1
 call getToken
 call clear_value
 call eval_expression
 call get_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.step
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 jmp cmd_for2
cmd_for1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.step
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
cmd_for2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.program
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=_ForStack.token_p
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ForStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_ForStack.SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (ForStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_goto:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (RunFlg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L942
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S129
 (r0)=x
 call assertError
L942:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenValue)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call serch_line
 x=(r0)
 (pp)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L944
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S130
 (r0)=x
 call assertError
L944:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_input:
cmd_input3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (is_question)=x
cmd_input4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L955
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call prints
 call getToken
 jmp cmd_input4
L955:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_input5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call get_var_adr
 x=(r0)
 (input_var)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=var_type
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L958
 call getToken
L958:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(is_question)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L959
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S133
 (r0)=x
 call prints
L959:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call inputs
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=3
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L961
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (BreakFlg)=x
L961:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call strlen
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L963
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(input_var)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=MAX_STR_LENGTH
 (r0)=x
 call strncpy
L963:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L964
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call atoi
 x=(input_var)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
L964:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L965
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call atoi
 x=(input_var)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
L965:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (is_question)=x
 jmp cmd_input4
cmd_input5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L969
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
L969:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=44
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L970
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (is_question)=x
 call getToken
 jmp cmd_input4
L970:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=59
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L971
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (is_question)=x
 call getToken
 jmp cmd_input4
L971:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_print:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r0)
 (last_char)=x
cmd_print4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz cmd_print6
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L978
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=58
 (r0)=x
 x=(r1)
 x-=(r0)
 jz cmd_print6
L978:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (last_char)=x
 call clear_value
 call eval_expression
 call value_type
 x=(r0)
 (typ)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(typ)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L983
 call get_string
 x=(r0)
 (ss)=x
 call prints
L983:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(typ)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L984
 call get_number
 call printd
L984:
 call check_value
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_print5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=44
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_print5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (last_char)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=44
 (r0)=x
 call putchar
 call getToken
 jmp cmd_print4
cmd_print5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_print51
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=59
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_print51
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r0)
 (last_char)=x
 call getToken
 jmp cmd_print4
cmd_print51:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=EOL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz cmd_print6
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DELIMIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1000
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=58
 (r0)=x
 x=(r1)
 x-=(r0)
 jz cmd_print6
L1000:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S136
 (r0)=x
 call assertError
cmd_print6:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(last_char)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=59
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1003
 call nl
L1003:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_stop:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (BreakFlg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_cont:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(BreakProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(BreakToken)
 (r0)=x
 call exec_basic2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_run:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ForStackArea
 (r0)=x
 x=(r0)
 (ForStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=GosubStackArea
 (r0)=x
 x=(r0)
 (GosubStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=(r0)
 (CurrentProg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1015
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 ret
L1015:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CurrentProg)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 x=(r0)
 (TokenP)=x
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_let:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1021
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
L1021:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call get_var_adr
 x=(r0)
 (lvar)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1023
 call getToken
L1023:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S142
 (r0)=x
 call checkToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r0)
 push x
 call eval_expression
 pop x
 (r0)=x
 x=(r0)
 (var_type)=x
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1027
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz cmd_let2
L1027:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1028
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jz cmd_let2
L1028:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1029
 call get_number
 x=(lvar)
 y=r0
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
L1029:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1030
 call get_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(lvar)
 (r0)=x
 call strcpy
L1030:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_let2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S147
 (r0)=x
 call assertError
 ret
cmd_list:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (list_st)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0x4fffff
 (r0)=x
 x=(r0)
 (list_ed)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1038
 call get_number
 x=(r0)
 (list_st)=x
 call getToken
L1038:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=44
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1039
 call getToken
L1039:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=45
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1040
 call getToken
L1040:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1041
 call get_number
 x=(r0)
 (list_ed)=x
 call getToken
L1041:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ProgArea
 (r0)=x
 x=(r0)
 (pp)=x
cmd_list1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(EndProg)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz cmd_list3
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz cmd_list3
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(list_st)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz cmd_list2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(list_ed)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz cmd_list2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 call printd
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S149
 (r0)=x
 call prints
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call prints
 call nl
cmd_list2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pp)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (pp)=x
 jmp cmd_list1
cmd_list3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 ret
cmd_end:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 ret
cmd_new:
 call clear_program
 call cmd_clear
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 ret
cmd_else:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S152
 (r0)=x
 call assertError
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
cmd_then:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S153
 (r0)=x
 call assertError
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DONE
 (r0)=x
 ret
func_len:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S155
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S156
 (r0)=x
 call checkToken
 call get_string
 x=(r0)
 (ss)=x
 call strlen
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_val:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S158
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S159
 (r0)=x
 call checkToken
 call get_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call atoi
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_strs:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S161
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S162
 (r0)=x
 call checkToken
 call get_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=10
 (r0)=x
 call itoa
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_lefts:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S164
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S165
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S166
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (kk)=x
 call get_string
 x=(r0)
 (ss0)=x
 call strlen
 x=(r0)
 (ll)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
func_lefts1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(kk)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz func_lefts2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ll)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz func_lefts2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss0)
 x+=(ii)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=sss
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 jmp func_lefts1
func_lefts2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=sss
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_mids:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S168
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S169
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=44
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1116
 call getToken
 call eval_expression
 jmp func_midsx
L1116:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=MAX_STR_LENGTH
 (r0)=x
 call put_number
func_midsx:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S170
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (jj)=x
 call get_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 call get_string
 x=(r0)
 (ss0)=x
 call strlen
 x=(r0)
 (ll)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(jj)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (jj)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (kk)=x
func_mids1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(jj)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz func_mids2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ll)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz func_mids2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss0)
 x+=(ii)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=sss
 x+=(kk)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(kk)
 x++
 (kk)=x
 jmp func_mids1
func_mids2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=sss
 x+=(kk)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_asc:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S173
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S174
 (r0)=x
 call checkToken
 call get_string
 x=(r0)
 (ss)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_rights:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S176
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S177
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S178
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (ii)=x
 call get_string
 x=(r0)
 (ss0)=x
 call strlen
 x=(r0)
 (ll)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ll)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (ii)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1154
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
L1154:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (kk)=x
func_rights1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ll)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz func_rights2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss0)
 x+=(ii)
 y=r0
 a=(x)
 (y)=a
 a=0
 y++
 (y)=a
 y++
 (y)=a
 x=sss
 x+=(kk)
 y=r0
 a=(y)
 (x)=a
 x=(ii)
 x++
 (ii)=x
 x=(kk)
 x++
 (kk)=x
 jmp func_rights1
func_rights2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=sss
 x+=(kk)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_chrs:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S180
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S181
 (r0)=x
 call checkToken
 call get_number
 x=ccc+0
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=ccc+1
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ccc
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_abs:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S183
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S184
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (vabs)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vabs)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1183
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vabs)
 (r0)=x
 x=0
 x-=(r0)
 (r0)=x
 x=(r0)
 (vabs)=x
L1183:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vabs)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_inputs:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S189
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S190
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (nn)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (ii)=x
func_inputs2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ii)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(nn)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz func_inputs3
 call getchar
 x=sss
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=32
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L1196
 x=(ii)
 x++
 (ii)=x
L1196:
 jmp func_inputs2
func_inputs3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=sss
 x+=(ii)
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_inkeys:
 call getToken
 call inkey
 x=inkey_str
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=inkey_str+1
 y=r0
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=inkey_str
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_instr:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S193
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S194
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=44
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1216
 call getToken
 call eval_expression
 jmp func_instr1
L1216:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
func_instr1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S195
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (xx)=x
 x=(xx)
 x--
 (xx)=x
 call get_string
 x=(r0)
 (ss1)=x
 call get_string
 x=(r0)
 (ss0)=x
 call strlen
 x=(r0)
 (ll)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xx)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1223
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 jmp func_instr2
L1223:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xx)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ll)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L1224
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 jmp func_instr2
L1224:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xx)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss1)
 (r0)=x
 call strstr
 x=(r0)
 (xx)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xx)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1226
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 jmp func_instr2
L1226:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(xx)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss0)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 call put_number
func_instr2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_sgn:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S197
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S198
 (r0)=x
 call checkToken
 call get_number
 x=(r0)
 (vsgn0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (vsgn)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vsgn0)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1238
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=~1
 (r0)=x
 x=(r0)
 (vsgn)=x
L1238:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vsgn0)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1239
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (vsgn)=x
L1239:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vsgn)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_hexs:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S203
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S204
 (r0)=x
 call checkToken
 call get_number
 call hex
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_bins:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S206
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S207
 (r0)=x
 call checkToken
 call get_number
 call bin
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
func_octs:
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S209
 (r0)=x
 call checkToken
 call eval_expression
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S210
 (r0)=x
 call checkToken
 call get_number
 call oct
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_eq:
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1265
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1265:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_neq:
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1269
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1269:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_lt:
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1273
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1273:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_le:
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L1277
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1277:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_gt:
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1281
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1281:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_ge:
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L1286
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1286:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_cmp:
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_cmp1
 call get_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=s1
 (r0)=x
 call strcpy
 call get_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=s2
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=s1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=s2
 (r0)=x
 call strcmp
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_cmp1:
 call get_number
 x=(r0)
 (d1)=x
 call get_number
 x=(r0)
 (d2)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(d2)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(d1)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_and:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=r1
 a=(x)
 x=r0
 a&=(x)
 (x)=a
 x=r1+1
 a=(x)
 x=r0+1
 a&=(x)
 (x)=a
 x=r1+2
 a=(x)
 x=r0+2
 a&=(x)
 (x)=a
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_or:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=r1
 a=(x)
 x=r0
 a|=(x)
 (x)=a
 x=r1+1
 a=(x)
 x=r0+1
 a|=(x)
 (x)=a
 x=r1+2
 a=(x)
 x=r0+2
 a|=(x)
 (x)=a
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_mod:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1313
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S221
 (r0)=x
 call assertError
L1313:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 call udiv
 x=(r1)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_div:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1319
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S223
 (r0)=x
 call assertError
L1319:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 call div
 x=(__ans)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_mul:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_sub:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_add:
 call get_number
 x=(r0)
 (ss)=x
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_concat:
 call get_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 call strcpy
 call get_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss0
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss0
 (r0)=x
 call strcat
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=sss0
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (sign)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=43
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1350
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (sign)=x
L1350:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=45
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1351
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r0)
 (sign)=x
L1351:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=40
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom2
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r0)
 push x
 call eval_expression
 pop x
 (r0)=x
 x=(r0)
 (sign)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S230
 (r0)=x
 call checkToken
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1360
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S231
 (r0)=x
 call assertError
L1360:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1363
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 call put_number
L1363:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom3
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenValue)
 (r0)=x
 call put_number
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1369
 call get_number
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 call put_number
L1369:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom4
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call put_string
 call getToken
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1375
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S236
 (r0)=x
 call assertError
L1375:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=FUNCTION
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r0)
 push x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenCode)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=_Function.SIZE
 (r0)=x
 call mul
 x=(__ans)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=Function
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=_Function.func
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=$+10
 push x
 x=(r0)
 jmp (x)
 pop x
 (r0)=x
 x=(r0)
 (sign)=x
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom4_1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1384
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S238
 (r0)=x
 call assertError
L1384:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom4_1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1387
 call get_number
 x=0
 x-=(r0)
 (r0)=x
 call put_number
L1387:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(TokenType)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VARIABLE
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom6
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r0)
 push x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 call get_var_adr
 x=(r0)
 (val)=x
 pop x
 (r0)=x
 x=(r0)
 (sign)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ARRAY
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1394
 call getToken
L1394:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(var_type)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_atom5_1
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(val)
 (r0)=x
 call put_string
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1397
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S242
 (r0)=x
 call assertError
L1397:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom5_1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(val)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 call put_number
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(sign)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1401
 call get_number
 x=0
 x-=(r0)
 (r0)=x
 call put_number
L1401:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_atom6:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S245
 (r0)=x
 call assertError
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_term:
 call eval_atom
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1409
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1409:
eval_term1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=42
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1411
 call getToken
 call eval_atom
 call eval_mul
 jmp eval_term1
L1411:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=47
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1412
 call getToken
 call eval_atom
 call eval_div
 jmp eval_term1
L1412:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S248
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1414
 call getToken
 call eval_atom
 call eval_mod
 jmp eval_term1
L1414:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_aexpression:
 call eval_term
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_aexpression2
eval_aexpression1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=43
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1421
 call getToken
 call eval_term
 call eval_concat
 jmp eval_aexpression1
L1421:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_aexpression2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=43
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1424
 call getToken
 call eval_term
 call eval_add
 jmp eval_aexpression2
L1424:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=45
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1425
 call getToken
 call eval_term
 call eval_sub
 jmp eval_aexpression2
L1425:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_relation:
 call eval_aexpression
eval_relation1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S256
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_relation2
 call getToken
 call eval_aexpression
 call eval_cmp
 call eval_ge
 jmp eval_relation1
eval_relation2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S257
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_relation3
 call getToken
 call eval_aexpression
 call eval_cmp
 call eval_gt
 jmp eval_relation1
eval_relation3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S258
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_relation4
 call getToken
 call eval_aexpression
 call eval_cmp
 call eval_le
 jmp eval_relation1
eval_relation4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S259
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_relation5
 call getToken
 call eval_aexpression
 call eval_cmp
 call eval_lt
 jmp eval_relation1
eval_relation5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S260
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_relation6
 call getToken
 call eval_aexpression
 call eval_cmp
 call eval_neq
 jmp eval_relation1
eval_relation6:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S261
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz eval_relation7
 call getToken
 call eval_aexpression
 call eval_cmp
 call eval_eq
 jmp eval_relation1
eval_relation7:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
eval_lterm:
 call eval_relation
eval_lterm1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S264
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1483
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1483:
 call getToken
 call eval_relation
 call eval_and
 jmp eval_lterm1
eval_expression:
 call eval_lterm
eval_expression1:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TokenText
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S266
 (r0)=x
 call strcmp
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1494
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1494:
 call getToken
 call eval_lterm
 call eval_or
 jmp eval_expression1
get_string:
 call value_type
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1501
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S268
 (r0)=x
 call assertError
L1501:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VALUE_SIZE
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (CalcStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=Value.data
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 ret
get_number:
 call value_type
 x=(r0)
 (vgetn)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vgetn)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1508
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S271
 (r0)=x
 call assertError
L1508:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VALUE_SIZE
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (CalcStackP)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=Value.data
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x=(r0)
 (vgetn)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(vgetn)
 (r0)=x
 ret
put_string:
 x=(r0)
 (str)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=STRING
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=Value.type
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=Value.data
 x+=(r0)
 (r0)=x
 x=(r0)
 (ss)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(str)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(ss)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=MAX_STR_LENGTH-1
 (r0)=x
 call strncpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VALUE_SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (CalcStackP)=x
 ret
put_number:
 x=(r0)
 (num)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NUMBER
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=Value.type
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(num)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=Value.data
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VALUE_SIZE
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (CalcStackP)=x
 ret
value_type:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=CalcStackArea
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz L1528
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 ret
L1528:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=VALUE_SIZE
 (r0)=x
 x=(r1)
 x-=(r0)
 (r0)=x
 x=(r0)
 (valx)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(valx)
 (r0)=x
 x=Value.type
 x+=(r0)
 y=r0
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 x++
 y++
 a=(x)
 (y)=a
 ret
check_value:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(CalcStackP)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=CalcStackArea
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1532
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S276
 (r0)=x
 call assertError
L1532:
 ret
clear_value:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=CalcStackArea
 (r0)=x
 x=(r0)
 (CalcStackP)=x
 ret
_INIT_STATES:
 ret
main:
 call _INIT_STATES
 jmp _PSTART
_PSTART:
 call _891161780_in
 ret
_891161780_in:
start_basic:
 x=sp
 (StackSave)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=1
 (r0)=x
 x=(r0)
 (RunFlg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (BreakProg)=x
 call cls
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S278
 (r0)=x
 call prints
 call nl
 call clear_program
 call clear_value
basic_entry:
 call nl
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S279
 (r0)=x
 call prints
 call nl
start_basic1:
 call clear_value
start_basic2:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S280
 (r0)=x
 call prints
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=text
 (r0)=x
 call inputs
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=LF
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1564
 call nl
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S281
 (r0)=x
 call prints
 jmp start_basic2
L1564:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=text
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz start_basic2
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=text
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=pline
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 call divide_line
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1567
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz start_basic2
L1567:
start_basic3:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jnz L1569
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jz start_basic4
L1569:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r1)
 x-=(r0)
 (__tmp)=x
 x=__tmp+2
 a=0x80
 a&=(x)
 jz L1570
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz start_basic5
L1570:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 call edit_line
 jmp start_basic2
start_basic4:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r1)
 x-=(r0)
 jz start_basic5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 y=r0
 a=(x)
 (y)=a
 y++
 a=0
 (y)=a
 y++
 (y)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=NULL
 (r0)=x
 x=(r1)
 x-=(r0)
 jnz start_basic5
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(pline)
 (r0)=x
 call del_line
 jmp start_basic2
start_basic5:
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=0
 (r0)=x
 x=(r0)
 (BreakFlg)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DirectArea
 (r0)=x
 x=Program.lineno
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DirectArea
 (r0)=x
 x=Program.text
 x+=(r0)
 (r0)=x
 call strcpy
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=ptext
 (r0)=x
 call strlen
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=SIZEOF_LONG*2+1
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (plen)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DirectArea
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DirectArea
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(plen)
 (r0)=x
 x=(r1)
 x+=(r0)
 (r0)=x
 x=(r0)
 (tt)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=-1
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(tt)
 (r0)=x
 x=Program.length
 x+=(r0)
 y=r1
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x++
 y++
 a=(y)
 (x)=a
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=DirectArea
 (r0)=x
 call exec_basic
 x=(r0)
 (status)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(status)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=QUIT
 (r0)=x
 x=(r1)
 x-=(r0)
 jz start_basic6
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=(status)
 (r0)=x
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=TERMINATE
 (r0)=x
 x=(r1)
 x-=(r0)
 jz L1588
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S287
 (r0)=x
 call assertError
L1588:
 jmp basic_entry
start_basic6:
 call cmd_new
 x=(r2)
 (r3)=x
 x=(r1)
 (r2)=x
 x=(r0)
 (r1)=x
 x=S288
 (r0)=x
 call prints
 call nl
 ret
 ret
S1:
  byte 115
  byte 116
  byte 100
  byte 105
  byte 111
  byte 46
  byte 114
  byte 104
  byte 0
S2:
  byte 48
  byte 49
  byte 50
  byte 51
  byte 52
  byte 53
  byte 54
  byte 55
  byte 56
  byte 57
  byte 97
  byte 98
  byte 99
  byte 100
  byte 101
  byte 102
  byte 0
S3:
  byte 48
  byte 0
S4:
  byte 48
  byte 49
  byte 50
  byte 51
  byte 52
  byte 53
  byte 54
  byte 55
  byte 56
  byte 57
  byte 97
  byte 98
  byte 99
  byte 100
  byte 101
  byte 102
  byte 0
S5:
  byte 114
  byte 117
  byte 110
  byte 0
S6:
  byte 105
  byte 102
  byte 0
S7:
  byte 102
  byte 111
  byte 114
  byte 0
S8:
  byte 110
  byte 101
  byte 120
  byte 116
  byte 0
S9:
  byte 103
  byte 111
  byte 116
  byte 111
  byte 0
S10:
  byte 103
  byte 111
  byte 115
  byte 117
  byte 98
  byte 0
S11:
  byte 114
  byte 101
  byte 116
  byte 117
  byte 114
  byte 110
  byte 0
S12:
  byte 112
  byte 114
  byte 105
  byte 110
  byte 116
  byte 0
S13:
  byte 105
  byte 110
  byte 112
  byte 117
  byte 116
  byte 0
S14:
  byte 99
  byte 108
  byte 101
  byte 97
  byte 114
  byte 0
S15:
  byte 110
  byte 101
  byte 119
  byte 0
S16:
  byte 101
  byte 110
  byte 100
  byte 0
S17:
  byte 108
  byte 105
  byte 115
  byte 116
  byte 0
S18:
  byte 114
  byte 117
  byte 110
  byte 0
S19:
  byte 115
  byte 116
  byte 111
  byte 112
  byte 0
S20:
  byte 99
  byte 111
  byte 110
  byte 116
  byte 0
S21:
  byte 116
  byte 104
  byte 101
  byte 110
  byte 0
S22:
  byte 101
  byte 108
  byte 115
  byte 101
  byte 0
S23:
  byte 97
  byte 98
  byte 115
  byte 0
S24:
  byte 115
  byte 103
  byte 110
  byte 0
S25:
  byte 99
  byte 104
  byte 114
  byte 36
  byte 0
S26:
  byte 97
  byte 115
  byte 99
  byte 0
S27:
  byte 109
  byte 105
  byte 100
  byte 36
  byte 0
S28:
  byte 108
  byte 101
  byte 102
  byte 116
  byte 36
  byte 0
S29:
  byte 114
  byte 105
  byte 103
  byte 104
  byte 116
  byte 36
  byte 0
S30:
  byte 105
  byte 110
  byte 112
  byte 117
  byte 116
  byte 36
  byte 0
S31:
  byte 105
  byte 110
  byte 107
  byte 101
  byte 121
  byte 36
  byte 0
S32:
  byte 115
  byte 116
  byte 114
  byte 36
  byte 0
S33:
  byte 104
  byte 101
  byte 120
  byte 36
  byte 0
S34:
  byte 98
  byte 105
  byte 110
  byte 36
  byte 0
S35:
  byte 111
  byte 99
  byte 116
  byte 36
  byte 0
S36:
  byte 118
  byte 97
  byte 108
  byte 0
S37:
  byte 108
  byte 101
  byte 110
  byte 0
S38:
  byte 105
  byte 110
  byte 115
  byte 116
  byte 114
  byte 0
S39:
  byte 115
  byte 101
  byte 114
  byte 99
  byte 104
  byte 32
  byte 108
  byte 105
  byte 110
  byte 101
  byte 58
  byte 0
S40:
  byte 108
  byte 105
  byte 110
  byte 101
  byte 110
  byte 111
  byte 61
  byte 0
S41:
  byte 115
  byte 107
  byte 105
  byte 112
  byte 58
  byte 0
S42:
  byte 98
  byte 121
  byte 116
  byte 101
  byte 115
  byte 0
S43:
  byte 115
  byte 101
  byte 114
  byte 99
  byte 104
  byte 32
  byte 108
  byte 105
  byte 110
  byte 101
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S44:
  byte 115
  byte 101
  byte 114
  byte 99
  byte 104
  byte 32
  byte 108
  byte 105
  byte 110
  byte 101
  byte 32
  byte 78
  byte 85
  byte 76
  byte 76
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S45:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 0
S46:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 50
  byte 58
  byte 0
S47:
  byte 99
  byte 97
  byte 110
  byte 39
  byte 116
  byte 32
  byte 99
  byte 111
  byte 110
  byte 116
  byte 105
  byte 110
  byte 117
  byte 101
  byte 0
S48:
  byte 66
  byte 114
  byte 101
  byte 97
  byte 107
  byte 0
S49:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 50
  byte 32
  byte 99
  byte 111
  byte 109
  byte 109
  byte 97
  byte 110
  byte 100
  byte 58
  byte 0
S50:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 32
  byte 99
  byte 111
  byte 109
  byte 109
  byte 97
  byte 110
  byte 100
  byte 0
S51:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 50
  byte 32
  byte 101
  byte 111
  byte 108
  byte 58
  byte 0
S52:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 50
  byte 32
  byte 100
  byte 101
  byte 108
  byte 105
  byte 109
  byte 105
  byte 116
  byte 58
  byte 0
S53:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S54:
  byte 101
  byte 120
  byte 101
  byte 99
  byte 32
  byte 98
  byte 97
  byte 115
  byte 105
  byte 99
  byte 50
  byte 32
  byte 111
  byte 116
  byte 104
  byte 101
  byte 114
  byte 58
  byte 0
S55:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S56:
  byte 97
  byte 115
  byte 115
  byte 101
  byte 114
  byte 116
  byte 32
  byte 101
  byte 114
  byte 114
  byte 111
  byte 114
  byte 58
  byte 0
S57:
  byte 99
  byte 117
  byte 114
  byte 114
  byte 101
  byte 110
  byte 116
  byte 32
  byte 112
  byte 114
  byte 111
  byte 103
  byte 61
  byte 0
S58:
  byte 76
  byte 105
  byte 110
  byte 101
  byte 32
  byte 0
S59:
  byte 32
  byte 58
  byte 32
  byte 0
S60:
  byte 103
  byte 101
  byte 116
  byte 84
  byte 111
  byte 107
  byte 101
  byte 110
  byte 58
  byte 0
S61:
  byte 39
  byte 0
S62:
  byte 227
  byte 129
  byte 167
  byte 227
  byte 129
  byte 130
  byte 227
  byte 130
  byte 140
  byte 227
  byte 129
  byte 176
  byte 230
  byte 172
  byte 161
  byte 227
  byte 129
  byte 174
  byte 0
S63:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S64:
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 58
  byte 0
S65:
  byte 115
  byte 121
  byte 109
  byte 98
  byte 111
  byte 108
  byte 32
  byte 99
  byte 104
  byte 97
  byte 114
  byte 58
  byte 0
S66:
  byte 84
  byte 111
  byte 107
  byte 101
  byte 110
  byte 84
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S67:
  byte 101
  byte 108
  byte 115
  byte 101
  byte 0
S68:
  byte 101
  byte 108
  byte 115
  byte 101
  byte 0
S69:
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 58
  byte 0
S70:
  byte 100
  byte 101
  byte 108
  byte 105
  byte 109
  byte 105
  byte 116
  byte 116
  byte 101
  byte 114
  byte 58
  byte 0
S71:
  byte 84
  byte 111
  byte 107
  byte 101
  byte 110
  byte 84
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S72:
  byte 99
  byte 104
  byte 101
  byte 99
  byte 107
  byte 32
  byte 116
  byte 111
  byte 107
  byte 101
  byte 110
  byte 58
  byte 0
S73:
  byte 84
  byte 111
  byte 107
  byte 101
  byte 110
  byte 84
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S74:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S75:
  byte 101
  byte 100
  byte 105
  byte 116
  byte 32
  byte 108
  byte 105
  byte 110
  byte 101
  byte 58
  byte 0
S76:
  byte 108
  byte 101
  byte 110
  byte 103
  byte 116
  byte 104
  byte 61
  byte 0
S77:
  byte 110
  byte 111
  byte 32
  byte 112
  byte 114
  byte 111
  byte 103
  byte 114
  byte 97
  byte 109
  byte 0
S78:
  byte 97
  byte 100
  byte 100
  byte 114
  byte 61
  byte 48
  byte 120
  byte 0
S79:
  byte 109
  byte 111
  byte 100
  byte 101
  byte 61
  byte 0
S80:
  byte 114
  byte 101
  byte 100
  byte 117
  byte 99
  byte 101
  byte 32
  byte 112
  byte 114
  byte 111
  byte 103
  byte 114
  byte 97
  byte 109
  byte 0
S81:
  byte 101
  byte 120
  byte 112
  byte 97
  byte 110
  byte 100
  byte 32
  byte 112
  byte 114
  byte 111
  byte 103
  byte 114
  byte 97
  byte 109
  byte 0
S82:
  byte 97
  byte 112
  byte 112
  byte 101
  byte 110
  byte 100
  byte 32
  byte 112
  byte 114
  byte 111
  byte 103
  byte 114
  byte 97
  byte 109
  byte 0
S83:
  byte 108
  byte 101
  byte 110
  byte 103
  byte 116
  byte 104
  byte 61
  byte 0
S84:
  byte 105
  byte 110
  byte 115
  byte 101
  byte 114
  byte 116
  byte 32
  byte 112
  byte 114
  byte 111
  byte 103
  byte 114
  byte 97
  byte 109
  byte 0
S85:
  byte 108
  byte 101
  byte 110
  byte 103
  byte 116
  byte 104
  byte 61
  byte 0
S86:
  byte 100
  byte 105
  byte 118
  byte 105
  byte 100
  byte 101
  byte 32
  byte 108
  byte 105
  byte 110
  byte 101
  byte 58
  byte 0
S87:
  byte 99
  byte 108
  byte 97
  byte 101
  byte 114
  byte 32
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 58
  byte 0
S88:
  byte 103
  byte 101
  byte 116
  byte 32
  byte 118
  byte 97
  byte 114
  byte 32
  byte 97
  byte 100
  byte 114
  byte 58
  byte 0
S89:
  byte 44
  byte 32
  byte 108
  byte 101
  byte 110
  byte 103
  byte 116
  byte 104
  byte 61
  byte 0
S90:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S91:
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 32
  byte 118
  byte 97
  byte 114
  byte 58
  byte 0
S92:
  byte 110
  byte 117
  byte 109
  byte 32
  byte 118
  byte 97
  byte 114
  byte 58
  byte 0
S93:
  byte 97
  byte 114
  byte 114
  byte 97
  byte 121
  byte 32
  byte 118
  byte 97
  byte 114
  byte 0
S94:
  byte 40
  byte 0
S95:
  byte 97
  byte 114
  byte 114
  byte 97
  byte 121
  byte 32
  byte 114
  byte 97
  byte 110
  byte 103
  byte 101
  byte 32
  byte 105
  byte 115
  byte 32
  byte 111
  byte 118
  byte 101
  byte 114
  byte 0
S96:
  byte 97
  byte 114
  byte 114
  byte 97
  byte 121
  byte 32
  byte 114
  byte 97
  byte 110
  byte 103
  byte 101
  byte 32
  byte 105
  byte 115
  byte 32
  byte 111
  byte 118
  byte 101
  byte 114
  byte 0
S97:
  byte 41
  byte 0
S98:
  byte 103
  byte 101
  byte 116
  byte 32
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 32
  byte 118
  byte 97
  byte 108
  byte 117
  byte 101
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S99:
  byte 97
  byte 114
  byte 114
  byte 97
  byte 121
  byte 32
  byte 118
  byte 97
  byte 114
  byte 58
  byte 32
  byte 97
  byte 100
  byte 100
  byte 114
  byte 61
  byte 48
  byte 120
  byte 0
S100:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 99
  byte 108
  byte 101
  byte 97
  byte 114
  byte 58
  byte 0
S101:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 105
  byte 102
  byte 58
  byte 0
S102:
  byte 116
  byte 104
  byte 101
  byte 110
  byte 227
  byte 130
  byte 146
  byte 227
  byte 131
  byte 129
  byte 227
  byte 130
  byte 167
  byte 227
  byte 131
  byte 131
  byte 227
  byte 130
  byte 175
  byte 227
  byte 129
  byte 151
  byte 227
  byte 129
  byte 166
  byte 227
  byte 129
  byte 157
  byte 227
  byte 129
  byte 174
  byte 230
  byte 172
  byte 161
  byte 227
  byte 129
  byte 139
  byte 227
  byte 130
  byte 137
  byte 229
  byte 167
  byte 139
  byte 227
  byte 130
  byte 129
  byte 227
  byte 130
  byte 139
  byte 0
S103:
  byte 116
  byte 104
  byte 101
  byte 110
  byte 0
S104:
  byte 76
  byte 105
  byte 110
  byte 101
  byte 32
  byte 78
  byte 111
  byte 46
  byte 32
  byte 110
  byte 111
  byte 116
  byte 32
  byte 102
  byte 111
  byte 117
  byte 110
  byte 100
  byte 0
S105:
  byte 101
  byte 108
  byte 115
  byte 101
  byte 0
S106:
  byte 101
  byte 108
  byte 115
  byte 101
  byte 0
S107:
  byte 76
  byte 105
  byte 110
  byte 101
  byte 32
  byte 78
  byte 111
  byte 46
  byte 32
  byte 110
  byte 111
  byte 116
  byte 32
  byte 102
  byte 111
  byte 117
  byte 110
  byte 100
  byte 0
S108:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 114
  byte 101
  byte 116
  byte 117
  byte 114
  byte 110
  byte 58
  byte 0
S109:
  byte 114
  byte 101
  byte 116
  byte 117
  byte 114
  byte 110
  byte 32
  byte 119
  byte 105
  byte 116
  byte 104
  byte 111
  byte 117
  byte 116
  byte 32
  byte 103
  byte 111
  byte 115
  byte 117
  byte 98
  byte 0
S110:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 103
  byte 111
  byte 115
  byte 117
  byte 98
  byte 58
  byte 0
S111:
  byte 115
  byte 116
  byte 97
  byte 99
  byte 107
  byte 32
  byte 111
  byte 118
  byte 101
  byte 114
  byte 102
  byte 108
  byte 111
  byte 119
  byte 32
  byte 40
  byte 103
  byte 111
  byte 115
  byte 117
  byte 98
  byte 41
  byte 0
S112:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S113:
  byte 76
  byte 105
  byte 110
  byte 101
  byte 32
  byte 78
  byte 111
  byte 46
  byte 110
  byte 111
  byte 116
  byte 32
  byte 102
  byte 111
  byte 117
  byte 110
  byte 100
  byte 0
S114:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 110
  byte 101
  byte 120
  byte 116
  byte 58
  byte 0
S115:
  byte 110
  byte 101
  byte 120
  byte 116
  byte 32
  byte 119
  byte 105
  byte 116
  byte 104
  byte 111
  byte 117
  byte 116
  byte 32
  byte 102
  byte 111
  byte 114
  byte 0
S116:
  byte 110
  byte 101
  byte 120
  byte 116
  byte 32
  byte 119
  byte 105
  byte 116
  byte 104
  byte 111
  byte 117
  byte 116
  byte 32
  byte 102
  byte 111
  byte 114
  byte 0
S117:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 102
  byte 111
  byte 114
  byte 58
  byte 0
S118:
  byte 115
  byte 116
  byte 97
  byte 99
  byte 107
  byte 32
  byte 111
  byte 118
  byte 101
  byte 114
  byte 32
  byte 102
  byte 108
  byte 111
  byte 119
  byte 32
  byte 40
  byte 102
  byte 111
  byte 114
  byte 45
  byte 110
  byte 101
  byte 120
  byte 116
  byte 41
  byte 0
S119:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S120:
  byte 103
  byte 101
  byte 116
  byte 32
  byte 108
  byte 111
  byte 111
  byte 112
  byte 32
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 0
S121:
  byte 108
  byte 101
  byte 116
  byte 32
  byte 108
  byte 111
  byte 111
  byte 112
  byte 32
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 44
  byte 32
  byte 116
  byte 111
  byte 107
  byte 101
  byte 110
  byte 32
  byte 116
  byte 121
  byte 112
  byte 101
  byte 61
  byte 0
S122:
  byte 116
  byte 111
  byte 32
  byte 99
  byte 104
  byte 101
  byte 99
  byte 107
  byte 32
  byte 116
  byte 111
  byte 112
  byte 107
  byte 101
  byte 110
  byte 58
  byte 0
S123:
  byte 116
  byte 111
  byte 0
S124:
  byte 108
  byte 105
  byte 109
  byte 105
  byte 116
  byte 32
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 0
S125:
  byte 115
  byte 116
  byte 101
  byte 112
  byte 0
S126:
  byte 115
  byte 116
  byte 101
  byte 112
  byte 32
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 0
S127:
  byte 115
  byte 97
  byte 118
  byte 101
  byte 32
  byte 99
  byte 117
  byte 114
  byte 114
  byte 101
  byte 110
  byte 116
  byte 32
  byte 112
  byte 111
  byte 115
  byte 105
  byte 116
  byte 105
  byte 111
  byte 110
  byte 32
  byte 116
  byte 111
  byte 32
  byte 115
  byte 116
  byte 97
  byte 99
  byte 107
  byte 0
S128:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 103
  byte 111
  byte 116
  byte 111
  byte 58
  byte 0
S129:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S130:
  byte 76
  byte 105
  byte 110
  byte 101
  byte 32
  byte 78
  byte 79
  byte 46
  byte 32
  byte 110
  byte 111
  byte 116
  byte 32
  byte 102
  byte 111
  byte 117
  byte 110
  byte 100
  byte 0
S131:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 105
  byte 110
  byte 112
  byte 117
  byte 116
  byte 58
  byte 0
S132:
  byte 118
  byte 97
  byte 114
  byte 32
  byte 97
  byte 100
  byte 114
  byte 61
  byte 48
  byte 120
  byte 0
S133:
  byte 63
  byte 32
  byte 0
S134:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 112
  byte 114
  byte 105
  byte 110
  byte 116
  byte 58
  byte 0
S135:
  byte 112
  byte 114
  byte 105
  byte 110
  byte 116
  byte 58
  byte 0
S136:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S137:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 115
  byte 116
  byte 111
  byte 112
  byte 58
  byte 0
S138:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 99
  byte 111
  byte 110
  byte 116
  byte 58
  byte 0
S139:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 114
  byte 117
  byte 110
  byte 58
  byte 0
S140:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 108
  byte 101
  byte 116
  byte 58
  byte 0
S141:
  byte 118
  byte 97
  byte 114
  byte 32
  byte 110
  byte 97
  byte 109
  byte 101
  byte 61
  byte 0
S142:
  byte 61
  byte 0
S143:
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 32
  byte 116
  byte 121
  byte 112
  byte 101
  byte 61
  byte 0
S144:
  byte 118
  byte 97
  byte 108
  byte 117
  byte 101
  byte 32
  byte 116
  byte 121
  byte 112
  byte 101
  byte 61
  byte 0
S145:
  byte 118
  byte 97
  byte 114
  byte 32
  byte 97
  byte 100
  byte 114
  byte 61
  byte 48
  byte 120
  byte 0
S146:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 108
  byte 101
  byte 116
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S147:
  byte 84
  byte 121
  byte 112
  byte 101
  byte 32
  byte 77
  byte 105
  byte 115
  byte 109
  byte 97
  byte 116
  byte 99
  byte 104
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S148:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 108
  byte 105
  byte 115
  byte 116
  byte 58
  byte 0
S149:
  byte 32
  byte 0
S150:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S151:
  byte 99
  byte 109
  byte 100
  byte 32
  byte 110
  byte 101
  byte 119
  byte 58
  byte 0
S152:
  byte 101
  byte 108
  byte 115
  byte 101
  byte 32
  byte 119
  byte 105
  byte 116
  byte 104
  byte 111
  byte 117
  byte 116
  byte 32
  byte 105
  byte 102
  byte 0
S153:
  byte 116
  byte 104
  byte 101
  byte 110
  byte 32
  byte 119
  byte 105
  byte 116
  byte 104
  byte 111
  byte 117
  byte 116
  byte 32
  byte 105
  byte 102
  byte 0
S154:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 108
  byte 101
  byte 110
  byte 58
  byte 0
S155:
  byte 40
  byte 0
S156:
  byte 41
  byte 0
S157:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 118
  byte 97
  byte 108
  byte 58
  byte 0
S158:
  byte 40
  byte 0
S159:
  byte 41
  byte 0
S160:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 115
  byte 116
  byte 114
  byte 115
  byte 58
  byte 0
S161:
  byte 40
  byte 0
S162:
  byte 41
  byte 0
S163:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 108
  byte 101
  byte 102
  byte 116
  byte 115
  byte 58
  byte 0
S164:
  byte 40
  byte 0
S165:
  byte 44
  byte 0
S166:
  byte 41
  byte 0
S167:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 109
  byte 105
  byte 100
  byte 115
  byte 58
  byte 0
S168:
  byte 40
  byte 0
S169:
  byte 44
  byte 0
S170:
  byte 41
  byte 0
S171:
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 61
  byte 0
S172:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 97
  byte 115
  byte 99
  byte 58
  byte 0
S173:
  byte 40
  byte 0
S174:
  byte 41
  byte 0
S175:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 114
  byte 105
  byte 103
  byte 104
  byte 116
  byte 115
  byte 58
  byte 0
S176:
  byte 40
  byte 0
S177:
  byte 44
  byte 0
S178:
  byte 41
  byte 0
S179:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 99
  byte 104
  byte 114
  byte 115
  byte 58
  byte 0
S180:
  byte 40
  byte 0
S181:
  byte 41
  byte 0
S182:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 97
  byte 98
  byte 115
  byte 58
  byte 0
S183:
  byte 40
  byte 0
S184:
  byte 41
  byte 0
S185:
  byte 105
  byte 110
  byte 61
  byte 0
S186:
  byte 111
  byte 117
  byte 116
  byte 61
  byte 0
S187:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 97
  byte 98
  byte 115
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S188:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 105
  byte 110
  byte 112
  byte 117
  byte 116
  byte 115
  byte 58
  byte 0
S189:
  byte 40
  byte 0
S190:
  byte 41
  byte 0
S191:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 105
  byte 110
  byte 107
  byte 101
  byte 121
  byte 58
  byte 0
S192:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 105
  byte 110
  byte 115
  byte 116
  byte 114
  byte 58
  byte 0
S193:
  byte 40
  byte 0
S194:
  byte 44
  byte 0
S195:
  byte 41
  byte 0
S196:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 115
  byte 103
  byte 110
  byte 58
  byte 0
S197:
  byte 40
  byte 0
S198:
  byte 41
  byte 0
S199:
  byte 105
  byte 110
  byte 61
  byte 0
S200:
  byte 111
  byte 117
  byte 116
  byte 61
  byte 0
S201:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 115
  byte 103
  byte 110
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S202:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 104
  byte 101
  byte 120
  byte 115
  byte 58
  byte 0
S203:
  byte 40
  byte 0
S204:
  byte 41
  byte 0
S205:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 98
  byte 105
  byte 110
  byte 115
  byte 58
  byte 0
S206:
  byte 40
  byte 0
S207:
  byte 41
  byte 0
S208:
  byte 102
  byte 117
  byte 110
  byte 99
  byte 32
  byte 111
  byte 99
  byte 116
  byte 115
  byte 58
  byte 0
S209:
  byte 40
  byte 0
S210:
  byte 41
  byte 0
S211:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 101
  byte 113
  byte 58
  byte 0
S212:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 110
  byte 101
  byte 113
  byte 58
  byte 0
S213:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 108
  byte 116
  byte 58
  byte 0
S214:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 108
  byte 101
  byte 58
  byte 0
S215:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 103
  byte 116
  byte 58
  byte 0
S216:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 103
  byte 101
  byte 58
  byte 0
S217:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 99
  byte 109
  byte 112
  byte 58
  byte 0
S218:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 110
  byte 100
  byte 58
  byte 0
S219:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 111
  byte 114
  byte 58
  byte 0
S220:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 109
  byte 111
  byte 100
  byte 58
  byte 0
S221:
  byte 100
  byte 105
  byte 118
  byte 105
  byte 115
  byte 105
  byte 111
  byte 110
  byte 32
  byte 98
  byte 121
  byte 32
  byte 122
  byte 101
  byte 114
  byte 111
  byte 0
S222:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 100
  byte 105
  byte 118
  byte 58
  byte 0
S223:
  byte 100
  byte 105
  byte 118
  byte 105
  byte 115
  byte 105
  byte 111
  byte 110
  byte 32
  byte 98
  byte 121
  byte 32
  byte 122
  byte 101
  byte 114
  byte 111
  byte 0
S224:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 109
  byte 117
  byte 108
  byte 58
  byte 0
S225:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 115
  byte 117
  byte 98
  byte 58
  byte 0
S226:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 100
  byte 100
  byte 58
  byte 0
S227:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 99
  byte 111
  byte 110
  byte 99
  byte 97
  byte 116
  byte 58
  byte 0
S228:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 58
  byte 0
S229:
  byte 116
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S230:
  byte 41
  byte 0
S231:
  byte 84
  byte 121
  byte 112
  byte 101
  byte 32
  byte 77
  byte 105
  byte 115
  byte 109
  byte 97
  byte 116
  byte 99
  byte 104
  byte 0
S232:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 32
  byte 112
  byte 101
  byte 114
  byte 109
  byte 97
  byte 110
  byte 101
  byte 110
  byte 116
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S233:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 110
  byte 117
  byte 109
  byte 101
  byte 114
  byte 105
  byte 99
  byte 32
  byte 112
  byte 101
  byte 114
  byte 109
  byte 97
  byte 110
  byte 101
  byte 110
  byte 116
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S234:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 110
  byte 117
  byte 109
  byte 98
  byte 101
  byte 114
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S235:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 41
  byte 32
  byte 58
  byte 0
S236:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S237:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S238:
  byte 84
  byte 121
  byte 112
  byte 101
  byte 32
  byte 77
  byte 105
  byte 115
  byte 109
  byte 97
  byte 116
  byte 99
  byte 104
  byte 0
S239:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 32
  byte 102
  byte 117
  byte 110
  byte 99
  byte 116
  byte 105
  byte 111
  byte 110
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S240:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 110
  byte 117
  byte 109
  byte 101
  byte 114
  byte 105
  byte 99
  byte 32
  byte 102
  byte 117
  byte 110
  byte 99
  byte 116
  byte 105
  byte 111
  byte 110
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S241:
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 58
  byte 0
S242:
  byte 83
  byte 121
  byte 110
  byte 116
  byte 97
  byte 120
  byte 32
  byte 69
  byte 114
  byte 114
  byte 111
  byte 114
  byte 0
S243:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 32
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S244:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 110
  byte 117
  byte 109
  byte 101
  byte 114
  byte 105
  byte 99
  byte 32
  byte 118
  byte 97
  byte 114
  byte 105
  byte 97
  byte 98
  byte 108
  byte 101
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S245:
  byte 73
  byte 108
  byte 108
  byte 101
  byte 103
  byte 97
  byte 108
  byte 32
  byte 69
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 0
S246:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 116
  byte 111
  byte 109
  byte 40
  byte 111
  byte 116
  byte 104
  byte 101
  byte 114
  byte 41
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S247:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 116
  byte 101
  byte 114
  byte 109
  byte 58
  byte 0
S248:
  byte 109
  byte 111
  byte 100
  byte 0
S249:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 116
  byte 101
  byte 114
  byte 109
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S250:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 58
  byte 0
S251:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 32
  byte 101
  byte 110
  byte 100
  byte 40
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 41
  byte 58
  byte 0
S252:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 50
  byte 58
  byte 0
S253:
  byte 84
  byte 111
  byte 107
  byte 101
  byte 110
  byte 84
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S254:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 97
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 32
  byte 101
  byte 110
  byte 100
  byte 40
  byte 110
  byte 117
  byte 109
  byte 98
  byte 101
  byte 114
  byte 41
  byte 58
  byte 0
S255:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 114
  byte 101
  byte 108
  byte 97
  byte 116
  byte 105
  byte 111
  byte 110
  byte 58
  byte 0
S256:
  byte 62
  byte 61
  byte 0
S257:
  byte 62
  byte 0
S258:
  byte 60
  byte 61
  byte 0
S259:
  byte 60
  byte 0
S260:
  byte 60
  byte 62
  byte 0
S261:
  byte 61
  byte 0
S262:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 114
  byte 101
  byte 108
  byte 97
  byte 116
  byte 105
  byte 111
  byte 110
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S263:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 108
  byte 116
  byte 101
  byte 114
  byte 109
  byte 58
  byte 0
S264:
  byte 97
  byte 110
  byte 100
  byte 0
S265:
  byte 101
  byte 118
  byte 97
  byte 108
  byte 32
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 58
  byte 0
S266:
  byte 111
  byte 114
  byte 0
S267:
  byte 103
  byte 101
  byte 116
  byte 32
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 58
  byte 0
S268:
  byte 84
  byte 121
  byte 112
  byte 101
  byte 32
  byte 77
  byte 105
  byte 115
  byte 109
  byte 97
  byte 116
  byte 99
  byte 104
  byte 0
S269:
  byte 103
  byte 101
  byte 116
  byte 32
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 58
  byte 0
S270:
  byte 103
  byte 101
  byte 116
  byte 32
  byte 110
  byte 117
  byte 109
  byte 98
  byte 101
  byte 114
  byte 58
  byte 0
S271:
  byte 84
  byte 121
  byte 112
  byte 101
  byte 32
  byte 77
  byte 105
  byte 115
  byte 109
  byte 97
  byte 116
  byte 99
  byte 104
  byte 0
S272:
  byte 118
  byte 97
  byte 108
  byte 117
  byte 101
  byte 61
  byte 0
S273:
  byte 112
  byte 117
  byte 116
  byte 32
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 58
  byte 0
S274:
  byte 112
  byte 117
  byte 116
  byte 32
  byte 115
  byte 116
  byte 114
  byte 105
  byte 110
  byte 103
  byte 32
  byte 101
  byte 110
  byte 100
  byte 58
  byte 0
S275:
  byte 112
  byte 117
  byte 116
  byte 32
  byte 110
  byte 117
  byte 109
  byte 98
  byte 101
  byte 114
  byte 58
  byte 0
S276:
  byte 73
  byte 108
  byte 108
  byte 101
  byte 103
  byte 97
  byte 108
  byte 32
  byte 101
  byte 120
  byte 112
  byte 114
  byte 101
  byte 115
  byte 115
  byte 105
  byte 111
  byte 110
  byte 0
S277:
  byte 99
  byte 108
  byte 101
  byte 97
  byte 114
  byte 32
  byte 118
  byte 97
  byte 108
  byte 117
  byte 101
  byte 58
  byte 0
S278:
  byte 67
  byte 65
  byte 82
  byte 68
  byte 56
  byte 32
  byte 66
  byte 65
  byte 83
  byte 73
  byte 67
  byte 32
  byte 86
  byte 69
  byte 82
  byte 32
  byte 48
  byte 46
  byte 50
  byte 0
S279:
  byte 82
  byte 69
  byte 65
  byte 68
  byte 89
  byte 0
S280:
  byte 62
  byte 32
  byte 0
S281:
  byte 63
  byte 32
  byte 0
S282:
  byte 108
  byte 105
  byte 110
  byte 101
  byte 61
  byte 0
S283:
  byte 116
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S284:
  byte 100
  byte 105
  byte 114
  byte 101
  byte 99
  byte 116
  byte 32
  byte 99
  byte 111
  byte 109
  byte 109
  byte 97
  byte 110
  byte 100
  byte 58
  byte 0
S285:
  byte 116
  byte 101
  byte 120
  byte 116
  byte 61
  byte 0
S286:
  byte 108
  byte 101
  byte 110
  byte 103
  byte 116
  byte 104
  byte 61
  byte 0
S287:
  byte 100
  byte 105
  byte 114
  byte 101
  byte 99
  byte 116
  byte 32
  byte 99
  byte 111
  byte 109
  byte 109
  byte 97
  byte 110
  byte 100
  byte 32
  byte 111
  byte 110
  byte 108
  byte 121
  byte 0
S288:
  byte 60
  byte 60
  byte 60
  byte 66
  byte 89
  byte 69
  byte 62
  byte 62
  byte 62
  byte 0
__sign: memory 1
__nbuf: memory 64
__p0: memory 12
__p1: memory 3
__p2: memory 3
__p3: memory 3
__p4: memory 3
__p5: memory 3
__p6: memory 3
__p7: memory 3
__t: memory 3
__u: memory 3
read_p: memory 3
__stack: memory STACK_SIZE*3
__stack_top: memory 3
arg0: memory 3
r0: memory 3
r1: memory 3
r2: memory 3
r3: memory 3
__tmp: memory 3
__ans: memory 3
__sgn: memory 3
ForStackP: memory 3
GosubStackP: memory 3
xlineno: memory 3
xmode: memory 3
no: memory 3
mesg: memory 3
token: memory 3
cc1: memory 3
DirectArea: memory 1024
ProgArea: memory PROG_SIZE
NumVarArea: memory NUM_VAR_SIZE*3
StrVarArea: memory STR_VAR_SIZE
ArrayArea: memory ARRAY_SIZE*3
ForStackArea: memory FOR_STACK_SIZE
GosubStackArea: memory GOSUB_STACK_SIZE
CalcStackArea: memory CALC_STACK_SIZE
JmpEntry: memory 3
StackSave: memory 3
EndProg: memory 3
CurrentProg: memory 3
BreakProg: memory 3
TextBuffer: memory MAX_TEXT_LENGTH+1
TokenText: memory MAX_TEXT_LENGTH+1
VarName: memory MAX_TEXT_LENGTH+1
TokenP: memory 3
BreakToken: memory 3
TokenType: memory 3
TokenCode: memory 3
TokenValue: memory 3
CalcStackP: memory 3
SysError: memory 3
TopVar: memory 3
EndVar: memory 3
ErrorMessage: memory 3
BreakFlg: memory 3
RunFlg: memory 3
CurrentLineNo: memory 3
BasicBusy: memory 3
var_type: memory 3
ii: memory 12
jj: memory 12
kk: memory 12
ll: memory 12
mm: memory 12
nn: memory 12
aa: memory 3
bb: memory 3
cc: memory 3
lbl: memory 3
str: memory 3
pp: memory 3
qq: memory 3
rr: memory 3
ss: memory 3
tt: memory 3
uu: memory 3
vv: memory 3
ww: memory 3
xx: memory 3
yy: memory 3
zz: memory 3
prog: memory 3
plen: memory 3
ofset: memory 3
ee: memory 3
txt: memory 3
lx: memory 3
xvname: memory 3
index: memory 3
pp1: memory 3
for_var: memory 3
input_var: memory 3
is_question: memory 3
last_char: memory 3
lvar: memory 3
list_st: memory 3
list_ed: memory 3
ss0: memory 3
ccc: memory 2
vabs: memory 3
inkey_str: memory 8
ss1: memory 3
vsgn0: memory 3
vsgn: memory 3
sss0: memory MAX_STR_LENGTH
sign: memory 3
typ: memory 3
val: memory 3
s0: memory 3
s1: memory 3
s2: memory 3
d1: memory 3
d2: memory 3
sss: memory MAX_STR_LENGTH+1
vgetn: memory 3
num: memory 3
valx: memory 3
text: memory MAX_TEXT_LENGTH+1
ptext: memory MAX_TEXT_LENGTH+1
status: memory 3
pline: memory 3
