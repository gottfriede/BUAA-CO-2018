.ktext 0x4180
ori $t9,0x7f00
ori $t8,0x0009
sw $t8,0($t9)		## ctrl[3:0] = 4'b1001
eret

.text
ori $t1,0x7f00
ori $t2,0x0009
sw $t2,0($t1)		## ctrl[3:0] = 4'b1001
ori $t3,100
sw $t3,4($t1)		## preset = 100

