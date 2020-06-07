.thumb
.align

.global SwarpEffectWrapper
.type SwarpEffectWrapper, %function

.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm
.equ GoBackLoc,0x802FF77
.equ RangeMap, 0x202E4E4
.equ HideMoveRangeGraphicsWrapper, 0x08022c98 
.equ ClearMapWith, 0x080197e4 

SwarpEffectWrapper:

push {r4-r7}

@clear range map
ldr r0,=RangeMap
ldr r0,[r0]
mov r1,#0
mov r2,#0
blh ClearMapWith

@clear movement map
@ldr r0,=#0x202E4E0 @movement map
@ldr r0,[r0]
@mov r1,#0xFF
@mov r2,#0xFF
@blh ClearMapWith

@blh HideMoveRangeGraphicsWrapper

blh prSwarpCommand_Effect

pop {r4-r7}
ldr        r0,=GoBackLoc
bx        r0








