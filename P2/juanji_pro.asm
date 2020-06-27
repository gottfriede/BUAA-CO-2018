.data
a: .space 400
c: .space 400
space: .asciiz " "
enter: .asciiz "\n"

.macro getindex( %ans, %i, %j )
  li %ans,10
  mult %ans,%i
  mflo %ans
  add %ans,%ans,%j
  sll %ans,%ans,2			# ans = ( i * 10 + j ) * 4
.end_macro

.text
li $v0,5
syscall
move $s1,$v0				# s1 = n1
li $v0,5
syscall
move $s2,$v0				# s2 = m1
li $v0,5
syscall
move $s3,$v0				# s3 = n2
li $v0,5
syscall
move $s4,$v0				# s4 = m2

li $t1,0
for_i1_begin:
bge $t1,$s1,for_i1_end
  li $t2,0
  for_j1_begin:
  bge $t2,$s2,for_j1_end
    li $v0,5
    syscall
    getindex($t3,$t1,$t2)
    sw $v0,a($t3)			# a[i][j]
  addi $t2,$t2,1
  j for_j1_begin
  for_j1_end:
addi $t1,$t1,1
j for_i1_begin
for_i1_end:

li $t1,0
for_i2_begin:
bge $t1,$s3,for_i2_end
  li $t2,0
  for_j2_begin:
  bge $t2,$s4,for_j2_end
    li $v0,5
    syscall
    getindex($t3,$t1,$t2)
    sw $v0,c($t3)			# c[i][j]
  addi $t2,$t2,1
  j for_j2_begin
  for_j2_end:
addi $t1,$t1,1
j for_i2_begin
for_i2_end:

sub $s5,$s1,$s3				# s5 = n1 - n2
sub $s6,$s2,$s4				# s6 = m1 - m2
li $t1,0
for_i3_begin:
bgt $t1,$s5,for_i3_end
  li $t2,0
  for_j3_begin:
  bgt $t2,$s6,for_j3_end
    
    mult $0,$0
    li $t3,0
    for_k3_begin:
    bge $t3,$s3,for_k3_end
      li $t4,0
      for_l3_begin:
      bge $t4,$s4,for_l3_end
        add $t5,$t1,$t3
        add $t6,$t2,$t4
        
        addi $sp,$sp,-8			# save lo and hi and then getindex
        mflo $t9
        sw $t9,0($sp)
        mfhi $t9
        sw $t9,4($sp)
        getindex($t7,$t5,$t6)
        lw $t9,0($sp)
        mtlo $t9
        lw $t9,4($sp)
        mthi $t9
        addi $sp,$sp,8
        
        lw $t8,a($t7)
        
        addi $sp,$sp,-8
        mflo $t9
        sw $t9,0($sp)
        mfhi $t9
        sw $t9,4($sp)
        getindex($t7,$t3,$t4)
        lw $t9,0($sp)
        mtlo $t9
        lw $t9,4($sp)
        mthi $t9
        addi $sp,$sp,8
        
        lw $t7,c($t7)
        madd $t7,$t8
      addi $t4,$t4,1
      j for_l3_begin
      for_l3_end:
    addi $t3,$t3,1
    j for_k3_begin
    for_k3_end:
    li $v0,35
    mfhi $a0
    syscall
    mflo $a0
    syscall
    li $v0,4
    la $a0,space
    syscall
    
  addi $t2,$t2,1
  j for_j3_begin
  for_j3_end:
  la $a0,enter
  li $v0,4
  syscall
addi $t1,$t1,1
j for_i3_begin
for_i3_end:
li $v0,10
syscall
