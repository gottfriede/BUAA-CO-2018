.data
a: .space 256
bb: .space 256
enter: .asciiz "\n"
space: .asciiz " "

.macro getindex( %ans, %i, %j )
  sll %ans,%i,3
  add %ans,%ans,%j
  sll %ans,%ans,2		# ans = ( i * 8 + j ) * 4
.end_macro

.text

li $v0,5
syscall
move $s0,$v0			# s0 = n

li $t1,0			# t1 = i
for_i1_begin:
bge $t1,$s0,for_i1_end
  li $t2,0			# t2 = j
  for_j1_begin:
  bge $t2,$s0,for_j1_end
    li $v0,5
    syscall
    getindex($t0,$t1,$t2)
    sw $v0,a($t0)		# a[i][j] 
  addi $t2,$t2,1
  j for_j1_begin
  for_j1_end:
addi $t1,$t1,1
j for_i1_begin
for_i1_end:

li $t1,0			# t1 = i
for_i2_begin:
bge $t1,$s0,for_i2_end
  li $t2,0			# t2 = j
  for_j2_begin:
  bge $t2,$s0,for_j2_end
    li $v0,5
    syscall
    getindex($t0,$t1,$t2)
    sw $v0,bb($t0)		# b[i][j] 
  addi $t2,$t2,1
  j for_j2_begin
  for_j2_end:
addi $t1,$t1,1
j for_i2_begin
for_i2_end:

li $t1,0
for_i3_begin:
bge $t1,$s0,for_i3_end
  li $t2,0
  for_j3_begin:
  bge $t2,$s0,for_j3_end
    li $s1,0			# s1 = ans
    li $t3,0			# t3 = k
    for_k3_begin:
    bge $t3,$s0,for_k3_end
      getindex($t4,$t1,$t3)
      lw $t6,a($t4)		# t6 = a[i][k]
      getindex($t5,$t3,$t2)
      lw $t7,bb($t5)		# t7 = b[k][j]
      mult $t6,$t7
      mflo $t8
      add $s1,$s1,$t8
    addi $t3,$t3,1
    j for_k3_begin
    for_k3_end:
  li $v0,1
  move $a0,$s1
  syscall
  li $v0,4
  la $a0,space
  syscall
  addi $t2,$t2,1
  j for_j3_begin
  for_j3_end:
  li $v0,4
  la $a0,enter
  syscall
addi $t1,$t1,1
j for_i3_begin
for_i3_end:

li $v0,10
syscall