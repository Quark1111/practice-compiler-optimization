	.text
	.file	"aes.c"
	.globl	AES_init_ctx                    # -- Begin function AES_init_ctx
	.p2align	4, 0x90
	.type	AES_init_ctx,@function
AES_init_ctx:                           # @AES_init_ctx
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	KeyExpansion
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	AES_init_ctx, .Lfunc_end0-AES_init_ctx
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function KeyExpansion
	.type	KeyExpansion,@function
KeyExpansion:                           # @KeyExpansion
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movl	$0, -20(%rbp)
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$4, -20(%rbp)
	jae	.LBB1_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$0, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$0, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$1, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$1, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$2, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$2, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-16(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$3, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %ecx
	shll	$2, %ecx
	addl	$3, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB1_1
.LBB1_4:                                # %for.end
	movl	$4, -20(%rbp)
.LBB1_5:                                # %for.cond29
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$44, -20(%rbp)
	jae	.LBB1_10
# %bb.6:                                # %for.body31
                                        #   in Loop: Header=BB1_5 Depth=1
	movl	-20(%rbp), %eax
	subl	$1, %eax
	shll	$2, %eax
	movl	%eax, -28(%rbp)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$0, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %al
	movb	%al, -32(%rbp)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %al
	movb	%al, -31(%rbp)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$2, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %al
	movb	%al, -30(%rbp)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$3, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx), %al
	movb	%al, -29(%rbp)
	movl	-20(%rbp), %eax
	andl	$3, %eax
	cmpl	$0, %eax
	jne	.LBB1_8
# %bb.7:                                # %if.then
                                        #   in Loop: Header=BB1_5 Depth=1
	movb	-32(%rbp), %al
	movb	%al, -33(%rbp)
	movb	-31(%rbp), %al
	movb	%al, -32(%rbp)
	movb	-30(%rbp), %al
	movb	%al, -31(%rbp)
	movb	-29(%rbp), %al
	movb	%al, -30(%rbp)
	movb	-33(%rbp), %al
	movb	%al, -29(%rbp)
	movzbl	-32(%rbp), %eax
	movl	%eax, %ecx
	leaq	sbox(%rip), %rax
	movb	(%rax,%rcx), %al
	movb	%al, -32(%rbp)
	movzbl	-31(%rbp), %eax
	movl	%eax, %ecx
	leaq	sbox(%rip), %rax
	movb	(%rax,%rcx), %al
	movb	%al, -31(%rbp)
	movzbl	-30(%rbp), %eax
	movl	%eax, %ecx
	leaq	sbox(%rip), %rax
	movb	(%rax,%rcx), %al
	movb	%al, -30(%rbp)
	movzbl	-29(%rbp), %eax
	movl	%eax, %ecx
	leaq	sbox(%rip), %rax
	movb	(%rax,%rcx), %al
	movb	%al, -29(%rbp)
	movzbl	-32(%rbp), %eax
	movl	-20(%rbp), %ecx
	shrl	$2, %ecx
	movl	%ecx, %ecx
	movl	%ecx, %edx
	leaq	Rcon(%rip), %rcx
	movzbl	(%rcx,%rdx), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -32(%rbp)
.LBB1_8:                                # %if.end
                                        #   in Loop: Header=BB1_5 Depth=1
	movl	-20(%rbp), %eax
	shll	$2, %eax
	movl	%eax, -24(%rbp)
	movl	-20(%rbp), %eax
	subl	$4, %eax
	shll	$2, %eax
	movl	%eax, -28(%rbp)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$0, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %eax
	movzbl	-32(%rbp), %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movl	-24(%rbp), %ecx
	addl	$0, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %eax
	movzbl	-31(%rbp), %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movl	-24(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$2, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %eax
	movzbl	-30(%rbp), %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movl	-24(%rbp), %ecx
	addl	$2, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %ecx
	addl	$3, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %eax
	movzbl	-29(%rbp), %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movl	-24(%rbp), %ecx
	addl	$3, %ecx
	movl	%ecx, %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
# %bb.9:                                # %for.inc127
                                        #   in Loop: Header=BB1_5 Depth=1
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB1_5
.LBB1_10:                               # %for.end129
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	KeyExpansion
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rdx
	movq	%rdx, 176(%rax)
	movq	8(%rcx), %rcx
	movq	%rcx, 184(%rax)
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rdx
	movq	%rdx, 176(%rax)
	movq	8(%rcx), %rcx
	movq	%rcx, 184(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	callq	Cipher
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end4:
	.size	AES_ECB_encrypt, .Lfunc_end4-AES_ECB_encrypt
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function Cipher
	.type	Cipher,@function
Cipher:                                 # @Cipher
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movb	$0, -17(%rbp)
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdx
	xorl	%edi, %edi
	callq	AddRoundKey
	movb	$1, -17(%rbp)
.LBB5_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rdi
	callq	SubBytes
	movq	-8(%rbp), %rdi
	callq	ShiftRows
	movzbl	-17(%rbp), %eax
	cmpl	$10, %eax
	jne	.LBB5_3
# %bb.2:                                # %if.then
	jmp	.LBB5_5
.LBB5_3:                                # %if.end
                                        #   in Loop: Header=BB5_1 Depth=1
	movq	-8(%rbp), %rdi
	callq	MixColumns
	movb	-17(%rbp), %al
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdx
	movzbl	%al, %edi
	callq	AddRoundKey
# %bb.4:                                # %for.inc
                                        #   in Loop: Header=BB5_1 Depth=1
	movb	-17(%rbp), %al
	addb	$1, %al
	movb	%al, -17(%rbp)
	jmp	.LBB5_1
.LBB5_5:                                # %for.end
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdx
	movl	$10, %edi
	callq	AddRoundKey
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	callq	InvCipher
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	AES_ECB_decrypt, .Lfunc_end6-AES_ECB_decrypt
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function InvCipher
	.type	InvCipher,@function
InvCipher:                              # @InvCipher
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movb	$0, -17(%rbp)
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdx
	movl	$10, %edi
	callq	AddRoundKey
	movb	$9, -17(%rbp)
.LBB7_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rdi
	callq	InvShiftRows
	movq	-8(%rbp), %rdi
	callq	InvSubBytes
	movb	-17(%rbp), %al
	movq	-8(%rbp), %rsi
	movq	-16(%rbp), %rdx
	movzbl	%al, %edi
	callq	AddRoundKey
	movzbl	-17(%rbp), %eax
	cmpl	$0, %eax
	jne	.LBB7_3
# %bb.2:                                # %if.then
	jmp	.LBB7_5
.LBB7_3:                                # %if.end
                                        #   in Loop: Header=BB7_1 Depth=1
	movq	-8(%rbp), %rdi
	callq	InvMixColumns
# %bb.4:                                # %for.inc
                                        #   in Loop: Header=BB7_1 Depth=1
	movb	-17(%rbp), %al
	addb	$-1, %al
	movb	%al, -17(%rbp)
	jmp	.LBB7_1
.LBB7_5:                                # %for.end
	addq	$32, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	addq	$176, %rax
	movq	%rax, -40(%rbp)
	movq	$0, -32(%rbp)
.LBB8_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	.LBB8_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB8_1 Depth=1
	movq	-16(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	XorWithIv
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	callq	Cipher
	movq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -16(%rbp)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB8_1 Depth=1
	movq	-32(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB8_1
.LBB8_4:                                # %for.end
	movq	-8(%rbp), %rax
	movq	-40(%rbp), %rcx
	movq	(%rcx), %rdx
	movq	%rdx, 176(%rax)
	movq	8(%rcx), %rcx
	movq	%rcx, 184(%rax)
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	AES_CBC_encrypt_buffer, .Lfunc_end8-AES_CBC_encrypt_buffer
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function XorWithIv
	.type	XorWithIv,@function
XorWithIv:                              # @XorWithIv
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movb	$0, -17(%rbp)
.LBB9_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movzbl	-17(%rbp), %eax
	cmpl	$16, %eax
	jge	.LBB9_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB9_1 Depth=1
	movq	-16(%rbp), %rax
	movzbl	-17(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %esi
	movq	-8(%rbp), %rax
	movzbl	-17(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, (%rax,%rcx)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB9_1 Depth=1
	movb	-17(%rbp), %al
	addb	$1, %al
	movb	%al, -17(%rbp)
	jmp	.LBB9_1
.LBB9_4:                                # %for.end
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end9:
	.size	XorWithIv, .Lfunc_end9-XorWithIv
	.cfi_endproc
                                        # -- End function
	.globl	AES_CBC_decrypt_buffer          # -- Begin function AES_CBC_decrypt_buffer
	.p2align	4, 0x90
	.type	AES_CBC_decrypt_buffer,@function
AES_CBC_decrypt_buffer:                 # @AES_CBC_decrypt_buffer
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	$0, -32(%rbp)
.LBB10_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	.LBB10_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB10_1 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	8(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	callq	InvCipher
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	addq	$176, %rsi
	callq	XorWithIv
	movq	-8(%rbp), %rax
	movq	-48(%rbp), %rcx
	movq	%rcx, 176(%rax)
	movq	-40(%rbp), %rcx
	movq	%rcx, 184(%rax)
	movq	-16(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -16(%rbp)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB10_1 Depth=1
	movq	-32(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB10_1
.LBB10_4:                               # %for.end
	addq	$48, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end10:
	.size	AES_CBC_decrypt_buffer, .Lfunc_end10-AES_CBC_decrypt_buffer
	.cfi_endproc
                                        # -- End function
	.globl	AES_CTR_xcrypt_buffer           # -- Begin function AES_CTR_xcrypt_buffer
	.p2align	4, 0x90
	.type	AES_CTR_xcrypt_buffer,@function
AES_CTR_xcrypt_buffer:                  # @AES_CTR_xcrypt_buffer
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	$0, -56(%rbp)
	movl	$16, -60(%rbp)
.LBB11_1:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_4 Depth 2
	movq	-56(%rbp), %rax
	cmpq	-24(%rbp), %rax
	jae	.LBB11_12
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB11_1 Depth=1
	cmpl	$16, -60(%rbp)
	jne	.LBB11_10
# %bb.3:                                # %if.then
                                        #   in Loop: Header=BB11_1 Depth=1
	movq	-8(%rbp), %rax
	movq	176(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movq	184(%rax), %rax
	movq	%rax, -40(%rbp)
	leaq	-48(%rbp), %rdi
	movq	-8(%rbp), %rsi
	callq	Cipher
	movl	$15, -60(%rbp)
.LBB11_4:                               # %for.cond5
                                        #   Parent Loop BB11_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$0, -60(%rbp)
	jl	.LBB11_9
# %bb.5:                                # %for.body7
                                        #   in Loop: Header=BB11_4 Depth=2
	movq	-8(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movzbl	176(%rax,%rcx), %eax
	cmpl	$255, %eax
	jne	.LBB11_7
# %bb.6:                                # %if.then11
                                        #   in Loop: Header=BB11_4 Depth=2
	movq	-8(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movb	$0, 176(%rax,%rcx)
	jmp	.LBB11_8
.LBB11_7:                               # %if.end
                                        #   in Loop: Header=BB11_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movzbl	176(%rax,%rcx), %edx
	addl	$1, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, 176(%rax,%rcx)
	jmp	.LBB11_9
.LBB11_8:                               # %for.inc
                                        #   in Loop: Header=BB11_4 Depth=2
	movl	-60(%rbp), %eax
	addl	$-1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB11_4
.LBB11_9:                               # %for.end
                                        #   in Loop: Header=BB11_1 Depth=1
	movl	$0, -60(%rbp)
.LBB11_10:                              # %if.end20
                                        #   in Loop: Header=BB11_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-56(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movslq	-60(%rbp), %rcx
	movzbl	-48(%rbp,%rcx), %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-16(%rbp), %rax
	movq	-56(%rbp), %rcx
	movb	%dl, (%rax,%rcx)
# %bb.11:                               # %for.inc28
                                        #   in Loop: Header=BB11_1 Depth=1
	movq	-56(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -56(%rbp)
	movl	-60(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB11_1
.LBB11_12:                              # %for.end30
	addq	$64, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	AES_CTR_xcrypt_buffer, .Lfunc_end11-AES_CTR_xcrypt_buffer
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function AddRoundKey
	.type	AddRoundKey,@function
AddRoundKey:                            # @AddRoundKey
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movb	$0, -25(%rbp)
.LBB12_1:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_3 Depth 2
	movzbl	-25(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB12_8
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB12_1 Depth=1
	movb	$0, -26(%rbp)
.LBB12_3:                               # %for.cond2
                                        #   Parent Loop BB12_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	-26(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB12_6
# %bb.4:                                # %for.body6
                                        #   in Loop: Header=BB12_3 Depth=2
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %ecx
	shll	$2, %ecx
	shll	$2, %ecx
	movzbl	-25(%rbp), %edx
	shll	$2, %edx
	addl	%edx, %ecx
	movzbl	-26(%rbp), %edx
	addl	%edx, %ecx
	movslq	%ecx, %rcx
	movzbl	(%rax,%rcx), %esi
	movq	-16(%rbp), %rax
	movzbl	-25(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movzbl	-26(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, (%rax,%rcx)
# %bb.5:                                # %for.inc
                                        #   in Loop: Header=BB12_3 Depth=2
	movb	-26(%rbp), %al
	addb	$1, %al
	movb	%al, -26(%rbp)
	jmp	.LBB12_3
.LBB12_6:                               # %for.end
                                        #   in Loop: Header=BB12_1 Depth=1
	jmp	.LBB12_7
.LBB12_7:                               # %for.inc20
                                        #   in Loop: Header=BB12_1 Depth=1
	movb	-25(%rbp), %al
	addb	$1, %al
	movb	%al, -25(%rbp)
	jmp	.LBB12_1
.LBB12_8:                               # %for.end22
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end12:
	.size	AddRoundKey, .Lfunc_end12-AddRoundKey
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function SubBytes
	.type	SubBytes,@function
SubBytes:                               # @SubBytes
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movb	$0, -9(%rbp)
.LBB13_1:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_3 Depth 2
	movzbl	-9(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB13_8
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB13_1 Depth=1
	movb	$0, -10(%rbp)
.LBB13_3:                               # %for.cond2
                                        #   Parent Loop BB13_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	-10(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB13_6
# %bb.4:                                # %for.body6
                                        #   in Loop: Header=BB13_3 Depth=2
	movq	-8(%rbp), %rax
	movzbl	-10(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, %ecx
	leaq	sbox(%rip), %rax
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movzbl	-10(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
# %bb.5:                                # %for.inc
                                        #   in Loop: Header=BB13_3 Depth=2
	movb	-10(%rbp), %al
	addb	$1, %al
	movb	%al, -10(%rbp)
	jmp	.LBB13_3
.LBB13_6:                               # %for.end
                                        #   in Loop: Header=BB13_1 Depth=1
	jmp	.LBB13_7
.LBB13_7:                               # %for.inc15
                                        #   in Loop: Header=BB13_1 Depth=1
	movb	-9(%rbp), %al
	addb	$1, %al
	movb	%al, -9(%rbp)
	jmp	.LBB13_1
.LBB13_8:                               # %for.end17
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end13:
	.size	SubBytes, .Lfunc_end13-SubBytes
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function ShiftRows
	.type	ShiftRows,@function
ShiftRows:                              # @ShiftRows
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movb	1(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	5(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 1(%rax)
	movq	-8(%rbp), %rax
	movb	9(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 5(%rax)
	movq	-8(%rbp), %rax
	movb	13(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 9(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 13(%rax)
	movq	-8(%rbp), %rax
	movb	2(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	10(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 2(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 10(%rax)
	movq	-8(%rbp), %rax
	movb	6(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	14(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 6(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 14(%rax)
	movq	-8(%rbp), %rax
	movb	3(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	15(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 3(%rax)
	movq	-8(%rbp), %rax
	movb	11(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 15(%rax)
	movq	-8(%rbp), %rax
	movb	7(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 11(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 7(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end14:
	.size	ShiftRows, .Lfunc_end14-ShiftRows
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function MixColumns
	.type	MixColumns,@function
MixColumns:                             # @MixColumns
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movb	$0, -9(%rbp)
.LBB15_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movzbl	-9(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB15_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB15_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movb	(%rax,%rcx,4), %al
	movb	%al, -12(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx,4), %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movzbl	1(%rcx,%rdx,4), %ecx
	xorl	%ecx, %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movzbl	2(%rcx,%rdx,4), %ecx
	xorl	%ecx, %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movzbl	3(%rcx,%rdx,4), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -10(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx,4), %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movzbl	1(%rcx,%rdx,4), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %edi
	callq	xtime
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %esi
	movzbl	-10(%rbp), %eax
	xorl	%eax, %esi
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx,4), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, (%rax,%rcx,4)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	1(%rax,%rcx,4), %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movzbl	2(%rcx,%rdx,4), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %edi
	callq	xtime
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %esi
	movzbl	-10(%rbp), %eax
	xorl	%eax, %esi
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	1(%rax,%rcx,4), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, 1(%rax,%rcx,4)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	2(%rax,%rcx,4), %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
                                        # kill: def $rdx killed $edx
	movzbl	3(%rcx,%rdx,4), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %edi
	callq	xtime
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %esi
	movzbl	-10(%rbp), %eax
	xorl	%eax, %esi
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	2(%rax,%rcx,4), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, 2(%rax,%rcx,4)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	3(%rax,%rcx,4), %eax
	movzbl	-12(%rbp), %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %edi
	callq	xtime
	movb	%al, -11(%rbp)
	movzbl	-11(%rbp), %esi
	movzbl	-10(%rbp), %eax
	xorl	%eax, %esi
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	3(%rax,%rcx,4), %edx
	xorl	%esi, %edx
                                        # kill: def $dl killed $dl killed $edx
	movb	%dl, 3(%rax,%rcx,4)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB15_1 Depth=1
	movb	-9(%rbp), %al
	addb	$1, %al
	movb	%al, -9(%rbp)
	jmp	.LBB15_1
.LBB15_4:                               # %for.end
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end15:
	.size	MixColumns, .Lfunc_end15-MixColumns
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function xtime
	.type	xtime,@function
xtime:                                  # @xtime
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movb	%dil, %al
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	shll	%eax
	movzbl	-1(%rbp), %ecx
	sarl	$7, %ecx
	andl	$1, %ecx
	imull	$27, %ecx, %ecx
	xorl	%ecx, %eax
                                        # kill: def $al killed $al killed $eax
	movzbl	%al, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end16:
	.size	xtime, .Lfunc_end16-xtime
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function InvShiftRows
	.type	InvShiftRows,@function
InvShiftRows:                           # @InvShiftRows
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movb	13(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	9(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 13(%rax)
	movq	-8(%rbp), %rax
	movb	5(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 9(%rax)
	movq	-8(%rbp), %rax
	movb	1(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 5(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 1(%rax)
	movq	-8(%rbp), %rax
	movb	2(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	10(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 2(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 10(%rax)
	movq	-8(%rbp), %rax
	movb	6(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	14(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 6(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 14(%rax)
	movq	-8(%rbp), %rax
	movb	3(%rax), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movb	7(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 3(%rax)
	movq	-8(%rbp), %rax
	movb	11(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 7(%rax)
	movq	-8(%rbp), %rax
	movb	15(%rax), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 11(%rax)
	movb	-9(%rbp), %cl
	movq	-8(%rbp), %rax
	movb	%cl, 15(%rax)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end17:
	.size	InvShiftRows, .Lfunc_end17-InvShiftRows
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function InvSubBytes
	.type	InvSubBytes,@function
InvSubBytes:                            # @InvSubBytes
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movb	$0, -9(%rbp)
.LBB18_1:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB18_3 Depth 2
	movzbl	-9(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB18_8
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB18_1 Depth=1
	movb	$0, -10(%rbp)
.LBB18_3:                               # %for.cond2
                                        #   Parent Loop BB18_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	-10(%rbp), %eax
	cmpl	$4, %eax
	jge	.LBB18_6
# %bb.4:                                # %for.body6
                                        #   in Loop: Header=BB18_3 Depth=2
	movq	-8(%rbp), %rax
	movzbl	-10(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, %ecx
	leaq	rsbox(%rip), %rax
	movb	(%rax,%rcx), %dl
	movq	-8(%rbp), %rax
	movzbl	-10(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	shlq	$2, %rcx
	addq	%rcx, %rax
	movzbl	-9(%rbp), %ecx
                                        # kill: def $rcx killed $ecx
	movb	%dl, (%rax,%rcx)
# %bb.5:                                # %for.inc
                                        #   in Loop: Header=BB18_3 Depth=2
	movb	-10(%rbp), %al
	addb	$1, %al
	movb	%al, -10(%rbp)
	jmp	.LBB18_3
.LBB18_6:                               # %for.end
                                        #   in Loop: Header=BB18_1 Depth=1
	jmp	.LBB18_7
.LBB18_7:                               # %for.inc15
                                        #   in Loop: Header=BB18_1 Depth=1
	movb	-9(%rbp), %al
	addb	$1, %al
	movb	%al, -9(%rbp)
	jmp	.LBB18_1
.LBB18_8:                               # %for.end17
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end18:
	.size	InvSubBytes, .Lfunc_end18-InvSubBytes
	.cfi_endproc
                                        # -- End function
	.p2align	4, 0x90                         # -- Begin function InvMixColumns
	.type	InvMixColumns,@function
InvMixColumns:                          # @InvMixColumns
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$320, %rsp                      # imm = 0x140
	movq	%rdi, -8(%rbp)
	movl	$0, -12(%rbp)
.LBB19_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$4, -12(%rbp)
	jge	.LBB19_4
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB19_1 Depth=1
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	(%rax,%rcx,4), %al
	movb	%al, -13(%rbp)
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	1(%rax,%rcx,4), %al
	movb	%al, -14(%rbp)
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	2(%rax,%rcx,4), %al
	movb	%al, -15(%rbp)
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	3(%rax,%rcx,4), %al
	movb	%al, -16(%rbp)
	movzbl	-13(%rbp), %eax
	imull	$0, %eax, %eax
	movl	%eax, -320(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-320(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -316(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-316(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -312(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-312(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -308(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-308(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -288(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -304(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-304(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -300(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-300(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -296(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-296(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -292(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-292(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-288(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -268(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -284(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-284(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -280(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-280(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -276(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-276(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -272(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-272(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-268(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -248(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -264(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-264(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -260(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-260(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -256(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-256(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -252(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-252(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-248(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, (%rax,%rcx,4)
	movzbl	-13(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -244(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-244(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -240(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-240(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -236(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-236(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -232(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-232(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -212(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %eax
	imull	$0, %eax, %eax
	movl	%eax, -228(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-228(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -224(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-224(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -220(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-220(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -216(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-216(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-212(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -192(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -208(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-208(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -204(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-204(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -200(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-200(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -196(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-196(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-192(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -172(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -188(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-188(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -184(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-184(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -180(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-180(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -176(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-176(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-172(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, 1(%rax,%rcx,4)
	movzbl	-13(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -168(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-168(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -164(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-164(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -160(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-160(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -156(%rbp)                # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-156(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -136(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -152(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-152(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -148(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-148(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -144(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-144(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -140(%rbp)                # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-140(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-136(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -116(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %eax
	imull	$0, %eax, %eax
	movl	%eax, -132(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-132(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -128(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-128(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -124(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-124(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -120(%rbp)                # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-120(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-116(%rbp), %eax                # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -96(%rbp)                 # 4-byte Spill
	movzbl	-16(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -112(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-112(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -108(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-108(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -104(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-104(%rbp), %eax                # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -100(%rbp)                # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-100(%rbp), %ecx                # 4-byte Reload
	movb	%al, %dl
	movl	-96(%rbp), %eax                 # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, 2(%rax,%rcx,4)
	movzbl	-13(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -92(%rbp)                 # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-92(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -88(%rbp)                 # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-88(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -84(%rbp)                 # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-84(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -80(%rbp)                 # 4-byte Spill
	movzbl	-13(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-80(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -60(%rbp)                 # 4-byte Spill
	movzbl	-14(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -76(%rbp)                 # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-76(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -72(%rbp)                 # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-72(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -68(%rbp)                 # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-68(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -64(%rbp)                 # 4-byte Spill
	movzbl	-14(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-64(%rbp), %ecx                 # 4-byte Reload
	movb	%al, %dl
	movl	-60(%rbp), %eax                 # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -40(%rbp)                 # 4-byte Spill
	movzbl	-15(%rbp), %eax
	shll	$0, %eax
	movl	%eax, -56(%rbp)                 # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-56(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -52(%rbp)                 # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-52(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	imull	$0, %ecx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -48(%rbp)                 # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-48(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -44(%rbp)                 # 4-byte Spill
	movzbl	-15(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-44(%rbp), %ecx                 # 4-byte Reload
	movb	%al, %dl
	movl	-40(%rbp), %eax                 # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movl	%eax, -20(%rbp)                 # 4-byte Spill
	movzbl	-16(%rbp), %eax
	imull	$0, %eax, %eax
	movl	%eax, -36(%rbp)                 # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movb	%al, %cl
	movl	-36(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -32(%rbp)                 # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-32(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -28(%rbp)                 # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movb	%al, %cl
	movl	-28(%rbp), %eax                 # 4-byte Reload
	movzbl	%cl, %ecx
	shll	$0, %ecx
	xorl	%ecx, %eax
	movl	%eax, -24(%rbp)                 # 4-byte Spill
	movzbl	-16(%rbp), %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movzbl	%al, %edi
	callq	xtime
	movl	-24(%rbp), %ecx                 # 4-byte Reload
	movb	%al, %dl
	movl	-20(%rbp), %eax                 # 4-byte Reload
	movzbl	%dl, %edx
	imull	$0, %edx, %edx
	xorl	%edx, %ecx
	xorl	%ecx, %eax
	movb	%al, %dl
	movq	-8(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	%dl, 3(%rax,%rcx,4)
# %bb.3:                                # %for.inc
                                        #   in Loop: Header=BB19_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB19_1
.LBB19_4:                               # %for.end
	addq	$320, %rsp                      # imm = 0x140
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end19:
	.size	InvMixColumns, .Lfunc_end19-InvMixColumns
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
	.addrsig_sym KeyExpansion
	.addrsig_sym Cipher
	.addrsig_sym InvCipher
	.addrsig_sym XorWithIv
	.addrsig_sym AddRoundKey
	.addrsig_sym SubBytes
	.addrsig_sym ShiftRows
	.addrsig_sym MixColumns
	.addrsig_sym xtime
	.addrsig_sym InvShiftRows
	.addrsig_sym InvSubBytes
	.addrsig_sym InvMixColumns
	.addrsig_sym sbox
	.addrsig_sym Rcon
	.addrsig_sym rsbox
