.thumb
.align

@formerly in CanUnitWieldWeapon, this adds compatibility for things that happen before WRank check (i.e. weapon locks) and needs lumina/shadowgift to happen after

.equ WeaponLockArrayPointerTable,ItemTable+4

DoesUnitHaveWRank:
push {r4-r7,r14}

mov r4,r0 @character pointer
mov r5,r1 @item halfword
mov r6,r2 @rank

@get item's wrank requirement
mov r0,r5
mov r1,#0xFF
and r0,r1
mov r1,#0x24
mul r0,r1
ldr r1,ItemTable
add r0,r1
ldrb r0,[r0,#0x1C]
cmp r0,r6
ble RetTrue @if (item wrank <= user wrank)

@Now we check, does unit have a soft weapon lock for this item & any rank in the required type?

@get item's ability byte 4
mov r0,r5
mov r1,#0xFF
and r0,r1
mov r1,#0x24
mul r0,r1
ldr r1,ItemTable
add r0,r1
ldr r0,[r0,#8]
lsr r0,#24
cmp r0,#0
beq RetFalse

@get array pointer
lsl r0,#2
ldr r1,WeaponLockArrayPointerTable
add r7,r0,r1
ldr r0,[r7]
cmp r0,#0
beq RetFalse

mov r7,r0
ldrb r0,[r7]

cmp r0,#1
ble GetCharID

GetClassID:
ldr r1,[r4,#4]
ldrb r1,[r1,#4]
b GetIDEnd

GetCharID:
ldr r1,[r4]
ldrb r1,[r1,#4]

GetIDEnd:
push {r0}

add r7,#1
LoopStart:
ldrb r0,[r7]
cmp r0,#0
beq LoopFail
cmp r0,r1
beq LoopSuccess
add r7,#1
b LoopStart

LoopSuccess:
@check if soft lock
pop {r0}
cmp r0,#1
beq RetFalse
cmp r0,#3
beq RetFalse

@is soft lock
@do we have any rank?
cmp r6,#0
beq RetFalse

b RetTrue

LoopFail:
pop {r0}

RetFalse:
mov r0,#0
b GoBack

RetTrue:
mov r0,#1

GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


ItemTable:
