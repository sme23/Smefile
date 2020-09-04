.thumb
push	{lr}

ldr	r2,=#0x30004B8	@setval spots
ldr	r0,[r2,#4]	@x
ldr	r1,[r2,#8]	@y
ldr	r3,[r2,#12]	@event id
ldr	r2,trapID	@trapID
push	{r3}
ldr	r3,=#0x802E2B8
mov	lr,r3
pop	{r3}
.short	0xF800

pop	{r0}
bx	r0

.align
.ltorg
trapID:
