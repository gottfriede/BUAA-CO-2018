ori $sp,$0,0x00002ffc	# $29 <= 0x00002ffc
nop
nop
nop
nop
nop
ori $s0,$0,10		# $16 <= 0x0000000a
nop
nop
nop
nop
nop
ori $t1,$0,1		# $9  <= 0x00000001
nop
nop
nop
nop
nop
ori $t2,$0,8		# $10 <= 0x00000008
nop
nop
nop
nop
nop
ori $a0,$0,10		# $4  <= 0x0000000a
nop
nop
nop
nop
nop
jal ans			# $31 <= pc+4 and jump and link to ans
nop
nop
nop
nop
nop
sw $v0,0($0)		# *00000000 <= 0x00000037
nop
nop
nop
nop
nop
ori $s1,$0,55		# $17 <= 0x00000037
nop
nop
nop
nop
nop
beq $v0,$s1,end		# jump to end
nop
nop
nop
nop
nop
ans:
nop
nop
nop
nop
nop
beq $a0,$t1,if_end	# if ($4  == 0x00000001) jump to if_end
nop
nop
nop
nop
nop
subu $sp,$sp,$t2	# $29 <= $29 - 8
nop
nop
nop
nop
nop
sw $a0,0($sp)		# *($29) <= $4 
nop
nop
nop
nop
nop
sw $ra,4($sp)		# *($29+4) <= $31
nop
nop
nop
nop
nop
subu $a0,$a0,$t1	# $4  <= $4 - 1
nop
nop
nop
nop
nop
jal ans			# $31 <= pc + 4 and junp and link to ans
nop
nop
nop
nop
nop
lw $a0,0($sp)		# $4  <= *($29)
nop
nop
nop
nop
nop
lw $ra,4($sp)		# $31 <= *($29+4)
nop
nop
nop
nop
nop
addu $sp,$sp,$t2	# $29 <= $29 + 8
nop
nop
nop
nop
nop
addu $v0,$v0,$a0	# $2  <= $2 + $4
nop
nop
nop
nop
nop
jr $ra			# return
nop
nop
nop
nop
nop
if_end:
nop
nop
nop
nop
nop
ori $v0,$0,1		# $2  <= 0x00000001
nop
nop
nop
nop
nop
jr $ra			# return
nop
nop
nop
nop
nop
end:
nop
nop
nop
nop
nop
nop
