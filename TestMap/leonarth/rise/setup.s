.thumb
push	{r4,lr}
mov	r4,r0
sub	sp,#4
mov	r1,#0x67
mov	r2,#0x00
strb	r2,[r0,r1]	@reset the counter

ldr	r0,=#0x2022CA8
mov	r1,#0
ldr	r3,=#0x8001220	@FillBgMap

@special effects

@coefficients?
mov	r0,#1
mov	r1,#0x09
mov	r2,#0x09
ldr	r3,=#0x8001EA0
mov	lr,r3
mov	r3,#0
.short	0xF800

@set bg 0 for alpha?
mov	r0,#0
str	r0,[sp]
mov	r0,#1
mov	r1,#0
mov	r2,#0
ldr	r3,=#0x8001ED0
mov	lr,r3
mov	r3,#0
.short	0xF800

@set the others to blend with?
mov	r0,#1
str	r0,[sp]
mov	r0,#0
mov	r1,#1
mov	r2,#1
ldr	r3,=#0x8001F0C
mov	lr,r3
mov	r3,#1
.short	0xF800

ldr	r0,=#0x300309E
ldrh	r1,[r0]
sub	r1,#16
strh	r1,[r0]

@load the palette
ldr	r0,pointer
mov	r1,#0x40
mov	r2,#0x20
ldr	r3,=#0x08000DB8	@CopyToPaletteBuffer
mov	lr,r3
.short	0xF800

ldr	r0,=#0x300000E
mov	r1,#1
strb	r1,[r0]

@move the bg0 over
ldr	r0,=#0x3003080
mov	r1,#0x88
strb	r1,[r0,#0x1C]
mov	r1,#0xBC
strb	r1,[r0,#0x1E]
mov	r2,#0x67
strb	r1,[r4,r2]	@set the counter

add	sp,#4
pop	{r4}
pop	{r0}
bx	r0

.align
.ltorg

pointer:

