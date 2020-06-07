.thumb
.align


.global IocanePowder
.type IocanePowder, %function

.equ IsImmuneReturnPoint, 0x802B697
.equ NotImmuneReturnPoint, 0x802B631

IocanePowder:
@things we overwrote with the hook
mov r7,r5
add r7,#0x48

@now we can do our check
@r0 = class to compare against, load a class to compare to, we'll need 2 additional free registers (r1 and r2 should be free)
ldr r2,=ImmunitiesClassList
LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq ReturnNotImmune
cmp r1,r0
beq ReturnImmune
add r2,#1
b LoopStart

ReturnImmune:
ldr r0,=IsImmuneReturnPoint
bx r0

ReturnNotImmune:
ldr r0,=NotImmuneReturnPoint
bx r0

.ltorg
.align
