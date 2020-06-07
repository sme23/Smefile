.thumb
.align

.global MegaquakeASMC
.type MegaquakeASMC, %function



MegaquakeASMC:
push {r4-r7,r14}

@deals damage equal to 
@[(random number from 0-20) + 10] - (target's Luck/2), floored at 10
@cannot kill, leaves target with at least 1hp 
@this ASMC is only called when the use check already succeeded via turn events


@loop through all player unit structs and apply damage to all who are deployed & alive

ldr r4,=#0x202BE4C @start of player unit structs

LoopStart:

@roll RN from 0-20


@subtract unit in r4's luck/2


@if >0, = 0


@add 10


@subtract from curHP


@if >1, = 1


@add 0x40 to r4


@restart loop
