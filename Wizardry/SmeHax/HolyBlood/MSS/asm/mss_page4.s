.thumb
.include "mss_defs.s"
.set HolyBloodNameGetter, SS_BloodText+4
.set HolyBloodVoracityGetter, HolyBloodNameGetter+4

page_start

draw_textID_at 17, 9, textID=0xd4b, width=16, colour=Green



ldr r0, SS_BloodText
draw_textID_at 17, 11 @Blood label text

@pass in textid in r0
ldr r0, HolyBloodNameGetter
mov r14,r0
.short 0xF800
draw_textID_at 23, 11, colour=Grey, width=16

ldr r0, HolyBloodVoracityGetter
mov r14,r0
.short 0xF800
cmp r0,#0
beq NoIconDraw
draw_icon_at 21, 11, number=0xCB
NoIconDraw:


page_end

.align
.ltorg
.align
SS_BloodText:
@WORD SS_BloodText
@POIN HolyBloodNameGetter
@WORD SS_BiorhythmText
@POIN BiorhythmNameGetter
