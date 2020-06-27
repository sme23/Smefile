.thumb
.align


.global BattleStatusImmunity
.type BattleStatusImmunity, %function

.global StaffStatusImmunity
.type StaffStatusImmunity, %function



BattleStatusImmunity: @r3 hook at 2B628

@things that got overwritten by the hook
mov r7,r5
add r7,#0x48

push {r0-r7}

@r0 = class ID
ldr r2,=StatusImmunitiesClassList

BattleStatusImmunity_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq BattleStatusImmunity_LoopExit
cmp r1,r0
beq BattleStatusImmunity_LoopSuccess

BattleStatusImmunity_LoopRestart:
add r2,#1
b BattleStatusImmunity_LoopStart

BattleStatusImmunity_LoopExit:
@loop failed here, return to 2b630 which is just after what the hook overwrote
pop {r0-r7}
ldr r0,=#0x0802B631
bx r0

BattleStatusImmunity_LoopSuccess:
@loop succeeded here, return to 2b696 which is where it goes if demon king is true
pop {r0-r7}
ldr r0,=#0x0802B697
bx r0

.ltorg
.align


StaffStatusImmunity: @r3 hook at 2cd38

@things the hook overwrote
ldr r0,[r6,#4]
ldrb r0,[r0,#4]

push {r0-r7}

@r0 = class ID
ldr r2,=StatusImmunitiesClassList

StaffStatusImmunity_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq StaffStatusImmunity_LoopExit
cmp r1,r0
beq StaffStatusImmunity_LoopSuccess

StaffStatusImmunity_LoopRestart:
add r2,#1
b StaffStatusImmunity_LoopStart

StaffStatusImmunity_LoopExit:
@loop failed here, return to 2cd40 which is just after what the hook overwrote
pop {r0-r7}
ldr r0,=#0x0802CD41
bx r0

StaffStatusImmunity_LoopSuccess:
@loop succeeded here, return to 2cd4c which is where it goes if demon king is true
pop {r0-r7}
ldr r0,=#0x0802CD4D
bx r0

.ltorg
.align

