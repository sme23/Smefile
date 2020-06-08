.thumb
@draws the stat screen
.include "mss_defs.s"

page_start

draw_items_text

draw_weapon_rank_at 1, 15, Sword, 0



@draw atk
    draw_textID_at 13, 9, 0x4f3
    draw_str_bar_at 16, 9

@draw spd
draw_textID_at 13, 11, 0x4ED
draw_spd_bar_at 16, 11


draw_textID_at 21, 9, 0x4ef @def
draw_def_bar_at 24, 9

draw_textID_at 21, 11, 0x4f6 @move
draw_move_bar_at 24, 11

page_end

.ltorg

.include "Get Talkee.asm"

