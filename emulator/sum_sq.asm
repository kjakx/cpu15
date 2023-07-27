ldh Reg0 0
ldl Reg0 0
ldh Reg1 0
ldl Reg1 0
ldh Reg3 0
ldl Reg3 1
ldh Reg4 0
ldl Reg4 20
add Reg1 Reg3
ldh Reg2 0
ldl Reg2 0
add Reg2 Reg3
add Reg0 Reg1
st Reg0 64
cmp Reg1 Reg2
je 17
jmp 11
cmp Reg1 Reg4
je 20
jmp 8
hlt