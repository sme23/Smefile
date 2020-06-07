.thumb
.align

@r8=current char data

push {r14}

mov r0,r8
ldr r0,[r0]
ldrb r0,[r0,#4]

ldr r1,HolyBloodGetter
mov r14,r1
.short 0xF800
cmp r0,#0
beq GoBack
mov r0,r1

GoBack:
pop {r1}
bx r1

.ltorg
.align

HolyBloodGetter:
