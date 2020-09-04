.thumb

ldr	r0,=#0x202BCF0
ldrh	r0,[r0,#0x10]	@turn
mov	r1,#3
swi	#6		@check if turns is divisible by 3
cmp	r1,#0

beq	True

False:
mov	r0,#0
b	End

True:
mov	r0,#1

End:
ldr	r1,=#0x030004B8
mov	r2,#0xB
lsl	r2,#2
str	r0,[r1,r2]
bx	lr

.ltorg
.align
