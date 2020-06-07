.thumb
.align


.global ClearSRAM_ASMC
.type ClearSRAM_ASMC, %function

ClearSRAM_ASMC:
push {r14}
mov r0,#0
ldr r1,=#0xE000000 @SRAM
ldr r2,=#0xE00FFFF @end point
StartWriteLoop:
strb r0,[r1]
cmp r1,r2
beq GoBack
add r1,#1
b StartWriteLoop

GoBack:
pop {r0}
bx r0

.ltorg
.align


.global ResetGame_ASMC
.type ResetGame_ASMC, %function

ResetGame_ASMC:
push {r14}
mov r0,#0xFF
swi #0x1 @RegisterRamReset
swi #0x0 @SoftReset
pop {r0}
bx r0

.ltorg
.align


