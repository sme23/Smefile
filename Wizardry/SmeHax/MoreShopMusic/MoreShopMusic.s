.thumb
.align

.global MoreShopMusic
.type MoreShopMusic, %function

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ MusFunc,0x80024D4
.equ ReturnPoint,0x80B4C01


MoreShopMusic:

mov r6,r0 @r0=0x2025084




add r0,#0x61
ldrb r0,[r0] @r0 = shop type
ldr r2,=#0x202BCF0
ldrb r2,[r2,#0xE] @r2 = chapter ID
mov r1,#4
mul r1,r2
ldr r2,=ShopChapterPointerTable
add r1,r2
ldr r1,[r1] @r1 = shop type ch list
add r0,r1
ldrb r0,[r0] @r0 = song ID

mov r1,#0
blh MusFunc


GoBack:
ldr r1,=ReturnPoint
bx r1

.ltorg
.align

