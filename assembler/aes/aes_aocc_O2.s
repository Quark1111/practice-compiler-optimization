	.text
	.file	"aes.c"
	.globl	AES_init_ctx                    # -- Begin function AES_init_ctx
	.p2align	4, 0x90
	.type	AES_init_ctx,@function
AES_init_ctx:                           # @AES_init_ctx
	.cfi_startproc
# %bb.0:                                # %entry
	jmp	KeyExpansion                    # TAILCALL
.Lfunc_end0:
	.size	AES_init_ctx, .Lfunc_end0-AES_init_ctx
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function KeyExpansion
	.type	KeyExpansion,@function
KeyExpansion:                           # @KeyExpansion
	.cfi_startproc
# %bb.0:                                # %entry
	movzbl	(%rsi), %eax
	movb	%al, (%rdi)
	movzbl	1(%rsi), %eax
	movb	%al, 1(%rdi)
	movzbl	2(%rsi), %eax
	movb	%al, 2(%rdi)
	movzbl	3(%rsi), %eax
	movb	%al, 3(%rdi)
	movzbl	4(%rsi), %eax
	movb	%al, 4(%rdi)
	movzbl	5(%rsi), %eax
	movb	%al, 5(%rdi)
	movzbl	6(%rsi), %eax
	movb	%al, 6(%rdi)
	movzbl	7(%rsi), %eax
	movb	%al, 7(%rdi)
	movzbl	8(%rsi), %eax
	movb	%al, 8(%rdi)
	movzbl	9(%rsi), %eax
	movb	%al, 9(%rdi)
	movzbl	10(%rsi), %eax
	movb	%al, 10(%rdi)
	movzbl	11(%rsi), %eax
	movb	%al, 11(%rdi)
	movzbl	12(%rsi), %eax
	movb	%al, 12(%rdi)
	movzbl	13(%rsi), %eax
	movb	%al, 13(%rdi)
	movzbl	14(%rsi), %eax
	movb	%al, 14(%rdi)
	movzbl	15(%rsi), %eax
	movb	%al, 15(%rdi)
	movl	$4, %eax
	leaq	sbox(%rip), %rcx
	leaq	Rcon(%rip), %rdx
	jmp	.LBB1_1
	.p2align	4, 0x90
.LBB1_3:                                # %if.end
                                        #   in Loop: Header=BB1_1 Depth=1
	xorb	-16(%rdi,%rax,4), %r10b
	movb	%r10b, (%rdi,%rax,4)
	xorb	-15(%rdi,%rax,4), %r9b
	movb	%r9b, 1(%rdi,%rax,4)
	xorb	-14(%rdi,%rax,4), %r8b
	movb	%r8b, 2(%rdi,%rax,4)
	xorb	-13(%rdi,%rax,4), %sil
	movb	%sil, 3(%rdi,%rax,4)
	incq	%rax
	cmpq	$44, %rax
	je	.LBB1_4
.LBB1_1:                                # %for.body31
                                        # =>This Inner Loop Header: Depth=1
	movzbl	-4(%rdi,%rax,4), %r10d
	movzbl	-3(%rdi,%rax,4), %r9d
	movzbl	-2(%rdi,%rax,4), %r8d
	movzbl	-1(%rdi,%rax,4), %esi
	testb	$3, %al
	jne	.LBB1_3
# %bb.2:                                # %if.then
                                        #   in Loop: Header=BB1_1 Depth=1
	movzbl	%r10b, %r10d
	movzbl	%r9b, %r11d
	movzbl	%r8b, %r8d
	movzbl	%sil, %esi
	movzbl	(%r8,%rcx), %r9d
	movzbl	(%rsi,%rcx), %r8d
	movzbl	(%r10,%rcx), %esi
	movl	%eax, %r10d
	shrl	$2, %r10d
	movzbl	(%r10,%rdx), %r10d
	xorb	(%r11,%rcx), %r10b
	jmp	.LBB1_3
.LBB1_4:                                # %for.end129
	retq
.Lfunc_end1:
	.size	KeyExpansion, .Lfunc_end1-KeyExpansion
	.cfi_endproc
                                        # -- End function
	.globl	AES_init_ctx_iv                 # -- Begin function AES_init_ctx_iv
	.p2align	4, 0x90
	.type	AES_init_ctx_iv,@function
AES_init_ctx_iv:                        # @AES_init_ctx_iv
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	pushq	%rax
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdx, %rbx
	movq	%rdi, %r14
	callq	KeyExpansion
	movups	(%rbx), %xmm0
	movups	%xmm0, 176(%r14)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	AES_init_ctx_iv, .Lfunc_end2-AES_init_ctx_iv
	.cfi_endproc
                                        # -- End function
	.globl	AES_ctx_set_iv                  # -- Begin function AES_ctx_set_iv
	.p2align	4, 0x90
	.type	AES_ctx_set_iv,@function
AES_ctx_set_iv:                         # @AES_ctx_set_iv
	.cfi_startproc
# %bb.0:                                # %entry
	movups	(%rsi), %xmm0
	movups	%xmm0, 176(%rdi)
	retq
.Lfunc_end3:
	.size	AES_ctx_set_iv, .Lfunc_end3-AES_ctx_set_iv
	.cfi_endproc
                                        # -- End function
	.globl	AES_ECB_encrypt                 # -- Begin function AES_ECB_encrypt
	.p2align	4, 0x90
	.type	AES_ECB_encrypt,@function
AES_ECB_encrypt:                        # @AES_ECB_encrypt
	.cfi_startproc
# %bb.0:                                # %entry
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rax, %rsi
	jmp	Cipher                          # TAILCALL
.Lfunc_end4:
	.size	AES_ECB_encrypt, .Lfunc_end4-AES_ECB_encrypt
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function Cipher
.LCPI5_0:
	.byte	27                              # 0x1b
	.byte	27                              # 0x1b
	.byte	27                              # 0x1b
	.byte	27                              # 0x1b
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI5_1:
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.text
	.p2align	4, 0x90
	.type	Cipher,@function
Cipher:                                 # @Cipher
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movzbl	(%rdi), %r9d
	movzbl	1(%rdi), %ecx
	xorb	(%rsi), %r9b
	movb	%r9b, (%rdi)
	xorb	1(%rsi), %cl
	movb	%cl, 1(%rdi)
	movzbl	2(%rdi), %eax
	xorb	2(%rsi), %al
	movb	%al, -13(%rsp)                  # 1-byte Spill
	movb	%al, 2(%rdi)
	movzbl	3(%rdi), %eax
	xorb	3(%rsi), %al
	movb	%al, -18(%rsp)                  # 1-byte Spill
	movb	%al, 3(%rdi)
	movzbl	4(%rdi), %r14d
	xorb	4(%rsi), %r14b
	movb	%r14b, 4(%rdi)
	movzbl	5(%rdi), %r15d
	xorb	5(%rsi), %r15b
	movb	%r15b, 5(%rdi)
	movzbl	6(%rdi), %eax
	xorb	6(%rsi), %al
	movb	%al, -15(%rsp)                  # 1-byte Spill
	movb	%al, 6(%rdi)
	movzbl	7(%rdi), %eax
	xorb	7(%rsi), %al
	movb	%al, -14(%rsp)                  # 1-byte Spill
	movb	%al, 7(%rdi)
	movzbl	8(%rdi), %edx
	xorb	8(%rsi), %dl
	movb	%dl, 8(%rdi)
	movzbl	9(%rdi), %r13d
	xorb	9(%rsi), %r13b
	movb	%r13b, 9(%rdi)
	movzbl	10(%rdi), %r12d
	xorb	10(%rsi), %r12b
	movb	%r12b, 10(%rdi)
	movzbl	11(%rdi), %eax
	xorb	11(%rsi), %al
	movb	%al, -16(%rsp)                  # 1-byte Spill
	movb	%al, 11(%rdi)
	movzbl	12(%rdi), %r10d
	xorb	12(%rsi), %r10b
	movb	%r10b, 12(%rdi)
	movzbl	13(%rdi), %ebp
	xorb	13(%rsi), %bpl
	movb	%bpl, 13(%rdi)
	movzbl	14(%rdi), %r8d
	xorb	14(%rsi), %r8b
	movb	%r8b, 14(%rdi)
	movzbl	15(%rdi), %eax
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	xorb	15(%rsi), %al
	movb	%al, -17(%rsp)                  # 1-byte Spill
	movl	%ecx, %esi
	movl	$31, %eax
	pxor	%xmm0, %xmm0
	movdqa	.LCPI5_0(%rip), %xmm1           # xmm1 = <27,27,27,27,u,u,u,u,u,u,u,u,u,u,u,u>
	movdqa	.LCPI5_1(%rip), %xmm2           # xmm2 = [65535,0,65535,0,65535,0,65535,0]
	.p2align	4, 0x90
.LBB5_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movzbl	%r9b, %ecx
	leaq	sbox(%rip), %r9
	movzbl	(%rcx,%r9), %ebx
	movb	%bl, (%rdi)
	movzbl	%r14b, %ecx
	movzbl	(%rcx,%r9), %ecx
	movb	%cl, -12(%rsp)                  # 1-byte Spill
	movb	%cl, 4(%rdi)
	movzbl	%dl, %ecx
	movzbl	(%rcx,%r9), %ecx
	movb	%cl, -11(%rsp)                  # 1-byte Spill
	movb	%cl, 8(%rdi)
	movzbl	%r10b, %ecx
	movzbl	(%rcx,%r9), %ecx
	movb	%cl, -10(%rsp)                  # 1-byte Spill
	movb	%cl, 12(%rdi)
	movzbl	%sil, %ecx
	movzbl	(%rcx,%r9), %ecx
	movb	%cl, -9(%rsp)                   # 1-byte Spill
	movzbl	%r15b, %ecx
	movzbl	(%rcx,%r9), %edx
	movzbl	%r13b, %ecx
	movzbl	(%rcx,%r9), %r15d
	movzbl	%bpl, %ecx
	movzbl	(%rcx,%r9), %ebp
	movzbl	-13(%rsp), %ecx                 # 1-byte Folded Reload
	movzbl	(%rcx,%r9), %r13d
	movzbl	-15(%rsp), %ecx                 # 1-byte Folded Reload
	movzbl	(%rcx,%r9), %r11d
	movzbl	%r12b, %ecx
	movzbl	(%rcx,%r9), %r10d
	movzbl	%r8b, %ecx
	movzbl	(%rcx,%r9), %esi
	movzbl	-18(%rsp), %ecx                 # 1-byte Folded Reload
	movzbl	(%rcx,%r9), %ecx
	movzbl	-14(%rsp), %r8d                 # 1-byte Folded Reload
	movzbl	(%r8,%r9), %r12d
	movzbl	-16(%rsp), %r8d                 # 1-byte Folded Reload
	movzbl	(%r8,%r9), %r8d
	movzbl	-17(%rsp), %r14d                # 1-byte Folded Reload
	movzbl	(%r14,%r9), %r14d
	movzbl	-9(%rsp), %r9d                  # 1-byte Folded Reload
	movb	%dl, 1(%rdi)
	movb	%r15b, 5(%rdi)
	movb	%bpl, 9(%rdi)
	movb	%r9b, 13(%rdi)
	movb	%r10b, 2(%rdi)
	movb	%r13b, 10(%rdi)
	movb	%sil, 6(%rdi)
	movb	%r11b, -18(%rsp)                # 1-byte Spill
	movb	%r11b, 14(%rdi)
	movb	%r14b, 3(%rdi)
	movb	%r8b, 15(%rdi)
	movb	%r12b, 11(%rdi)
	movb	%cl, 7(%rdi)
	cmpq	$175, %rax
	je	.LBB5_3
# %bb.2:                                # %vector.body
                                        #   in Loop: Header=BB5_1 Depth=1
	movzbl	(%rdi), %ecx
	movzbl	8(%rdi), %edx
	movzbl	12(%rdi), %esi
	shll	$8, %esi
	orl	%edx, %esi
	movzbl	4(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movd	%edx, %xmm3
	pinsrw	$1, %esi, %xmm3
	movzbl	1(%rdi), %ecx
	movzbl	9(%rdi), %edx
	movzbl	13(%rdi), %esi
	shll	$8, %esi
	orl	%edx, %esi
	movzbl	5(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movd	%edx, %xmm4
	pinsrw	$1, %esi, %xmm4
	movzbl	2(%rdi), %ecx
	movzbl	10(%rdi), %edx
	movzbl	14(%rdi), %esi
	shll	$8, %esi
	orl	%edx, %esi
	movzbl	6(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movd	%edx, %xmm7
	pinsrw	$1, %esi, %xmm7
	movzbl	3(%rdi), %ecx
	movzbl	11(%rdi), %edx
	movzbl	15(%rdi), %esi
	shll	$8, %esi
	orl	%edx, %esi
	movzbl	7(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movd	%edx, %xmm6
	pinsrw	$1, %esi, %xmm6
	movdqa	%xmm6, %xmm5
	pxor	%xmm7, %xmm5
	movdqa	%xmm5, %xmm8
	pxor	%xmm9, %xmm9
	pcmpgtb	%xmm5, %xmm9
	paddb	%xmm5, %xmm5
	pxor	%xmm7, %xmm5
	pxor	%xmm4, %xmm7
	pxor	%xmm10, %xmm10
	pcmpgtb	%xmm7, %xmm10
	paddb	%xmm7, %xmm7
	pxor	%xmm4, %xmm7
	pxor	%xmm3, %xmm4
	pxor	%xmm4, %xmm8
	pxor	%xmm11, %xmm11
	pcmpgtb	%xmm4, %xmm11
	paddb	%xmm4, %xmm4
	pand	%xmm1, %xmm11
	pxor	%xmm3, %xmm4
	pxor	%xmm11, %xmm4
	pxor	%xmm8, %xmm4
	pand	%xmm1, %xmm10
	pxor	%xmm10, %xmm7
	pxor	%xmm8, %xmm7
	punpckldq	%xmm7, %xmm4            # xmm4 = xmm4[0],xmm7[0],xmm4[1],xmm7[1]
	pand	%xmm1, %xmm9
	pxor	%xmm9, %xmm5
	pxor	%xmm8, %xmm5
	pxor	%xmm6, %xmm3
	pxor	%xmm7, %xmm7
	pcmpgtb	%xmm3, %xmm7
	paddb	%xmm3, %xmm3
	pand	%xmm1, %xmm7
	pxor	%xmm6, %xmm3
	pxor	%xmm7, %xmm3
	pxor	%xmm8, %xmm3
	punpckldq	%xmm3, %xmm5            # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1]
	punpcklbw	%xmm0, %xmm5            # xmm5 = xmm5[0],xmm0[0],xmm5[1],xmm0[1],xmm5[2],xmm0[2],xmm5[3],xmm0[3],xmm5[4],xmm0[4],xmm5[5],xmm0[5],xmm5[6],xmm0[6],xmm5[7],xmm0[7]
	pshufd	$215, %xmm5, %xmm3              # xmm3 = xmm5[3,1,1,3]
	pshuflw	$36, %xmm3, %xmm3               # xmm3 = xmm3[0,1,2,0,4,5,6,7]
	pshufhw	$212, %xmm3, %xmm3              # xmm3 = xmm3[0,1,2,3,4,5,5,7]
	pshufd	$40, %xmm5, %xmm5               # xmm5 = xmm5[0,2,2,0]
	pshuflw	$132, %xmm5, %xmm5              # xmm5 = xmm5[0,1,0,2,4,5,6,7]
	pshufhw	$116, %xmm5, %xmm5              # xmm5 = xmm5[0,1,2,3,4,5,7,5]
	packuswb	%xmm3, %xmm5
	movdqa	%xmm2, %xmm3
	pandn	%xmm5, %xmm3
	punpcklbw	%xmm0, %xmm4            # xmm4 = xmm4[0],xmm0[0],xmm4[1],xmm0[1],xmm4[2],xmm0[2],xmm4[3],xmm0[3],xmm4[4],xmm0[4],xmm4[5],xmm0[5],xmm4[6],xmm0[6],xmm4[7],xmm0[7]
	pshufd	$215, %xmm4, %xmm5              # xmm5 = xmm4[3,1,1,3]
	pshuflw	$226, %xmm5, %xmm5              # xmm5 = xmm5[2,0,2,3,4,5,6,7]
	pshufhw	$237, %xmm5, %xmm5              # xmm5 = xmm5[0,1,2,3,5,7,6,7]
	pshufd	$40, %xmm4, %xmm4               # xmm4 = xmm4[0,2,2,0]
	pshuflw	$232, %xmm4, %xmm4              # xmm4 = xmm4[0,2,2,3,4,5,6,7]
	pshufhw	$231, %xmm4, %xmm4              # xmm4 = xmm4[0,1,2,3,7,5,6,7]
	packuswb	%xmm5, %xmm4
	pand	%xmm2, %xmm4
	por	%xmm3, %xmm4
	movdqu	%xmm4, (%rdi)
	movzbl	(%rdi), %r9d
	movzbl	1(%rdi), %esi
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	xorb	-15(%rcx,%rax), %r9b
	movb	%r9b, (%rdi)
	xorb	-14(%rcx,%rax), %sil
	movb	%sil, 1(%rdi)
	movzbl	2(%rdi), %edx
	xorb	-13(%rcx,%rax), %dl
	movb	%dl, -13(%rsp)                  # 1-byte Spill
	movb	%dl, 2(%rdi)
	movzbl	3(%rdi), %edx
	xorb	-12(%rcx,%rax), %dl
	movb	%dl, -18(%rsp)                  # 1-byte Spill
	movb	%dl, 3(%rdi)
	movzbl	4(%rdi), %r14d
	xorb	-11(%rcx,%rax), %r14b
	movb	%r14b, 4(%rdi)
	movzbl	5(%rdi), %r15d
	xorb	-10(%rcx,%rax), %r15b
	movb	%r15b, 5(%rdi)
	movzbl	6(%rdi), %edx
	xorb	-9(%rcx,%rax), %dl
	movb	%dl, -15(%rsp)                  # 1-byte Spill
	movb	%dl, 6(%rdi)
	movzbl	7(%rdi), %edx
	xorb	-8(%rcx,%rax), %dl
	movb	%dl, -14(%rsp)                  # 1-byte Spill
	movb	%dl, 7(%rdi)
	movzbl	8(%rdi), %edx
	xorb	-7(%rcx,%rax), %dl
	movb	%dl, 8(%rdi)
	movzbl	9(%rdi), %r13d
	xorb	-6(%rcx,%rax), %r13b
	movb	%r13b, 9(%rdi)
	movzbl	10(%rdi), %r12d
	xorb	-5(%rcx,%rax), %r12b
	movb	%r12b, 10(%rdi)
	movzbl	11(%rdi), %r8d
	xorb	-4(%rcx,%rax), %r8b
	movb	%r8b, -16(%rsp)                 # 1-byte Spill
	movb	%r8b, 11(%rdi)
	movzbl	12(%rdi), %r10d
	xorb	-3(%rcx,%rax), %r10b
	movb	%r10b, 12(%rdi)
	movzbl	13(%rdi), %ebp
	xorb	-2(%rcx,%rax), %bpl
	movb	%bpl, 13(%rdi)
	movzbl	14(%rdi), %r8d
	xorb	-1(%rcx,%rax), %r8b
	movb	%r8b, 14(%rdi)
	movzbl	15(%rdi), %r11d
	xorb	(%rcx,%rax), %r11b
	movb	%r11b, -17(%rsp)                # 1-byte Spill
	movb	%r11b, 15(%rdi)
	addq	$16, %rax
	jmp	.LBB5_1
.LBB5_3:                                # %for.body6.i40
	movq	-8(%rsp), %rax                  # 8-byte Reload
	xorb	160(%rax), %bl
	movb	%bl, (%rdi)
	xorb	161(%rax), %dl
	movb	%dl, 1(%rdi)
	xorb	162(%rax), %r10b
	movb	%r10b, 2(%rdi)
	xorb	163(%rax), %r14b
	movb	%r14b, 3(%rdi)
	movzbl	-12(%rsp), %edx                 # 1-byte Folded Reload
	xorb	164(%rax), %dl
	movb	%dl, 4(%rdi)
	xorb	165(%rax), %r15b
	movb	%r15b, 5(%rdi)
	xorb	166(%rax), %sil
	movb	%sil, 6(%rdi)
	xorb	167(%rax), %cl
	movb	%cl, 7(%rdi)
	movzbl	-11(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	168(%rax), %cl
	movb	%cl, 8(%rdi)
	xorb	169(%rax), %bpl
	movb	%bpl, 9(%rdi)
	xorb	170(%rax), %r13b
	movb	%r13b, 10(%rdi)
	xorb	171(%rax), %r12b
	movb	%r12b, 11(%rdi)
	movzbl	-10(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	172(%rax), %cl
	movb	%cl, 12(%rdi)
	xorb	173(%rax), %r9b
	movb	%r9b, 13(%rdi)
	movzbl	-18(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	174(%rax), %cl
	movb	%cl, 14(%rdi)
	xorb	175(%rax), %r8b
	movb	%r8b, 15(%rdi)
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	Cipher, .Lfunc_end5-Cipher
	.cfi_endproc
                                        # -- End function
	.globl	AES_ECB_decrypt                 # -- Begin function AES_ECB_decrypt
	.p2align	4, 0x90
	.type	AES_ECB_decrypt,@function
AES_ECB_decrypt:                        # @AES_ECB_decrypt
	.cfi_startproc
# %bb.0:                                # %entry
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rax, %rsi
	jmp	InvCipher                       # TAILCALL
.Lfunc_end6:
	.size	AES_ECB_decrypt, .Lfunc_end6-AES_ECB_decrypt
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0                          # -- Begin function InvCipher
.LCPI7_0:
	.byte	27                              # 0x1b
	.byte	27                              # 0x1b
	.byte	27                              # 0x1b
	.byte	27                              # 0x1b
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI7_1:
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.short	65535                           # 0xffff
	.short	0                               # 0x0
	.text
	.p2align	4, 0x90
	.type	InvCipher,@function
InvCipher:                              # @InvCipher
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movzbl	(%rdi), %r14d
	movzbl	1(%rdi), %eax
	xorb	160(%rsi), %r14b
	movb	%r14b, (%rdi)
	xorb	161(%rsi), %al
	movb	%al, -20(%rsp)                  # 1-byte Spill
	movb	%al, 1(%rdi)
	movzbl	2(%rdi), %edx
	xorb	162(%rsi), %dl
	movb	%dl, 2(%rdi)
	movzbl	3(%rdi), %eax
	xorb	163(%rsi), %al
	movb	%al, -19(%rsp)                  # 1-byte Spill
	movb	%al, 3(%rdi)
	movzbl	4(%rdi), %r8d
	xorb	164(%rsi), %r8b
	movb	%r8b, 4(%rdi)
	movzbl	5(%rdi), %eax
	xorb	165(%rsi), %al
	movb	%al, -23(%rsp)                  # 1-byte Spill
	movb	%al, 5(%rdi)
	movzbl	6(%rdi), %eax
	xorb	166(%rsi), %al
	movb	%al, -21(%rsp)                  # 1-byte Spill
	movb	%al, 6(%rdi)
	movzbl	7(%rdi), %eax
	xorb	167(%rsi), %al
	movb	%al, -22(%rsp)                  # 1-byte Spill
	movb	%al, 7(%rdi)
	movzbl	8(%rdi), %r9d
	xorb	168(%rsi), %r9b
	movb	%r9b, 8(%rdi)
	movzbl	9(%rdi), %r15d
	xorb	169(%rsi), %r15b
	movb	%r15b, 9(%rdi)
	movzbl	10(%rdi), %r13d
	xorb	170(%rsi), %r13b
	movb	%r13b, 10(%rdi)
	movzbl	11(%rdi), %eax
	xorb	171(%rsi), %al
	movb	%al, -24(%rsp)                  # 1-byte Spill
	movb	%al, 11(%rdi)
	movzbl	12(%rdi), %r11d
	xorb	172(%rsi), %r11b
	movb	%r11b, 12(%rdi)
	movzbl	13(%rdi), %r10d
	xorb	173(%rsi), %r10b
	movb	%r10b, 13(%rdi)
	movzbl	14(%rdi), %ecx
	xorb	174(%rsi), %cl
	movb	%cl, 14(%rdi)
	movzbl	15(%rdi), %r12d
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	xorb	175(%rsi), %r12b
	movl	%edx, %esi
	movl	$144, %eax
	movq	%rax, -16(%rsp)                 # 8-byte Spill
	pxor	%xmm0, %xmm0
	movdqa	.LCPI7_0(%rip), %xmm1           # xmm1 = <27,27,27,27,u,u,u,u,u,u,u,u,u,u,u,u>
	movdqa	.LCPI7_1(%rip), %xmm2           # xmm2 = [65535,0,65535,0,65535,0,65535,0]
	.p2align	4, 0x90
.LBB7_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movzbl	%r14b, %eax
	leaq	rsbox(%rip), %rdx
	movzbl	(%rax,%rdx), %ebx
	movb	%bl, (%rdi)
	movzbl	%r8b, %eax
	movzbl	(%rax,%rdx), %eax
	movb	%al, -18(%rsp)                  # 1-byte Spill
	movb	%al, 4(%rdi)
	movzbl	%r9b, %eax
	movzbl	(%rax,%rdx), %eax
	movb	%al, -17(%rsp)                  # 1-byte Spill
	movb	%al, 8(%rdi)
	movzbl	%r11b, %eax
	movzbl	(%rax,%rdx), %eax
	movb	%al, 12(%rdi)
	movzbl	%r10b, %eax
	movzbl	(%rax,%rdx), %ebp
	movb	%bpl, 1(%rdi)
	movzbl	-20(%rsp), %eax                 # 1-byte Folded Reload
	movzbl	(%rax,%rdx), %r10d
	movb	%r10b, 5(%rdi)
	movzbl	-23(%rsp), %eax                 # 1-byte Folded Reload
	movzbl	(%rax,%rdx), %r14d
	movb	%r14b, 9(%rdi)
	movzbl	%r15b, %eax
	movzbl	(%rax,%rdx), %eax
	movb	%al, 13(%rdi)
	movzbl	%r13b, %eax
	movzbl	(%rax,%rdx), %r8d
	movb	%r8b, 2(%rdi)
	movzbl	%cl, %eax
	movzbl	(%rax,%rdx), %r13d
	movb	%r13b, 6(%rdi)
	movzbl	%sil, %eax
	movzbl	(%rax,%rdx), %r11d
	movb	%r11b, 10(%rdi)
	movzbl	-21(%rsp), %eax                 # 1-byte Folded Reload
	movzbl	(%rax,%rdx), %r9d
	movb	%r9b, 14(%rdi)
	movzbl	-22(%rsp), %eax                 # 1-byte Folded Reload
	movzbl	(%rax,%rdx), %esi
	movb	%sil, 3(%rdi)
	movzbl	-24(%rsp), %eax                 # 1-byte Folded Reload
	movzbl	(%rax,%rdx), %eax
	movb	%al, 7(%rdi)
	movzbl	%r12b, %r15d
	movzbl	(%r15,%rdx), %r12d
	movb	%r12b, 11(%rdi)
	movzbl	-19(%rsp), %r15d                # 1-byte Folded Reload
	movzbl	(%r15,%rdx), %r15d
	movb	%r15b, 15(%rdi)
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	movq	-16(%rsp), %rcx                 # 8-byte Reload
	xorb	(%rdx,%rcx), %bl
	movb	%bl, (%rdi)
	xorb	1(%rdx,%rcx), %bpl
	movb	%bpl, 1(%rdi)
	xorb	2(%rdx,%rcx), %r8b
	movb	%r8b, 2(%rdi)
	xorb	3(%rdx,%rcx), %sil
	movb	%sil, 3(%rdi)
	movzbl	-18(%rsp), %esi                 # 1-byte Folded Reload
	xorb	4(%rdx,%rcx), %sil
	movb	%sil, 4(%rdi)
	xorb	5(%rdx,%rcx), %r10b
	movb	%r10b, 5(%rdi)
	xorb	6(%rdx,%rcx), %r13b
	movb	%r13b, 6(%rdi)
	xorb	7(%rdx,%rcx), %al
	movb	%al, 7(%rdi)
	movzbl	-17(%rsp), %eax                 # 1-byte Folded Reload
	xorb	8(%rdx,%rcx), %al
	movb	%al, 8(%rdi)
	xorb	9(%rdx,%rcx), %r14b
	movb	%r14b, 9(%rdi)
	xorb	10(%rdx,%rcx), %r11b
	movb	%r11b, 10(%rdi)
	xorb	11(%rdx,%rcx), %r12b
	movb	%r12b, 11(%rdi)
	movzbl	12(%rdx,%rcx), %eax
	xorb	%al, 12(%rdi)
	movzbl	13(%rdx,%rcx), %eax
	xorb	%al, 13(%rdi)
	xorb	14(%rdx,%rcx), %r9b
	movb	%r9b, 14(%rdi)
	xorb	15(%rdx,%rcx), %r15b
	movb	%r15b, 15(%rdi)
	testq	%rcx, %rcx
	je	.LBB7_3
# %bb.2:                                # %vector.body
                                        #   in Loop: Header=BB7_1 Depth=1
	movzbl	(%rdi), %eax
	movzbl	8(%rdi), %ecx
	movzbl	12(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	4(%rdi), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movd	%ecx, %xmm5
	pinsrw	$1, %edx, %xmm5
	movzbl	1(%rdi), %eax
	movzbl	9(%rdi), %ecx
	movzbl	13(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	5(%rdi), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movd	%ecx, %xmm3
	pinsrw	$1, %edx, %xmm3
	movzbl	2(%rdi), %eax
	movzbl	10(%rdi), %ecx
	movzbl	14(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	6(%rdi), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movd	%ecx, %xmm6
	pinsrw	$1, %edx, %xmm6
	movzbl	3(%rdi), %eax
	movzbl	11(%rdi), %ecx
	movzbl	15(%rdi), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	7(%rdi), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movd	%ecx, %xmm7
	pinsrw	$1, %edx, %xmm7
	pxor	%xmm4, %xmm4
	pcmpgtb	%xmm5, %xmm4
	movdqa	%xmm3, %xmm8
	pxor	%xmm9, %xmm9
	pcmpgtb	%xmm3, %xmm9
	movdqa	%xmm6, %xmm10
	pxor	%xmm3, %xmm10
	movdqa	%xmm6, %xmm11
	pxor	%xmm5, %xmm11
	pxor	%xmm5, %xmm3
	paddb	%xmm5, %xmm5
	pand	%xmm1, %xmm4
	pxor	%xmm5, %xmm4
	movdqa	%xmm4, %xmm13
	paddb	%xmm4, %xmm13
	pxor	%xmm14, %xmm14
	pcmpgtb	%xmm5, %xmm14
	pand	%xmm1, %xmm14
	pxor	%xmm13, %xmm14
	pxor	%xmm12, %xmm12
	pcmpgtb	%xmm13, %xmm12
	paddb	%xmm8, %xmm8
	pand	%xmm1, %xmm9
	pxor	%xmm8, %xmm9
	pxor	%xmm5, %xmm5
	pcmpgtb	%xmm6, %xmm5
	pxor	%xmm7, %xmm10
	pxor	%xmm4, %xmm10
	pxor	%xmm6, %xmm4
	paddb	%xmm6, %xmm6
	pand	%xmm1, %xmm5
	pxor	%xmm6, %xmm5
	movdqa	%xmm5, %xmm13
	pxor	%xmm15, %xmm15
	pcmpgtb	%xmm7, %xmm15
	pxor	%xmm7, %xmm11
	pxor	%xmm9, %xmm11
	pxor	%xmm5, %xmm11
	pxor	%xmm7, %xmm5
	paddb	%xmm7, %xmm7
	pand	%xmm1, %xmm15
	pxor	%xmm7, %xmm15
	pxor	%xmm9, %xmm10
	pxor	%xmm14, %xmm10
	pxor	%xmm15, %xmm3
	pxor	%xmm3, %xmm5
	pxor	%xmm14, %xmm5
	paddb	%xmm14, %xmm14
	pand	%xmm1, %xmm12
	pxor	%xmm14, %xmm12
	paddb	%xmm9, %xmm9
	pxor	%xmm14, %xmm14
	pcmpgtb	%xmm8, %xmm14
	pand	%xmm1, %xmm14
	pxor	%xmm9, %xmm14
	pxor	%xmm8, %xmm8
	pcmpgtb	%xmm9, %xmm8
	pxor	%xmm3, %xmm4
	pxor	%xmm14, %xmm11
	pxor	%xmm14, %xmm4
	paddb	%xmm14, %xmm14
	pand	%xmm1, %xmm8
	pxor	%xmm14, %xmm8
	paddb	%xmm13, %xmm13
	pxor	%xmm3, %xmm3
	pcmpgtb	%xmm6, %xmm3
	pand	%xmm1, %xmm3
	pxor	%xmm13, %xmm3
	pxor	%xmm6, %xmm6
	pcmpgtb	%xmm13, %xmm6
	pxor	%xmm3, %xmm10
	pxor	%xmm3, %xmm5
	paddb	%xmm3, %xmm3
	pand	%xmm1, %xmm6
	pxor	%xmm3, %xmm6
	pxor	%xmm8, %xmm6
	paddb	%xmm15, %xmm15
	pxor	%xmm3, %xmm3
	pcmpgtb	%xmm7, %xmm3
	pand	%xmm1, %xmm3
	pxor	%xmm15, %xmm3
	pxor	%xmm7, %xmm7
	pcmpgtb	%xmm15, %xmm7
	pxor	%xmm3, %xmm11
	pxor	%xmm3, %xmm4
	paddb	%xmm3, %xmm3
	pand	%xmm1, %xmm7
	pxor	%xmm3, %xmm7
	pxor	%xmm12, %xmm10
	pxor	%xmm6, %xmm10
	pxor	%xmm7, %xmm10
	pxor	%xmm12, %xmm11
	pxor	%xmm6, %xmm11
	pxor	%xmm7, %xmm11
	punpckldq	%xmm11, %xmm10          # xmm10 = xmm10[0],xmm11[0],xmm10[1],xmm11[1]
	pxor	%xmm12, %xmm5
	pxor	%xmm12, %xmm4
	pxor	%xmm6, %xmm5
	pxor	%xmm6, %xmm4
	pxor	%xmm7, %xmm5
	pxor	%xmm7, %xmm4
	punpckldq	%xmm4, %xmm5            # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
	punpcklbw	%xmm0, %xmm5            # xmm5 = xmm5[0],xmm0[0],xmm5[1],xmm0[1],xmm5[2],xmm0[2],xmm5[3],xmm0[3],xmm5[4],xmm0[4],xmm5[5],xmm0[5],xmm5[6],xmm0[6],xmm5[7],xmm0[7]
	pshufd	$215, %xmm5, %xmm3              # xmm3 = xmm5[3,1,1,3]
	pshuflw	$36, %xmm3, %xmm3               # xmm3 = xmm3[0,1,2,0,4,5,6,7]
	pshufhw	$212, %xmm3, %xmm3              # xmm3 = xmm3[0,1,2,3,4,5,5,7]
	pshufd	$40, %xmm5, %xmm4               # xmm4 = xmm5[0,2,2,0]
	pshuflw	$132, %xmm4, %xmm4              # xmm4 = xmm4[0,1,0,2,4,5,6,7]
	pshufhw	$116, %xmm4, %xmm4              # xmm4 = xmm4[0,1,2,3,4,5,7,5]
	packuswb	%xmm3, %xmm4
	movdqa	%xmm2, %xmm3
	pandn	%xmm4, %xmm3
	punpcklbw	%xmm0, %xmm10           # xmm10 = xmm10[0],xmm0[0],xmm10[1],xmm0[1],xmm10[2],xmm0[2],xmm10[3],xmm0[3],xmm10[4],xmm0[4],xmm10[5],xmm0[5],xmm10[6],xmm0[6],xmm10[7],xmm0[7]
	pshufd	$215, %xmm10, %xmm4             # xmm4 = xmm10[3,1,1,3]
	pshuflw	$226, %xmm4, %xmm4              # xmm4 = xmm4[2,0,2,3,4,5,6,7]
	pshufhw	$237, %xmm4, %xmm4              # xmm4 = xmm4[0,1,2,3,5,7,6,7]
	pshufd	$40, %xmm10, %xmm5              # xmm5 = xmm10[0,2,2,0]
	pshuflw	$232, %xmm5, %xmm5              # xmm5 = xmm5[0,2,2,3,4,5,6,7]
	pshufhw	$231, %xmm5, %xmm5              # xmm5 = xmm5[0,1,2,3,7,5,6,7]
	packuswb	%xmm4, %xmm5
	pand	%xmm2, %xmm5
	por	%xmm3, %xmm5
	movdqu	%xmm5, (%rdi)
	movzbl	13(%rdi), %r10d
	movzbl	9(%rdi), %r15d
	movzbl	5(%rdi), %eax
	movb	%al, -23(%rsp)                  # 1-byte Spill
	movzbl	(%rdi), %r14d
	movzbl	1(%rdi), %eax
	movb	%al, -20(%rsp)                  # 1-byte Spill
	movzbl	2(%rdi), %esi
	movzbl	10(%rdi), %r13d
	movzbl	6(%rdi), %eax
	movb	%al, -21(%rsp)                  # 1-byte Spill
	movzbl	14(%rdi), %ecx
	movzbl	3(%rdi), %eax
	movb	%al, -19(%rsp)                  # 1-byte Spill
	movzbl	7(%rdi), %eax
	movb	%al, -22(%rsp)                  # 1-byte Spill
	movzbl	11(%rdi), %eax
	movb	%al, -24(%rsp)                  # 1-byte Spill
	movzbl	15(%rdi), %r12d
	movzbl	4(%rdi), %r8d
	movzbl	8(%rdi), %r9d
	movzbl	12(%rdi), %r11d
	addq	$-16, -16(%rsp)                 # 8-byte Folded Spill
	jmp	.LBB7_1
.LBB7_3:                                # %for.end
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	InvCipher, .Lfunc_end7-InvCipher
	.cfi_endproc
                                        # -- End function
	.globl	AES_CBC_encrypt_buffer          # -- Begin function AES_CBC_encrypt_buffer
	.p2align	4, 0x90
	.type	AES_CBC_encrypt_buffer,@function
AES_CBC_encrypt_buffer:                 # @AES_CBC_encrypt_buffer
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	pushq	%rax
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	176(%rdi), %r12
	movq	%r12, %rax
	testq	%rdx, %rdx
	je	.LBB8_4
# %bb.1:                                # %for.body.i.preheader.preheader
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movq	%rdi, %r15
	xorl	%r13d, %r13d
	movq	%r12, %rax
	movq	%rsi, %rbp
	.p2align	4, 0x90
.LBB8_2:                                # %for.body.i.preheader
                                        # =>This Inner Loop Header: Depth=1
	leaq	(%rbx,%r13), %rdi
	movzbl	(%rax), %ecx
	xorb	%cl, (%rbx,%r13)
	movzbl	1(%rax), %ecx
	xorb	%cl, 1(%rbx,%r13)
	movzbl	2(%rax), %ecx
	xorb	%cl, 2(%rbx,%r13)
	movzbl	3(%rax), %ecx
	xorb	%cl, 3(%rbx,%r13)
	movzbl	4(%rax), %ecx
	xorb	%cl, 4(%rbx,%r13)
	movzbl	5(%rax), %ecx
	xorb	%cl, 5(%rbx,%r13)
	movzbl	6(%rax), %ecx
	xorb	%cl, 6(%rbx,%r13)
	movzbl	7(%rax), %ecx
	xorb	%cl, 7(%rbx,%r13)
	movzbl	8(%rax), %ecx
	xorb	%cl, 8(%rbx,%r13)
	movzbl	9(%rax), %ecx
	xorb	%cl, 9(%rbx,%r13)
	movzbl	10(%rax), %ecx
	xorb	%cl, 10(%rbx,%r13)
	movzbl	11(%rax), %ecx
	xorb	%cl, 11(%rbx,%r13)
	movzbl	12(%rax), %ecx
	xorb	%cl, 12(%rbx,%r13)
	movzbl	13(%rax), %ecx
	xorb	%cl, 13(%rbx,%r13)
	movzbl	14(%rax), %ecx
	xorb	%cl, 14(%rbx,%r13)
	movzbl	15(%rax), %eax
	xorb	%al, 15(%rbx,%r13)
	movq	%r15, %rsi
	callq	Cipher
	movq	%rbp, %rax
	addq	$16, %rbp
	addq	$16, %r13
	cmpq	%r14, %r13
	jb	.LBB8_2
# %bb.3:                                # %for.end.loopexit
	leaq	(%rbx,%r13), %rax
	addq	$-16, %rax
.LBB8_4:                                # %for.end
	movups	(%rax), %xmm0
	movups	%xmm0, (%r12)
	addq	$8, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	AES_CBC_encrypt_buffer, .Lfunc_end8-AES_CBC_encrypt_buffer
	.cfi_endproc
                                        # -- End function
	.globl	AES_CBC_decrypt_buffer          # -- Begin function AES_CBC_decrypt_buffer
	.p2align	4, 0x90
	.type	AES_CBC_decrypt_buffer,@function
AES_CBC_decrypt_buffer:                 # @AES_CBC_decrypt_buffer
	.cfi_startproc
# %bb.0:                                # %entry
	testq	%rdx, %rdx
	je	.LBB9_4
# %bb.1:                                # %for.body.lr.ph
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r15
	leaq	176(%rdi), %r12
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB9_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	leaq	(%r14,%r13), %rdi
	movups	(%r14,%r13), %xmm0
	movaps	%xmm0, (%rsp)
	movq	%r15, %rsi
	callq	InvCipher
	movzbl	176(%r15), %eax
	xorb	%al, (%r14,%r13)
	movzbl	177(%r15), %eax
	xorb	%al, 1(%r14,%r13)
	movzbl	178(%r15), %eax
	xorb	%al, 2(%r14,%r13)
	movzbl	179(%r15), %eax
	xorb	%al, 3(%r14,%r13)
	movzbl	180(%r15), %eax
	xorb	%al, 4(%r14,%r13)
	movzbl	181(%r15), %eax
	xorb	%al, 5(%r14,%r13)
	movzbl	182(%r15), %eax
	xorb	%al, 6(%r14,%r13)
	movzbl	183(%r15), %eax
	xorb	%al, 7(%r14,%r13)
	movzbl	184(%r15), %eax
	xorb	%al, 8(%r14,%r13)
	movzbl	185(%r15), %eax
	xorb	%al, 9(%r14,%r13)
	movzbl	186(%r15), %eax
	xorb	%al, 10(%r14,%r13)
	movzbl	187(%r15), %eax
	xorb	%al, 11(%r14,%r13)
	movzbl	188(%r15), %eax
	xorb	%al, 12(%r14,%r13)
	movzbl	189(%r15), %eax
	xorb	%al, 13(%r14,%r13)
	movzbl	190(%r15), %eax
	xorb	%al, 14(%r14,%r13)
	movzbl	191(%r15), %eax
	xorb	%al, 15(%r14,%r13)
	movaps	(%rsp), %xmm0
	movups	%xmm0, (%r12)
	addq	$16, %r13
	cmpq	%rbx, %r13
	jb	.LBB9_2
# %bb.3:
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	.cfi_restore %rbx
	.cfi_restore %r12
	.cfi_restore %r13
	.cfi_restore %r14
	.cfi_restore %r15
.LBB9_4:                                # %for.end
	retq
.Lfunc_end9:
	.size	AES_CBC_decrypt_buffer, .Lfunc_end9-AES_CBC_decrypt_buffer
	.cfi_endproc
                                        # -- End function
	.globl	AES_CTR_xcrypt_buffer           # -- Begin function AES_CTR_xcrypt_buffer
	.p2align	4, 0x90
	.type	AES_CTR_xcrypt_buffer,@function
AES_CTR_xcrypt_buffer:                  # @AES_CTR_xcrypt_buffer
	.cfi_startproc
# %bb.0:                                # %entry
	testq	%rdx, %rdx
	je	.LBB10_24
# %bb.1:                                # %for.body.lr.ph
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r15
	leaq	176(%rdi), %r13
	leaq	191(%rdi), %rbp
	leaq	190(%rdi), %rax
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	leaq	189(%rdi), %rax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	leaq	188(%rdi), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	leaq	187(%rdi), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	leaq	186(%rdi), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	leaq	185(%rdi), %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	leaq	184(%rdi), %rax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	leaq	183(%rdi), %rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	leaq	182(%rdi), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	leaq	181(%rdi), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	leaq	180(%rdi), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	leaq	179(%rdi), %rax
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	leaq	178(%rdi), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	leaq	177(%rdi), %rax
	movq	%rax, (%rsp)                    # 8-byte Spill
	movl	$16, %eax
	xorl	%r12d, %r12d
	jmp	.LBB10_2
	.p2align	4, 0x90
.LBB10_20:                              # %if.end
                                        #   in Loop: Header=BB10_2 Depth=1
	incb	%al
	movb	%al, (%rcx)
.LBB10_21:                              # %if.end20
                                        #   in Loop: Header=BB10_2 Depth=1
	xorl	%eax, %eax
.LBB10_22:                              # %if.end20
                                        #   in Loop: Header=BB10_2 Depth=1
	movl	%eax, %ecx
	movzbl	112(%rsp,%rcx), %ecx
	xorb	%cl, (%r14,%r12)
	incq	%r12
	incl	%eax
	cmpq	%r12, %rbx
	je	.LBB10_23
.LBB10_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$16, %eax
	jne	.LBB10_22
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB10_2 Depth=1
	movups	(%r13), %xmm0
	movaps	%xmm0, 112(%rsp)
	leaq	112(%rsp), %rdi
	movq	%r15, %rsi
	callq	Cipher
	movzbl	191(%r15), %eax
	movq	%rbp, %rcx
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.4:                                # %if.then11
                                        #   in Loop: Header=BB10_2 Depth=1
	movb	$0, (%rbp)
	movq	104(%rsp), %rcx                 # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.5:                                # %if.then11.1
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	104(%rsp), %rax                 # 8-byte Reload
	movb	$0, (%rax)
	movq	96(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.6:                                # %if.then11.2
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	96(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	88(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.7:                                # %if.then11.3
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	88(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	80(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.8:                                # %if.then11.4
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	80(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	72(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.9:                                # %if.then11.5
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	72(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	64(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.10:                               # %if.then11.6
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	64(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	56(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.11:                               # %if.then11.7
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	56(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	48(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.12:                               # %if.then11.8
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	48(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	40(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.13:                               # %if.then11.9
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	40(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	32(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.14:                               # %if.then11.10
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	32(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	24(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.15:                               # %if.then11.11
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	24(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	16(%rsp), %rcx                  # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.16:                               # %if.then11.12
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	16(%rsp), %rax                  # 8-byte Reload
	movb	$0, (%rax)
	movq	8(%rsp), %rcx                   # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.17:                               # %if.then11.13
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	8(%rsp), %rax                   # 8-byte Reload
	movb	$0, (%rax)
	movq	(%rsp), %rcx                    # 8-byte Reload
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.18:                               # %if.then11.14
                                        #   in Loop: Header=BB10_2 Depth=1
	movq	(%rsp), %rax                    # 8-byte Reload
	movb	$0, (%rax)
	movzbl	(%r13), %eax
	movq	%r13, %rcx
	cmpb	$-1, %al
	jne	.LBB10_20
# %bb.19:                               # %if.then11.15
                                        #   in Loop: Header=BB10_2 Depth=1
	movb	$0, (%r13)
	jmp	.LBB10_21
.LBB10_23:
	addq	$136, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	.cfi_restore %rbx
	.cfi_restore %r12
	.cfi_restore %r13
	.cfi_restore %r14
	.cfi_restore %r15
	.cfi_restore %rbp
.LBB10_24:                              # %for.end30
	retq
.Lfunc_end10:
	.size	AES_CTR_xcrypt_buffer, .Lfunc_end10-AES_CTR_xcrypt_buffer
	.cfi_endproc
                                        # -- End function
	.type	sbox,@object                    # @sbox
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
sbox:
	.ascii	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321\000\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.size	sbox, 256

	.type	Rcon,@object                    # @Rcon
Rcon:
	.ascii	"\215\001\002\004\b\020 @\200\0336"
	.size	Rcon, 11

	.type	rsbox,@object                   # @rsbox
	.p2align	4, 0x0
rsbox:
	.ascii	"R\tj\32506\2458\277@\243\236\201\363\327\373|\3439\202\233/\377\2074\216CD\304\336\351\313T{\2242\246\302#=\356L\225\013B\372\303N\b.\241f(\331$\262v[\242Im\213\321%r\370\366d\206h\230\026\324\244\\\314]e\266\222lpHP\375\355\271\332^\025FW\247\215\235\204\220\330\253\000\214\274\323\n\367\344X\005\270\263E\006\320,\036\217\312?\017\002\301\257\275\003\001\023\212k:\221\021AOg\334\352\227\362\317\316\360\264\346s\226\254t\"\347\2555\205\342\3717\350\034u\337nG\361\032q\035)\305\211o\267b\016\252\030\276\033\374V>K\306\322y \232\333\300\376x\315Z\364\037\335\2503\210\007\3071\261\022\020Y'\200\354_`Q\177\251\031\265J\r-\345z\237\223\311\234\357\240\340;M\256*\365\260\310\353\273<\203S\231a\027+\004~\272w\326&\341i\024cU!\f}"
	.size	rsbox, 256

	.ident	"AMD clang version 17.0.6 (CLANG: AOCC_5.0.0-Build#1377 2024_09_24)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
