.thumb
.align
.macro blh to, reg
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ HolyBloodLocks,BloodGetter+4

push {r4-r7,r14}

mov r4,r0 @r4 = character pointer
mov r5,r1 @r5 = item halfword
mov r6,r2 @r6 = rank

mov r0,#0xFF
and r5,r0

ldr r7,HolyBloodLocks

add r0,r7,r5 @table offset + item ID in r0, r0= place to load a byte from
ldrb r0,[r0] @r0=required blood for the weapon
cmp r0,#0xFF
beq RetTrue @if there is no lock on the weapon, we're good

@otherwise, get our blood
ldr r0,[r4]
ldrb r0,[r0,#4]
ldr r1,BloodGetter @takes char ID in r0, returns blood data pointer in r0 and major or minor bool in r1
mov r14,r1 
.short 0xF800
cmp r0,#0 @has no blood
beq RetFalse
cmp r1,#0 @has minor blood
beq RetFalse
ldrb r0,[r0,#0xC] @has major blood
mov r3,r0 @r3=holy blood ID


@get required blood type again
add r0,r7,r5 @table offset + item ID in r0, r0= place to load a byte from
ldrb r0,[r0] @r0=required blood for the weapon
cmp r0,r3 @if our blood is the right one, we're good
beq RetTrue @otherwise we're bad

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
BloodGetter:
@POIN BloodGetter
