.thumb
.align

@all we need to do is an effect, the rest is just identical to rescue

.global SwarpStaffEffect
.type SwarpStaffEffect, %function

.global ExecSwarpStaff
.type ExecSwarpStaff, %function


SwarpStaffEffect:
mov r0,r6
bl ExecSwarpStaff
ldr r0,=#0x802FF77 @return point
bx r0

.ltorg
.align



.macro blh to,reg=r3
	push {\reg}
	ldr \reg,=\to
	mov r14,\reg
	pop {\reg}
	.short 0xF800
.endm

.equ gActionData,0x203A958
.equ GetUnit,0x8019430
.equ SetupSubjectBattleUnitForStaff,0x802CB24
.equ SetupTargetBattleUnitForStaff,0x802CBC8
.equ GetRescueStaffeePosition,0x802ECD0
.equ gTargetBattleUnit,0x203A56C
.equ FinishUpItemBattle,0x802CC54
.equ BeginBattleAnimations,0x802CA14



ExecSwarpStaff:
push {r4-r7,r14}
add sp,#-8
mov r6,r0

ldr r4,=gActionData
ldrb r0,[r4,#0xC]
blh GetUnit
mov r5,r0

ldrb r1,[r4,#0x12]
blh SetupSubjectBattleUnitForStaff

ldrb r0,[r4,#0xD]
blh GetUnit
mov r7,r0
blh SetupTargetBattleUnitForStaff


@this is rescue's effect, normally; moves target unit to position given by GetRescueStaffeePosition
@mov r1,r7
@add r3,sp,#4
@mov r0,r5
@mov r2,r13
@blh GetRescueStaffeePosition

@mov r0,r7
@ldr r1,[sp]
@strb r1,[r0,#0x10]
@ldr r1,[sp,#4]
@strb r1,[r0,#0x11]

@ldr r0,=gTargetBattleUnit
@ldr r1,[sp]
@mov r2,r0
@add r2,#0x73
@strb r1,[r2]
@ldr r1,[sp,#4]
@add r0,#0x74
@strb r1,[r0]

@for swarp, we just swap our two units' positions (+ update the action struct for target location of target unit)

mov r0,r5 @attacker, but their normal location
mov r1,r7 @defender, but their normal location

ldrb r2,[r0,#0x10] @r2 = attacker's initial x pos
ldrb r3,[r0,#0x11] @r3 = attacker's initial y pos
ldrb r4,[r1,#0x10] @r4 = defender's initial x pos
ldrb r5,[r1,#0x11] @r5 = defender's initial y pos

strb r2,[r1,#0x10]
strb r3,[r1,#0x11]
strb r4,[r0,#0x10]
strb r5,[r0,#0x11]

ldr r1,=gTargetBattleUnit
add r1,#0x74
strb r2,[r1]
add r3,#1
strb r3,[r1]

ldr r0,=gActionData
strb r4,[r0,#0xE]
strb r5,[r0,#0xF]


mov r0,r6
blh FinishUpItemBattle
blh BeginBattleAnimations

add sp,#8
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

