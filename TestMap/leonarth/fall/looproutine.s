.equ	poin2, poin1+4
.thumb
push	{r4-r6,lr}
mov	r4,r0		@the proc pointer

@move the bg0 over
ldr	r0,=#0x3003080
mov	r2,#0x67
ldrb	r1,[r4,r2]	@set the counter
sub	r1,#1
strb	r1,[r4,r2]
strb	r1,[r0,#0x1E]

@first clear the background
ldr	r0,=#0x2022CA8
mov	r1,#0
ldr	r3,=#0x8001221	@FillBgMap
mov	lr,r3
.short	0xF800

@now draw our map
ldr	r2,=#0x2000
ldr	r3,=#0x2022CA8
maploop:
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
sub	r3,#6
add	r3,#0x40
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
sub	r3,#6
add	r3,#0x40
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
sub	r3,#6
add	r3,#0x40
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]
add	r2,#1
add	r3,#2
strh	r2,[r3]

@load the graphics
@check counter
mov	r2,#0x67
ldrb	r1,[r4,r2]
mov	r2,#1
and	r1,r2
cmp	r1,#0
beq	frame1
frame2:
ldr	r0,poin2
b	gotframe
frame1:
ldr	r0,poin1
gotframe:
ldr	r1,=#0x6000000
ldr	r2,=#0x2400
ldr	r3,=#0x8002014	@CopyDataWithPossibleUncomp
mov	lr,r3
.short	0xF800

@set bg for update
ldr	r0,=#0x300000D
ldrb	r1,[r0]
mov	r2,#1
orr	r1,r2
strb	r1,[r0]

@break loop if next frame is all 0xFF

beq	BreakLoop
@check counter
mov	r2,#0x67
ldrb	r1,[r4,r2]
cmp	r1,#0x9C
beq	BreakLoop

End:
pop	{r4-r6}
pop	{r0}
bx	r0

BreakLoop:
mov	r0,r4
ldr	r3,=#0x8002E94
mov	lr,r3
.short	0xF800
pop	{r4-r6}
pop	{r0}
bx	r0

.ltorg
.align

poin1:
@poin1
@poin2
