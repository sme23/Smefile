.equ trapID, radarTile+4
.thumb
pop	{r3}
push	{r0-r7}
mov	r0,r2	@x
mov	r1,r3	@y
mov	r2,#1

@check if chapter 6
ldr	r2,=#0x202BCF0
ldrb	r2,[r2,#0x0E]	@chapter id
cmp	r2,#7		@7, since 5x is 6
bne	Test

@check if there is an active radar trap for this tile
@r0 is x, r1 is y
ldr	r2,trapID
ldr	r3,=#0x802E24D	@GetSpecificTrapAt
mov	lr,r3
.short	0xF800
cmp	r0,#0
beq	Test

@check if the event id is triggered
ldrb	r0,[r0,#0x03]
ldr	r3,=#0x8083DA9	@CheckEventId
mov	lr,r3
.short	0xF800
cmp	r0,#1
bne	Radar

Test:
pop	{r0-r7}
ldr	r0,[r0]
add	r0,r2
ldrb	r0,[r0]
End:
cmp	r0,#0x40
bls	End2
ldr	r0,=#0x80A7BF2
mov	lr,r0
.short 0xF800
End2:
ldr	r1,=#0x80A7A26
mov	lr,r1
.short 0xF800

Radar:
@get radar mini tile
pop	{r0-r7}
ldr	r0,radarTile
b	End

.ltorg
.align
radarTile:
@WORD radarTile
@WORD trapID
