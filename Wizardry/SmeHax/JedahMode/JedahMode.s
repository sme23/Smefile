.thumb
.align


.global JedahModeFE15
.type JedahModeFE2, %function

.global JedahModeFE2
.type JedahModeFE2, %function




JedahModeFE2: @the easier one
push {r4-r7,r14}
mov r4,r0 @attacker
mov r5,r1 @defender

@is defender jedah?
ldr r2,=IsJedahList
ldr r1,[r5]
ldrb r1,[r1,#4]

FE2_LoopStart:
ldrb r0,[r2]

cmp r0,#0
beq FE2_NotJedah

cmp r0,r1
beq FE2_IsJedah

add r2,#1
b FE2_LoopStart

FE2_IsJedah:
@is it a multiple of 4 turns?
ldr r0,=#0x202BCF0 @chapter data struct
ldrh r0,[r0,#0x10] @turn number
@divide by 4 and take remainder
mov r1,#4
swi #6 @Div
@r1 = our number
cmp r1,#0
beq FE2_NotJedah

@attacker now does 0 damage @this makes bug when checking stat screen after targeting jedah!
mov r0,r4
add r0,#0x5A
mov r1,#0
strh r1,[r0]


FE2_NotJedah:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

