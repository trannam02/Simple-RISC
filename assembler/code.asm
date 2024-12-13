jmp XX



XX jmp JMPOK

JMPOK lda 0x1c // load data 1 
skz
hlt
lda 0x1d // load data 2
skz
jmp  SKZ OK
hlt

SKZ OK: sto 0x1e // store vao temp
sta
sta
lda 0x1c
and 0x1d // and voi 1
sta
sto 0x1e
sta
sta
lda 0x1e
and 0x1c
sta
skz // tai vi tri 0E cua thay
hlt