.thumb
.include "mss_defs.s"

page_start

ldr r0,=DonateToCirclesTextIDLink
ldrh r0,[r0]
draw_textID_at 17, 9, width=16, colour=Green

page_end

