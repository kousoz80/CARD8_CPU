PRINT_DATA = 0xffffff
PRINT_STB = 0xfffffe

 org 0
 x=hello
 (p)=x
 x=12
 (i)=x
loop:
 x=(p)
 a=(x)
 x+=(_001)
 (p)=x
 x=PRINT_DATA
 (x)=a
 a=1
 x=PRINT_STB
 (x)=a
 x=(i)
 x-=(_001)
 (i)=x
 jnz loop
end:
 jmp end

// variable
p:    int 0
i:    int 0
_001: int 1

// string
hello:
 byte 'h'
 byte 'e'
 byte 'l'
 byte 'l'
 byte 'o'
 byte 32
 byte 'w'
 byte 'o'
 byte 'r'
 byte 'l'
 byte 'd'
 byte 10
