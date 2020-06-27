.data
a: .space 20

.text

li $v0,5
syscall
move $s0,$v0			# s0 = n
li $t1,0
for_begin:
bge $t1,$s0,for_end
  li $v0,12
  syscall
  sb $v0,a($t1)			# a[i] = c
addi $t1,$t1,1
j for_begin
for_end:

li $s1,1			# s1 = ok
li $t1,0			# t1 = i
addi $t2,$s0,-1			# t2 = j
while_begin:
bge $t1,$s0,while_end
blt $t2,$0,while_end
  lb $t3,a($t1)
  lb $t4,a($t2)
  beq $t3,$t4,if_end
    li $s1,0
  if_end:
addi $t1,$t1,1
addi $t2,$t2,-1
j while_begin
while_end:
li $v0,1
move $a0,$s1
syscall
li $v0,10
syscall