.equ eventid, itemid+4
.thumb

push	{r0-r3}

@check if chapter 6
ldr	r0,=#0x202BCF0
ldrb	r0,[r0,#0x0E]	@chapter id
cmp	r0,#7		@7, since 5x is 6
bne	End
	
@check item id
add	r1,r2
ldrh	r1,[r1]
mov	r2,#0xFF
and	r1,r2
ldr	r2,itemid
cmp	r1,r2
bne	End

@set event id
ldr	r0,eventid
ldr	r3,=#0x8083D81	@SetEventId
mov	lr,r3
.short	0xF800

End:
ldr	r3,=#0x80B5220
mov	lr,r3
pop	{r0-r3}
add	r1,r2
ldrh	r1,[r1]
.short	0xF800
ldr	r3,=#0x80B546D
bx	r3

.align
.ltorg

itemid:
@WORD itemid
@WORD eventid
