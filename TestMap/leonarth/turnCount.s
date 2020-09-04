.equ rewardStartsDecreasingAt, maxAmountOfGoldReward+4
.equ amountToDecreaseGoldBy, rewardStartsDecreasingAt+4
.equ minimumGoldReward, amountToDecreaseGoldBy+4
.equ gaidenUnlockedIfUnder, minimumGoldReward+4
.thumb
push	{lr}

ldr	r0,=#0x202BCF0
ldrh	r0,[r0,#0x10]	@turn

ldr	r1,rewardStartsDecreasingAt
cmp	r1,r0
bhs	maxReward

sub	r0,r1	@turns over the limit
ldr	r2,amountToDecreaseGoldBy
mul	r0,r2	@gold to decrease
ldr	r1,maxAmountOfGoldReward
cmp	r2,r1
bhs	minReward

sub	r1,r2	@final gold
ldr	r2,minimumGoldReward
cmp	r1,r2
blo minReward

Reward:
mov	r0,r1
b	giveGold

maxReward:
ldr	r0,maxAmountOfGoldReward
b	giveGold

minReward:
ldr	r0,minimumGoldReward

giveGold:
ldr	r1,=#0x030004B8
mov	r2,#0x3
lsl	r2,#2
str	r0,[r1,r2]

ldr	r0,=#0x202BCF0
ldrh	r0,[r0,#0x10]	@turn
ldr	r1,gaidenUnlockedIfUnder
cmp	r0,r1
bhi	False

True:
mov	r0,#1
b	End

False:
mov	r0,#0

End:
ldr	r1,=#0x030004B8
mov	r2,#0xB
lsl	r2,#2
str	r0,[r1,r2]
pop	{r0}
bx	r0

.ltorg
.align

maxAmountOfGoldReward:
@WORD maxAmountOfGoldReward
@WORD rewardStartsDecreasingA
@WORD amountToDecreaseGoldBy
@WORD minimumGoldReward
@WORD gaidenUnlockedIfUnder
