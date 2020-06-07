.thumb
.global ItemSpecificWTA
.type ItemSpecificWTA, %function

@attack struct is passed in via r0 with the defense struct in r1


ItemSpecificWTA:
push {r4-r7,r14}

mov r4,r0
mov r5,r1


mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r2,#0xFF
and r0,r2

mov r1,r5
add r1,#0x4A
ldrh r1,[r1]
and r1,r2

ldr r3,=ItemSpecificWTAList

LoopStart:
ldrb r2,[r3]
cmp r2,#0
beq CheckDefender

cmp r2,r0
bne LoopRestart

ldrb r2,[r3,#1]
cmp r2,r1
beq SetWTAStuff

LoopRestart:
add r3,#4
b LoopStart

SetWTAStuff:
ldrb r0,[r3,#2]
ldrb r1,[r3,#3]

mov r3,r4
add r3,#0x53
ldrb r2,[r3]
add r2,r0
strb r2,[r3]
add r3,#1
ldrb r2,[r3]
add r2,r1
strb r2,[r3]

mov r3,r5
add r3,#0x53
ldrb r2,[r3]
sub r2,r0
strb r2,[r3]
add r3,#1
ldrb r2,[r3]
sub r2,r1
strb r2,[r3]

@now do it again for the defender

CheckDefender:

mov r6,r4
mov r4,r5
mov r5,r6

mov r0,r4
add r0,#0x4A
ldrh r0,[r0]
mov r2,#0xFF
and r0,r2

mov r1,r5
add r1,#0x4A
ldrh r1,[r1]
and r1,r2

ldr r3,=ItemSpecificWTAList

LoopStart2:
ldrb r2,[r3]
cmp r2,#0
beq GoBack

cmp r2,r0
bne LoopRestart2

ldrb r2,[r3,#1]
cmp r2,r1
beq SetWTAStuff2

LoopRestart2:
add r3,#4
b LoopStart2

SetWTAStuff2:
ldrb r0,[r3,#2]
ldrb r1,[r3,#3]

mov r3,r4
add r3,#0x53
ldrb r2,[r3]
add r2,r0
strb r2,[r3]
add r3,#1
ldrb r2,[r3]
add r2,r1
strb r2,[r3]

mov r3,r5
add r3,#0x53
ldrb r2,[r3]
sub r2,r0
strb r2,[r3]
add r3,#1
ldrb r2,[r3]
sub r2,r1
strb r2,[r3]

GoBack:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

