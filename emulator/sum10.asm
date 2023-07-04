ldh Reg0 0
ldl Reg0 0
ldh Reg1 0
ldl Reg1 1
ldh Reg2 0
ldl Reg2 0
ldh Reg3 0
ldl Reg3 10
add Reg2 Reg1
add Reg0 Reg2
st Reg0 64
cmp Reg2 Reg3
je 14
jmp 8
hlt
