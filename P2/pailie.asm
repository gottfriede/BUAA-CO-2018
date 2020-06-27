.data
a: .space 32
v: .space 32
space: .asciiz " "
enter: .asciiz "\n"

.text
li $v0,5
syscall
move $s1,$v0			# s1 = n
li $a1,0
jal dfs
li $v0,10
syscall

dfs:
bne $a1,$s1,if_end
  li $t1,0
  for_o_begin:
  bge $t1,$s1,for_o_end
    sll $t2,$t1,2
    lw $t3,a($t2)
    move $a0,$t3
    li $v0,1
    syscall
    li $v0,4
    la $a0,space
    syscall
  addi $t1,$t1,1
  j for_o_begin
  for_o_end:
  li $v0,4
  la $a0,enter
  syscall
if_end:

li $t1,1
for_begin:
bgt $t1,$s1,for_end
  sll $t2,$t1,2
  lw $t3,v($t2)
  bne $t3,$0,if_2_end
    li $t3,1
    sll $t2,$t1,2
    sw $t3,v($t2)
    sll $t2,$a1,2
    sw $t1,a($t2)
    
    addi $sp,$sp,-12
    sw $t1,0($sp)
    sw $a1,4($sp)
    sw $ra,8($sp)
    addi $a1,$a1,1
    jal dfs
    lw $a1,4($sp)
    lw $t1,0($sp)
    lw $ra,8($sp)
    addi $sp,$sp,12
    
    sll $t2,$t1,2
    sw $0,v($t2)
  if_2_end:
addi $t1,$t1,1
j for_begin
for_end:
jr $ra
