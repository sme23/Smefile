.thumb
.include "mss_defs.s"

page_start

ldr r0,=DonateToCirclesTextIDLink
ldrh r0,[r0]
draw_textID_at 17, 9, width=16, colour=Green


@draw blood

@blood label

@blood name

@icon if major blood


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


@draw laguz bar

@bar label

@bar w/ 30 cap and bar value


page_end

