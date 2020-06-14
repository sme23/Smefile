.thumb
.align

.global CantoPlus
.type CantoPlus, %function

CantoPlus:
push	{lr}
@check if dead
ldrb	r0, [r4,#0x13]
cmp	r0, #0x00
beq	End

@check if flag 0x3 set; if so, cannot canto
ldr r0,=#0x8083da8 @CheckEventId
mov r14,r0
mov r0,#3
.short 0xF800
cmp r0,#1
beq End

ldr	r1,=#0x8018BD8	@check if can move again
mov	lr, r1
.short	0xF800
lsl	r0, #0x18
cmp	r0, #0x00
beq	End

@check if waited this turn
ldrb  r0, [r6,#0x11]  @action taken this turn
cmp r0, #0x01 @check if waited
beq End

ldrb  r0, [r6,#0x0C]  @allegiance byte of the current character taking action
ldrb  r1, [r4,#0x0B]  @allegiance byte of the character we are checking
cmp r0, r1    @check if same character
bne End

@check if already cantoing
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x40	@has moved already
and	r0, r1
cmp	r0, #0x00
bne	End

@check for option and ability
ldr	r0,[r4]		@load character data
cmp	r0,#0x00	@just in case there's no pointer (was doing weird things with generics without this)
beq	JumpLoad1
ldr	r0,[r0,#0x28]	@load character abilities
JumpLoad1:
ldr	r1,[r4,#0x04]	@load class data
cmp	r1,#0x00	@just in case there's no pointer
beq	JumpLoad2
ldr	r1,[r1,#0x28]	@load class abilities
JumpLoad2:
orr	r0,r1
ldr	r1,=#0x102		@canto bit & promoted bit
and	r0,r1
cmp	r0,r1
bne End	


HasSkill:
CanCanto:
@if canto, unset 0x2 and set 0x40
ldr	r0, [r4,#0x0C]	@status bitfield
mov	r1, #0x02
mvn	r1, r1
and	r0, r1		@unset bit 0x2
mov	r1, #0x40	@set canto bit
orr	r0, r1
str	r0, [r4,#0x0C]
End:
pop	{r0}
bx	r0

.ltorg
.align
