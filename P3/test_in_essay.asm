ori $t1,$0,1		# t1 = 0x00000001
lui $t2,1		# t2 = 0x00010000
ori $t3,$0,0xffff	# t3 = 0x0000ffff
lui $t4,0xffff		# t4 = 0xffff0000
beq $t1,$t2,end
nop
addu $s1,$t1,$t2	# s1 = 0x00010001
addu $s2,$t2,$t4	# s2 = 0x00000000
subu $s3,$t2,$t1	# s3 = 0x0000ffff
subu $s4,$t1,$t3	# s4 = 0xffff0002
ori $t6,$0,4		# t6 = 0x00000004
sw $s3,0($t6)		# 0x0000ffff
sw $s4,4($t6)		# 0xffff0002
ori $t5,$0,8		# t5 = 0x00000008
lw $s5,0($t5)		# s5 = 0xffff0002
addu $t7,$t6,$0		# t7 = 0x00000004
addu $t8,$t1,$0		# t8 = 0x00000001
begin:
addu $t7,$t7,$t1
beq $t7,$t5,end
addu $t8,$t8,$t8
beq $0,$0,begin
end:
nop