.data
a: .space 256

.macro getindex( %ans, %i, %j )
  sll %ans,%i,3
  add %ans,%ans,%j
  sll %ans,%ans,2			# ans = ( i * 8 + j ) * 4
.end_macro

.text
li $v0,5
syscall
move $s1,$v0				# s1 = n
li $v0,5
syscall
move $s2,$v0				# s2 = m
li $t1,1
for_i_begin:
bgt $t1,$s1,for_i_end
  li $t2,1
  for_j_begin:
  bgt $t2,$s2,for_j_end
    li $v0,5
    syscall
    getindex($t3,$t1,$t2)
    sw $v0,a($t3)			# a[i][j]
  add $t2,$t2,1
  j for_j_begin
  for_j_end:
add $t1,$t1,1
j for_i_begin
for_i_end:
li $v0,5
syscall
move $s3,$v0				# s3 = x0
li $v0,5
syscall
move $s4,$v0				# s4 = y0
li $v0,5
syscall
move $s5,$v0				# s5 = x1
li $v0,5
syscall
move $s6,$v0				# s6 = y1
getindex($t3,$s3,$s4)
li $t4,1
sw $t4,a($t3)				# a[x0][y0] = 1
move $a1,$s3
move $a2,$s4
li $s7,0				# s7 = ans
jal dfs
li $v0,1
move $a0,$s7
syscall
li $v0,10
syscall

dfs:
bne $a1,$s5,next
bne $a2,$s6,next
  add $s7,$s7,1
  jr $ra
next:

add $t1,$a1,1
bgt $t1,$s1,if_1_end
move $t2,$a2
getindex($t3,$t1,$t2)
lw $t4,a($t3)
bne $t4,$0,if_1_end
  li $t4,1
  sw $t4,a($t3)
  
  addi $sp,$sp,-16
  sw $ra,0($sp)
  sw $a1,4($sp)
  sw $a2,8($sp)
  sw $t3,12($sp)
  move $a1,$t1
  move $a2,$t2
  jal dfs
  lw $ra,0($sp)
  lw $a1,4($sp)
  lw $a2,8($sp)
  lw $t3,12($sp)
  addi $sp,$sp,16
  
  sw $0,a($t3)
if_1_end:

add $t1,$a1,-1
ble $t1,$0,if_2_end
move $t2,$a2
getindex($t3,$t1,$t2)
lw $t4,a($t3)
bne $t4,$0,if_2_end
  li $t4,1
  sw $t4,a($t3)
  
  addi $sp,$sp,-16
  sw $ra,0($sp)
  sw $a1,4($sp)
  sw $a2,8($sp)
  sw $t3,12($sp)
  move $a1,$t1
  move $a2,$t2
  jal dfs
  lw $ra,0($sp)
  lw $a1,4($sp)
  lw $a2,8($sp)
  lw $t3,12($sp)
  addi $sp,$sp,16
  
  sw $0,a($t3)
if_2_end:

add $t2,$a2,1
bgt $t2,$s2,if_3_end
move $t1,$a1
getindex($t3,$t1,$t2)
lw $t4,a($t3)
bne $t4,$0,if_3_end
  li $t4,1
  sw $t4,a($t3)
  
  addi $sp,$sp,-16
  sw $ra,0($sp)
  sw $a1,4($sp)
  sw $a2,8($sp)
  sw $t3,12($sp)
  move $a1,$t1
  move $a2,$t2
  jal dfs
  lw $ra,0($sp)
  lw $a1,4($sp)
  lw $a2,8($sp)
  lw $t3,12($sp)
  addi $sp,$sp,16
  
  sw $0,a($t3)
if_3_end:

add $t2,$a2,-1
ble $t2,$0,if_4_end
move $t1,$a1
getindex($t3,$t1,$t2)
lw $t4,a($t3)
bne $t4,$0,if_4_end
  li $t4,1
  sw $t4,a($t3)
  
  addi $sp,$sp,-16
  sw $ra,0($sp)
  sw $a1,4($sp)
  sw $a2,8($sp)
  sw $t3,12($sp)
  move $a1,$t1
  move $a2,$t2
  jal dfs
  lw $ra,0($sp)
  lw $a1,4($sp)
  lw $a2,8($sp)
  lw $t3,12($sp)
  addi $sp,$sp,16
  
  sw $0,a($t3)
if_4_end:

jr $ra