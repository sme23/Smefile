.thumb
.align


.global PrepSkillForget
.type PrepSkillForget1, %function


.macro blh to, reg=r3
    ldr \reg, =\to
    mov lr, \reg
    .short 0xF800
.endm

.equ GetPrepScreenUnitListEntry,0x8095354
.equ StartScreenMenuScrollingBg,0x8086BB8
.equ StartFadeInBlack,0x8013CD0
.equ StartFadeOutBlack,0x8013CEC
.equ gBG2Buffer,0x2023ca8
.equ FillBgMap,0x8001220
.equ EnableBgSyncByIndex,0x8001fbc
.equ CpuSet,0x80d1678
.equ ClearBG0BG1,0x804e884 
.equ gLCDIOBuffer,0x3003080
.equ gPalette10Buffer,0x2022AA8 
.equ gPal_MiscUIGraphics,0x859ED70 
.equ gPaletteSyncFlag,0x0300000e
.equ Text_InitFont,0x8003C94

PrepSkillForget:
push {r4,r14}
mov r4,r0

blh ClearBG0BG1

ldr r0,=gBG2Buffer
mov r1,#0
blh FillBgMap

mov r0,#0
blh EnableBgSyncByIndex

mov r0,#1
blh EnableBgSyncByIndex

mov r0,#2
blh EnableBgSyncByIndex

ldr r0,=#0x6010000
mov r1,#0
blh FillBgMap

ldr r0,=gPaletteSyncFlag
mov r1,#1
strb r1,[r0]

blh Text_InitFont

ldr r0,=gPal_MiscUIGraphics
ldr r1,=gPalette10Buffer
mov r2,#0x20
blh CpuSet


  @FillBgMap(BG2Buffer, 0);
  @EnableBgSyncByIndex(0);
  @EnableBgSyncByIndex(1);
  @EnableBgSyncByIndex(2);
  @FillBgMap(0x6010000, 0); //clear oam tilemap
  @CpuSet(0x859ED70, ((0x020228A8 + 16 * 0x20)), 0x20); //ui palette


@start a scrolly bg
mov r0,#0
mov r1,#0
mov r2,#0xA

blh StartScreenMenuScrollingBg

@mov r0,#1
@i hate this naming structure
@blh StartFadeInBlack

mov r0,#0x1F
ldr r1,=gLCDIOBuffer
strb r0,[r1,#1]
mov r0,#8
strb r0,[r1,#4]


mov r0,r4
add r0,#0x2B
ldrb r0,[r0]
blh GetPrepScreenUnitListEntry @returns pointer to unit struct in r0

ldr r1,=#0x202BCDE
mov r2,#0
strb r2,[r1]

mov r1,r4
blh prCallRemoveSkillMenu @Arguments: r0 = Unit, r1 = Parent proc (can be 0)
@Will create the skill forgetting menu for given unit, and new skill id located at byte 0202BCDE.

pop {r4}
pop {r0}
bx r0

.ltorg
.align







