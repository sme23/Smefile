.thumb
.align

@function prototypes :3

.global ShopUnitCommandUsability
.type ShopUnitCommandUsability, %function

.global ShopUnitCommandEffect
.type ShopUnitCommandEffect, %function

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ GetUnit,0x8019430 @r0 = allegiance byte


ShopUnitCommandUsability:
push {r4-r7,r14}
@ check for adjacent unit who matches an external ID
ldr r0, =#0x3004E50 @active unit ptr
ldr r0,[r0] @active unit struct
mov r4,r0 @r4 = unit struct

mov r0,r4
bl FindFirstAdjacentShopUnit

cmp r0,#0
beq Usability_RetFalse

mov r0,#1
b Usability_GoBack

Usability_RetFalse:
mov r0,#3

Usability_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


FindFirstAdjacentShopUnit: @r0 = char struct, returns first adjacent shop unit or 0
push {r4-r7,r14}
mov r4,r0

@get active unit coords
ldrb r0,[r4,#0x10] @x coord
ldrb r1,[r4,#0x11] @y coord
mov r5,r0 @r5 = x coord
mov r6,r1 @r6 = y coord

CheckSpace1:
mov r5,r0
mov r6,r1
add r0,#1

ldr		r2,=#0x202E4D8	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0,#0
beq CheckSpace2
ldr r1,=GetUnit
mov r14,r1
.short 0xF800
cmp r0,#0
beq CheckSpace2

mov r7,r0 @r7 = target unit struct
ldr r0,[r7] @target char data
ldrb r0,[r0,#4] @target char ID
ldr r2,=ShopUnitList

CheckSpace1_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq CheckSpace2
cmp r1,r0
beq CheckSpace1_RetTrue
add r2,#1
b CheckSpace1_LoopStart

CheckSpace1_RetTrue:
mov r0,r7
b FindFirstUnit_GoBack


CheckSpace2:
mov r0,r5
mov r1,r6
add r1,#1

ldr		r2,=#0x202E4D8	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0,#0
beq CheckSpace3
ldr r1,=GetUnit
mov r14,r1
.short 0xF800
cmp r0,#0
beq CheckSpace3

mov r7,r0 @r7 = target unit struct
ldr r0,[r7] @target char data
ldrb r0,[r0,#4] @target char ID
ldr r2,=ShopUnitList

CheckSpace2_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq CheckSpace3
cmp r1,r0
beq CheckSpace2_RetTrue
add r2,#1
b CheckSpace2_LoopStart

CheckSpace2_RetTrue:
mov r0,r7
b FindFirstUnit_GoBack


CheckSpace3:
mov r0,r5
mov r1,r6
sub r0,#1

ldr		r2,=#0x202E4D8	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0,#0
beq CheckSpace4
ldr r1,=GetUnit
mov r14,r1
.short 0xF800
cmp r0,#0
beq CheckSpace4

mov r7,r0 @r7 = target unit struct
ldr r0,[r7] @target char data
ldrb r0,[r0,#4] @target char ID
ldr r2,=ShopUnitList

CheckSpace3_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq CheckSpace4
cmp r1,r0
beq CheckSpace3_RetTrue
add r2,#1
b CheckSpace3_LoopStart

CheckSpace3_RetTrue:
mov r0,r7
b FindFirstUnit_GoBack


CheckSpace4:
mov r0,r5
mov r1,r6
sub r1,#1

ldr		r2,=#0x202E4D8	@Load the location in the table of tables of the map you want
ldr		r2,[r2]			@Offset of map's table of row pointers
lsl		r1,#0x2			@multiply y coordinate by 4
add		r2,r1			@so that we can get the correct row pointer
ldr		r2,[r2]			@Now we're at the beginning of the row data
add		r2,r0			@add x coordinate
ldrb	r0,[r2]			@load datum at those coordinates

cmp r0,#0
beq CheckSpaceEnd
ldr r1,=GetUnit
mov r14,r1
.short 0xF800
cmp r0,#0
beq CheckSpaceEnd

mov r7,r0 @r7 = target unit struct
ldr r0,[r7] @target char data
ldrb r0,[r0,#4] @target char ID
ldr r2,=ShopUnitList

CheckSpace4_LoopStart:
ldrb r1,[r2]
cmp r1,#0
beq CheckSpaceEnd
cmp r1,r0
beq CheckSpace4_RetTrue
add r2,#1
b CheckSpace4_LoopStart

CheckSpace4_RetTrue:
mov r0,r7
b FindFirstUnit_GoBack


CheckSpaceEnd:
mov r0,#0

FindFirstUnit_GoBack:
pop {r4-r7}
pop {r1}
bx r1

.ltorg
.align


.equ MakeShop,0x80b4240 @r0 = visiting unit, r1 = shop list(?), r2 = shop type, r3 = ???

ShopUnitCommandEffect:
push {r4-r7,r14}
ldr r0, =#0x3004E50 @active unit ptr
ldr r0,[r0] @active unit struct
mov r4,r0 @r4 = unit struct

@set up shop
mov r0,r4
ldr r1,=ShopUnitShopList
mov r2,#3
ldr r3,=MakeShop
mov r14,r3
mov r3,#0
.short 0xF800

pop {r4-r7}
pop {r0}
bx r0

