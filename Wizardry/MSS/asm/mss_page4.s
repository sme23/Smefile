.thumb
.include "mss_defs.s"

page_start

ldr r0,=DonateToCirclesTextIDLink
ldrh r0,[r0]
draw_textID_at 16, 11, width=16, colour=Green


@draw blood

@blood label
ldr r0, =SS_BloodTextLink
ldrh r0,[r0]
draw_textID_at 13, 7 @Blood label text


@blood name
blh HolyBloodNameGetter
draw_textID_at 15, 7, colour=White, width=16


@icon if major blood
blh HolyBloodVoracityGetter
cmp r0,#0
beq NoIconDraw
draw_icon_at 19, 7, number=0xCB
NoIconDraw:





@draw biorhythm

@bio label
ldr r0, =SS_BiorhythmTextLink
ldrh r0,[r0]
draw_textID_at 21, 7 @Biorhythm label text


@bio state string
ldr r0, =BiorhythmNameGetter
mov r14,r0
.short 0xF800
draw_textID_at 23, 7, colour=White, width=16

@draw fatigue

@fatigue label
ldr r0,=FatigueNameLink
ldrh r0,[r0]
draw_textID_at 21, 9 @Fatigue label text

@bar w/ MHP cap and fatigue value
blh MSSFatigueGetter
cmp r0,#0xFF
bne DrawFatigueBar

draw_number_at 25,9
b PostFatigueBar

.ltorg
.align

DrawFatigueBar:
mov r1,r8
mov r3,r0
str r0,[sp]
mov r0,r8
add r0,#0x12 @max HP
ldrb r0,[r0]
str r0,[sp,#4]
mov r0,#1 @bar ID
mov r1,#(23-11) 
mov r2,#(9-2)
blh DrawBar, r4


PostFatigueBar:

@draw laguz bar

@bar label
ldr r0,=LaguzBarNameLink
ldrh r0,[r0]
draw_textID_at 13, 9 @Bar label text

@bar w/ 30 cap and bar value
mov r0,r8
blh LaguzBarMSSGetter
cmp r0,#0xFF
bne DrawLaguzBar

draw_number_at 17,9
b PostLaguzBar

.ltorg
.align

DrawLaguzBar:
mov r1,r8
mov r3,r0
str r0,[sp]
mov r0,#30 @bar cap
str r0,[sp,#4]
mov r0,#2 @bar ID
mov r1,#(15-11) 
mov r2,#(9-2)
blh DrawBar, r4

PostLaguzBar:

page_end
