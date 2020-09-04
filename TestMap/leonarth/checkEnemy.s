.thumb
@check if there is an enemy in that tile
ldr	r1,=#0x030004B8
mov	r2,#0x1
lsl	r2,#2
ldr	r0,[r1,r2]	@x
mov	r2,#2
lsl	r2,#2
ldr	r1,[r1,r2]	@y
ldr	r2,=#0x202E4D8	@unit map
ldr	r2,[r2]
lsl	r1,#2
ldr	r2,[r2,r1]
ldrb	r0,[r2,r0]
mov	r1,#0x80
and	r0,r1
cmp	r0,#0
beq	False

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
bx	lr

.align
.ltorg
