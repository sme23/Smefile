.equ eventid, itemid+4
.equ textid, eventid+4
.thumb

@check if chapter 6
ldr	r0,=#0x202BCF0
ldrb	r0,[r0,#0x0E]	@chapter id
cmp	r0,#7		@7, since 5x is 6
bne	End

@check text id
ldr	r0,=#0x8B3
cmp	r0,r4
beq	Match
ldr	r0,=#0x8B6
cmp	r0,r4
beq	Match
b	End
Match:

@check event id
ldr	r0,eventid
ldr	r3,=#0x8083DA9	@CheckEventId
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	End

@check item id
@r5 is pointer to proc, +0x5c is item being looked at, +0x30 is item list
mov	r0,#0x5C
ldrb	r0,[r5,r0]
lsl	r0,#1
add	r0,#0x30
ldrb	r0,[r5,r0]	@item being looked at
ldr	r1,itemid
cmp	r0,r1
bne	End

@check if buying
mov	r0,#0x60
ldrb	r0,[r5,r0]
cmp	r0,#0
bne	End

mov	r0,#0x02
ldr	r3,=#0x30000E8	@write selected option as not buy
str	r0,[r3]
ldr	r4,textid

End:
mov	r0,r4
ldr	r3,=#0x800A240
mov	lr,r3
.short	0xF800
mov	r2,r0
mov	r0,#0x08
mov	r1,#0x02
ldr	r3,=#0x80B4193
bx	r3

.align
.ltorg

itemid:
@WORD itemid
@WORD eventid
@WORD textid
