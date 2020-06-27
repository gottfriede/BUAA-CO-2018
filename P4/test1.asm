ori $t1,$0,1			# $9  <= 0x00000001
lui $t2,1			# $10 <= 0x00010000
ori $t3,$0,0xffff		# $11 <= 0x0000ffff
lui $t4,0xffff			# $12 <= 0xffff0000
beq $t1,$t2,end
nop
addu $s1,$t1,$t2		# $17 <= 0x00010001
addu $s2,$t2,$t4		# $18 <= 0x00000000
subu $s3,$t2,$t1		# $19 <= 0x0000ffff
subu $s4,$t1,$t3		# $20 <= 0xffff0002
ori $t6,$0,4			# $14 <= 0x00000004
sw $s3,0($t6)			# *0004 <= 0x0000ffff
sw $s4,4($t6)			# *0008 <= 0xffff0002
ori $t5,$0,8			# $13 <= 0x00000008
lw $s5,0($t5)			# $21 <= 0xffff0002
addu $t7,$t6,$0			# $15 <= 0x00000004
addu $t8,$t1,$0			# $24 <= 0x00000001
begin:
addu $t7,$t7,$t1		# $15 <= $15 +1
beq $t7,$t5,end			# if ($15 == 0x00000008) jump to end
addu $t8,$t8,$t8		# $24 <= $24 + $24
beq $0,$0,begin			# jump to begin
end:
nop
