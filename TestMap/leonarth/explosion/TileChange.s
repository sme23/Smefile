.thumb
push	{lr}
ldr	r3,=#0x8019CBC	@InitMapChangeGraphics
mov	lr,r3
.short	0xF800

mov	r0,#1
ldr	r3,=#0x802E58C	@ApplyMapChangesById
mov	lr,r3
.short	0xF800

ldr	r3,=#0x8019A64	@RefreshTileMaps
mov	lr,r3
.short	0xF800
ldr	r3,=#0x802E690	@UpdateUnitsUnderRoof
mov	lr,r3
.short	0xF800
ldr	r3,=#0x8019C3C	@DrawTileGraphics
mov	lr,r3
.short	0xF800

ldr	r3,=#0x801DDC4	@StartBMXFADE
mov	lr,r3
.short	0xF800

End:
pop	{r0}
bx	r0
