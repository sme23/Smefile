.thumb
.align 4


.equ HolyBloodCharTable, HolyBloodTable+4


push {r4-r5,r14}

@return current character's holy blood name in r0, or return 0xE0 (which is "--") if no blood
mov r3,r0
ldr r0, =0x2003bfc
ldr r0, [r0, #0xc] @r0 = char struct pointer
ldr r0,[r0]  @r0 = char data pointer
ldrb r0,[r0,#4]@r0= char ID
ldr r1,HolyBloodCharTable
add r1,r0
ldrb r0,[r1] @r0 = holy blood ID
cmp r0,#0xFF
beq BadEnd
mov r1,#0x7F
and r0,r1
ldr r1,HolyBloodTable
mov r2,#20
mul r0,r2 @blood ID * length of a table entry
add r1,r0 @r1=table entry start, which is name ID
add r1,#2 @r1=desc ID
ldrh r0,[r1]
b GoBack

BadEnd:
mov r0,#0xE0

GoBack:
mov r1,r3
add r1,#0x4C
strh r0,[r1]
pop {r4-r5}
pop {r0}
bx r0

.ltorg
.align
HolyBloodTable:
