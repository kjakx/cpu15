ldh Reg0 0
ldl Reg0 1
ldh Reg1 0
ldl Reg1 1
ldh Reg2 0
ldl Reg2 1
ldh Reg3 0
ldl Reg3 0
ldh Reg4 0
ldl Reg4 1
ldh Reg5 0
ldl Reg5 2
ldh Reg6 0
ldl Reg6 20
ldh Reg7 0
ldl Reg7 0
add Reg3 Reg4
cmp Reg3 Reg4
je 20
jmp 24
st Reg2 64
cmp Reg3 Reg6
je 36
jmp 16
cmp Reg3 Reg5
je 20
mov Reg7 Reg0
add Reg7 Reg1
mov Reg2 Reg7
st Reg2 64
cmp Reg3 Reg6
je 36
add Reg3 Reg4
mov Reg0 Reg1
mov Reg1 Reg2
jmp 26
hlt