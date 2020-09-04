.thumb
push	{lr}

@check if player phase, if not return 0
ldr	r0,=#0x202BCF0
ldrb	r0,[r0,#0x0F]
cmp	r0,#0
bne	False

@check if active unit has thief ability
ldr	r0,=#0x3004E50	@current character pointer
ldr	r0,[r0]
ldr	r1,[r0]		@character
ldr	r0,[r0,#0x04]	@class
ldr	r0,[r0,#0x28]
ldr	r1,[r1,#0x28]
orr	r0,r1		@character abilities
mov	r1,#0x0C	@lockpicks and steal
and	r0,r1
cmp	r0,#0
bne	True

@get active unit luck
ldr	r0,=#0x3004E50
ldr	r0,[r0]
ldrb	r0,[r0,#0x19]

@roll 1rn against luck, if it hits return 1
ldr	r3,=#0x8000CA1	@roll 1rn
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	End

True:
mov	r0,#1
b	End

False:
mov	r0,#0

End:
ldr	r1,=#0x030004B8
mov	r2,#0xB
lsl	r2,#2
str	r0,[r1,r2]
pop	{r0}
bx	r0

.align
.ltorg
