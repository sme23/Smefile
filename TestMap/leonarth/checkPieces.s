.thumb

ldr	r0,=#0x3004E50	@current character pointer
ldr	r0,[r0]

ldr	r2,=#0x01A4

ldrh	r1,[r0,#0x1E]
cmp	r1,r2
bne	False
ldrh	r1,[r0,#0x20]
cmp	r1,r2
bne	False
ldrh	r1,[r0,#0x22]
cmp	r1,r2
bne	False
ldrh	r1,[r0,#0x24]
cmp	r1,r2
bne	False
ldrh	r1,[r0,#0x26]
cmp	r1,r2
bne	False

mov	r1,#0
strh	r1,[r0,#0x1E]
strh	r1,[r0,#0x20]
strh	r1,[r0,#0x22]
strh	r1,[r0,#0x24]
strh	r1,[r0,#0x26]

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

.ltorg
.align
