	.file	"aes.c"
	.text
	.p2align 4
	.type	KeyExpansion, @function
KeyExpansion:
.LFB14:
	.cfi_startproc
	movq	%rdi, %rax
	leaq	16(%rsi), %r8
	movq	%rdi, %rdx
.L2:
	movzbl	(%rsi), %ecx
	addq	$4, %rsi
	addq	$4, %rdx
	movb	%cl, -4(%rdx)
	movzbl	-3(%rsi), %ecx
	movb	%cl, -3(%rdx)
	movzbl	-2(%rsi), %ecx
	movb	%cl, -2(%rdx)
	movzbl	-1(%rsi), %ecx
	movb	%cl, -1(%rdx)
	cmpq	%r8, %rsi
	jne	.L2
	movzbl	15(%rdi), %r8d
	movzbl	14(%rdi), %esi
	leaq	sbox(%rip), %r9
	leaq	Rcon(%rip), %r11
	movzbl	13(%rdi), %ecx
	movzbl	12(%rdi), %edx
	movl	$4, %edi
	.p2align 4,,10
	.p2align 3
.L4:
	testb	$3, %dil
	jne	.L3
	movzbl	%cl, %ecx
	movzbl	%sil, %esi
	movzbl	%r8b, %r8d
	movzbl	%dl, %edx
	movzbl	(%r9,%rcx), %r10d
	movzbl	(%r9,%rsi), %ecx
	movzbl	(%r9,%r8), %esi
	movzbl	(%r9,%rdx), %r8d
	movl	%edi, %edx
	shrl	$2, %edx
	xorb	(%r11,%rdx), %r10b
	movl	%r10d, %edx
.L3:
	xorb	(%rax), %dl
	xorb	1(%rax), %cl
	addl	$1, %edi
	addq	$4, %rax
	xorb	-2(%rax), %sil
	xorb	-1(%rax), %r8b
	movb	%dl, 12(%rax)
	movb	%cl, 13(%rax)
	movb	%sil, 14(%rax)
	movb	%r8b, 15(%rax)
	cmpl	$44, %edi
	jne	.L4
	ret
	.cfi_endproc
.LFE14:
	.size	KeyExpansion, .-KeyExpansion
	.p2align 4
	.type	InvCipher, @function
InvCipher:
.LFB27:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r10
	leaq	16(%rsi), %r8
	movq	%rdi, %rdx
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
.L9:
	xorl	%eax, %eax
.L10:
	movzbl	160(%rsi,%rax), %ecx
	xorb	%cl, (%rdx,%rax)
	addq	$1, %rax
	cmpq	$4, %rax
	jne	.L10
	addq	$4, %rsi
	addq	$4, %rdx
	cmpq	%r8, %rsi
	jne	.L9
	leaq	16(%rdi), %rax
	leaq	144(%r10), %r8
	movq	%rdi, %rsi
	movq	%rax, -40(%rsp)
	leaq	20(%rdi), %rdx
	movq	%r8, %rdi
	.p2align 4,,10
	.p2align 3
.L11:
	movzbl	1(%rsi), %r8d
	movzbl	13(%rsi), %ecx
	movb	10(%rsi), %ch
	movzbl	9(%rsi), %r9d
	movzbl	5(%rsi), %eax
	movb	2(%rsi), %ah
	movw	%cx, 1(%rsi)
	movzbl	%r8b, %ecx
	movb	14(%rsi), %ch
	movw	%ax, 9(%rsi)
	movzbl	%r9b, %eax
	movb	6(%rsi), %ah
	movw	%cx, 5(%rsi)
	movzbl	7(%rsi), %ecx
	movw	%ax, 13(%rsi)
	movzbl	3(%rsi), %eax
	movb	%cl, 3(%rsi)
	movzbl	11(%rsi), %ecx
	movq	-40(%rsp), %r8
	movb	%cl, 7(%rsi)
	movzbl	15(%rsi), %ecx
	movb	%al, 15(%rsi)
	movb	%cl, 11(%rsi)
.L12:
	leaq	-16(%r8), %rax
.L13:
	movzbl	(%rax), %ecx
	leaq	rsbox(%rip), %rbx
	addq	$4, %rax
	movzbl	(%rbx,%rcx), %ecx
	movb	%cl, -4(%rax)
	cmpq	%r8, %rax
	jne	.L13
	leaq	1(%rax), %r8
	cmpq	%rdx, %r8
	jne	.L12
	movq	-40(%rsp), %r11
	movq	%rdi, %r9
	movq	%rsi, %rcx
.L14:
	xorl	%eax, %eax
.L15:
	movzbl	(%r9,%rax), %r8d
	xorb	%r8b, (%rcx,%rax)
	addq	$1, %rax
	cmpq	$4, %rax
	jne	.L15
	addq	$4, %rcx
	addq	$4, %r9
	cmpq	%r11, %rcx
	jne	.L14
	cmpq	%r10, %rdi
	je	.L8
	movq	%rdi, -32(%rsp)
	movq	%rsi, %r14
	movq	%rsi, -24(%rsp)
	movq	%r10, -16(%rsp)
	movq	%rdx, -8(%rsp)
.L18:
	movzbl	(%r14), %r12d
	movzbl	1(%r14), %ebp
	movzbl	2(%r14), %eax
	movl	%r12d, %edx
	leal	(%r12,%r12), %ecx
	movl	%ebp, %esi
	sarb	$7, %dl
	sarb	$7, %sil
	andl	$27, %edx
	xorl	%ecx, %edx
	movl	%edx, %r15d
	sarb	$7, %dl
	movl	%r15d, %ebx
	andl	$27, %edx
	movb	%r15b, -42(%rsp)
	leal	(%rbx,%rbx), %ecx
	xorl	%ecx, %edx
	movl	%edx, %edi
	sarb	$7, %dl
	leal	(%rdi,%rdi), %ecx
	andl	$27, %edx
	movb	%dil, -43(%rsp)
	movl	%esi, %edi
	xorl	%ecx, %edx
	andl	$27, %edi
	movl	%edx, %r13d
	leal	(%rbp,%rbp), %edx
	xorl	%edx, %edi
	movl	%edi, %edx
	leal	(%rdi,%rdi), %ecx
	sarb	$7, %dl
	andl	$27, %edx
	xorl	%ecx, %edx
	movl	%eax, %ecx
	movl	%edx, %r11d
	sarb	$7, %cl
	movl	%edx, %esi
	movb	%dl, -41(%rsp)
	sarb	$7, %r11b
	leal	(%rsi,%rsi), %edx
	movl	%ecx, %esi
	andl	$27, %r11d
	andl	$27, %esi
	xorl	%edx, %r11d
	leal	(%rax,%rax), %edx
	xorl	%edx, %esi
	movl	%esi, %ecx
	leal	(%rsi,%rsi), %edx
	sarb	$7, %cl
	movl	%ecx, %ebx
	movzbl	3(%r14), %ecx
	andl	$27, %ebx
	xorl	%edx, %ebx
	sarb	$7, %cl
	movl	%ebx, %r10d
	leal	(%rbx,%rbx), %edx
	andl	$27, %ecx
	sarb	$7, %r10b
	andl	$27, %r10d
	xorl	%edx, %r10d
	movzbl	3(%r14), %edx
	addl	%edx, %edx
	xorl	%edx, %ecx
	movl	%ecx, %r9d
	leal	(%rcx,%rcx), %edx
	sarb	$7, %r9b
	andl	$27, %r9d
	xorb	-43(%rsp), %r15b
	xorl	%edx, %r9d
	xorl	%r13d, %r15d
	movl	%r9d, %r8d
	leal	(%r9,%r9), %edx
	sarb	$7, %r8b
	andl	$27, %r8d
	xorl	%edx, %r8d
	movl	%ebp, %edx
	xorl	%r12d, %ebp
	xorl	%eax, %edx
	xorb	3(%r14), %dl
	xorl	%edi, %edx
	xorl	%ebx, %edx
	xorl	%r11d, %edx
	xorl	%r10d, %edx
	xorl	%r8d, %edx
	xorl	%r15d, %edx
	movzbl	-41(%rsp), %r15d
	movb	%dl, (%r14)
	movl	%r12d, %edx
	xorl	%eax, %edx
	xorb	3(%r14), %dl
	xorl	%r15d, %edi
	xorl	%esi, %edx
	xorl	%r11d, %edi
	xorl	%r9d, %edx
	xorl	%r13d, %edx
	xorl	%r10d, %edx
	xorl	%r8d, %edx
	xorl	%edi, %edx
	movb	%dl, 1(%r14)
	movzbl	3(%r14), %edx
	xorl	%ebp, %edx
	xorl	%ecx, %edx
	xorb	-43(%rsp), %dl
	xorl	%r13d, %edx
	xorl	%r11d, %edx
	xorl	%r8d, %edx
	xorl	%ebx, %esi
	xorl	%ebp, %eax
	xorb	-42(%rsp), %al
	xorl	%r15d, %eax
	xorl	%r9d, %ecx
	xorl	%r10d, %esi
	addq	$4, %r14
	xorl	%r13d, %eax
	xorl	%r8d, %ecx
	xorl	%esi, %edx
	xorl	%r11d, %eax
	movb	%dl, -2(%r14)
	xorl	%r10d, %eax
	xorl	%eax, %ecx
	movq	-40(%rsp), %rax
	movb	%cl, -1(%r14)
	cmpq	%rax, %r14
	jne	.L18
	movq	-32(%rsp), %rdi
	movq	-24(%rsp), %rsi
	movq	-16(%rsp), %r10
	movq	-8(%rsp), %rdx
	subq	$16, %rdi
	jmp	.L11
.L8:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.size	InvCipher, .-InvCipher
	.p2align 4
	.type	Cipher, @function
Cipher:
.LFB26:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %rcx
	movq	%rdi, %r8
	movq	%rsi, %r11
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rsi, %r9
	movq	%rdi, %rdx
	xorl	%r10d, %r10d
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
.L27:
	xorl	%eax, %eax
.L28:
	movzbl	(%r9,%rax), %edi
	xorb	%dil, (%rdx,%rax)
	addq	$1, %rax
	cmpq	$4, %rax
	jne	.L28
	addl	$4, %r10d
	addq	$4, %rdx
	addq	$4, %r9
	cmpl	$16, %r10d
	jne	.L27
	leaq	160(%rsi), %rax
	leaq	16(%rsi), %rbp
	movq	%rax, -8(%rsp)
	movq	%rbp, %r10
	leaq	16(%rcx), %rdi
	leaq	20(%rcx), %r9
	leaq	sbox(%rip), %rsi
	.p2align 4,,10
	.p2align 3
.L29:
	movq	%rdi, %rdx
.L30:
	leaq	-16(%rdx), %rax
.L31:
	movzbl	(%rax), %r12d
	addq	$4, %rax
	movzbl	(%rsi,%r12), %ebx
	movb	%bl, -4(%rax)
	cmpq	%rax, %rdx
	jne	.L31
	addq	$1, %rdx
	cmpq	%rdx, %r9
	jne	.L30
	movzbl	9(%rcx), %r12d
	movzbl	5(%rcx), %edx
	movb	10(%rcx), %dh
	movzbl	1(%rcx), %r13d
	movzbl	13(%rcx), %eax
	movb	2(%rcx), %ah
	movw	%dx, 1(%rcx)
	movzbl	%r12b, %edx
	movb	14(%rcx), %dh
	movw	%ax, 9(%rcx)
	movzbl	%r13b, %eax
	movb	6(%rcx), %ah
	movw	%dx, 5(%rcx)
	movzbl	15(%rcx), %edx
	movw	%ax, 13(%rcx)
	movzbl	3(%rcx), %eax
	movb	%dl, 3(%rcx)
	movzbl	11(%rcx), %edx
	movb	%dl, 15(%rcx)
	movzbl	7(%rcx), %edx
	movb	%al, 7(%rcx)
	movb	%dl, 11(%rcx)
	cmpq	%r10, -8(%rsp)
	je	.L34
	movq	%rcx, %rax
.L33:
	movzbl	(%rax), %edx
	movzbl	1(%rax), %r15d
	addq	$4, %rax
	movzbl	-2(%rax), %r14d
	xorb	-1(%rax), %r14b
	xorl	%edx, %r15d
	movl	%r15d, %r13d
	movl	%r15d, %r12d
	addl	%r15d, %r15d
	sarb	$7, %r13b
	xorl	%r14d, %r12d
	andl	$27, %r13d
	xorl	%r15d, %r13d
	movl	%edx, %r15d
	xorb	-1(%rax), %dl
	xorl	%r12d, %r15d
	xorl	%r15d, %r13d
	movzbl	-3(%rax), %r15d
	xorb	-2(%rax), %r15b
	movb	%r13b, -4(%rax)
	movl	%r15d, %r13d
	addl	%r15d, %r15d
	sarb	$7, %r13b
	andl	$27, %r13d
	xorl	%r15d, %r13d
	movzbl	-3(%rax), %r15d
	xorl	%r12d, %r15d
	xorl	%r15d, %r13d
	movb	%r13b, -3(%rax)
	movl	%r14d, %r13d
	addl	%r14d, %r14d
	sarb	$7, %r13b
	andl	$27, %r13d
	xorl	%r14d, %r13d
	movzbl	-2(%rax), %r14d
	xorl	%r12d, %r14d
	xorb	-1(%rax), %r12b
	xorl	%r14d, %r13d
	movb	%r13b, -2(%rax)
	movl	%edx, %r13d
	addl	%edx, %edx
	sarb	$7, %r13b
	andl	$27, %r13d
	xorl	%r13d, %edx
	xorl	%r12d, %edx
	movb	%dl, -1(%rax)
	cmpq	%rax, %rdi
	jne	.L33
	movq	%r10, %r13
	movq	%rcx, %rdx
.L35:
	xorl	%eax, %eax
.L36:
	movzbl	0(%r13,%rax), %r12d
	xorb	%r12b, (%rdx,%rax)
	addq	$1, %rax
	cmpq	$4, %rax
	jne	.L36
	addq	$4, %rdx
	addq	$4, %r13
	cmpq	%rdx, %rdi
	jne	.L35
	addq	$16, %r10
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L48:
	addq	$4, %r11
	addq	$4, %r8
	cmpq	%r11, %rbp
	je	.L26
.L34:
	xorl	%eax, %eax
.L38:
	movzbl	160(%r11,%rax), %edx
	xorb	%dl, (%r8,%rax)
	addq	$1, %rax
	cmpq	$4, %rax
	jne	.L38
	jmp	.L48
.L26:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE26:
	.size	Cipher, .-Cipher
	.p2align 4
	.globl	AES_init_ctx
	.type	AES_init_ctx, @function
AES_init_ctx:
.LFB15:
	.cfi_startproc
	endbr64
	jmp	KeyExpansion
	.cfi_endproc
.LFE15:
	.size	AES_init_ctx, .-AES_init_ctx
	.p2align 4
	.globl	AES_init_ctx_iv
	.type	AES_init_ctx_iv, @function
AES_init_ctx_iv:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	KeyExpansion
	movdqu	0(%rbp), %xmm0
	movups	%xmm0, 176(%rbx)
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE16:
	.size	AES_init_ctx_iv, .-AES_init_ctx_iv
	.p2align 4
	.globl	AES_ctx_set_iv
	.type	AES_ctx_set_iv, @function
AES_ctx_set_iv:
.LFB17:
	.cfi_startproc
	endbr64
	movdqu	(%rsi), %xmm0
	movups	%xmm0, 176(%rdi)
	ret
	.cfi_endproc
.LFE17:
	.size	AES_ctx_set_iv, .-AES_ctx_set_iv
	.p2align 4
	.globl	AES_ECB_encrypt
	.type	AES_ECB_encrypt, @function
AES_ECB_encrypt:
.LFB28:
	.cfi_startproc
	endbr64
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rax, %rsi
	jmp	Cipher
	.cfi_endproc
.LFE28:
	.size	AES_ECB_encrypt, .-AES_ECB_encrypt
	.p2align 4
	.globl	AES_ECB_decrypt
	.type	AES_ECB_decrypt, @function
AES_ECB_decrypt:
.LFB29:
	.cfi_startproc
	endbr64
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rax, %rsi
	jmp	InvCipher
	.cfi_endproc
.LFE29:
	.size	AES_ECB_decrypt, .-AES_ECB_decrypt
	.p2align 4
	.globl	AES_CBC_encrypt_buffer
	.type	AES_CBC_encrypt_buffer, @function
AES_CBC_encrypt_buffer:
.LFB31:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	leaq	176(%rdi), %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	xorl	%r13d, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	testq	%rdx, %rdx
	je	.L57
	.p2align 4,,10
	.p2align 3
.L56:
	leaq	(%r12,%r13), %rdi
	movq	%r14, %rcx
	xorl	%eax, %eax
	movq	%rdi, %r14
	.p2align 4,,10
	.p2align 3
.L58:
	movzbl	(%rcx,%rax), %edx
	xorb	%dl, (%rdi,%rax)
	addq	$1, %rax
	cmpq	$16, %rax
	jne	.L58
	movq	%rbx, %rsi
	addq	$16, %r13
	call	Cipher
	cmpq	%rbp, %r13
	jb	.L56
.L57:
	movdqu	(%r14), %xmm0
	movups	%xmm0, 176(%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE31:
	.size	AES_CBC_encrypt_buffer, .-AES_CBC_encrypt_buffer
	.p2align 4
	.globl	AES_CBC_decrypt_buffer
	.type	AES_CBC_decrypt_buffer, @function
AES_CBC_decrypt_buffer:
.LFB32:
	.cfi_startproc
	endbr64
	testq	%rdx, %rdx
	je	.L74
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rdx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	xorl	%r12d, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	.p2align 4,,10
	.p2align 3
.L67:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	movdqu	(%rbx), %xmm0
	call	InvCipher
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L66:
	movzbl	176(%rbp,%rax), %edx
	xorb	%dl, (%rbx,%rax)
	addq	$1, %rax
	cmpq	$16, %rax
	jne	.L66
	addq	$16, %r12
	movups	%xmm0, 176(%rbp)
	addq	$16, %rbx
	cmpq	%r13, %r12
	jb	.L67
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L74:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret
	.cfi_endproc
.LFE32:
	.size	AES_CBC_decrypt_buffer, .-AES_CBC_decrypt_buffer
	.p2align 4
	.globl	AES_CTR_xcrypt_buffer
	.type	AES_CTR_xcrypt_buffer, @function
AES_CTR_xcrypt_buffer:
.LFB33:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	(%rsi,%rdx), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L77
	movq	%rdi, %r12
	movq	%rsi, %rbx
	movl	$16, %ecx
	.p2align 4,,10
	.p2align 3
.L84:
	cmpl	$16, %ecx
	je	.L79
	movslq	%ecx, %rax
	addl	$1, %ecx
.L80:
	movzbl	(%rsp,%rax), %eax
	xorb	%al, (%rbx)
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	jne	.L84
.L77:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L91
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L79:
	.cfi_restore_state
	movdqu	176(%r12), %xmm0
	movq	%rsp, %rdi
	movq	%r12, %rsi
	movaps	%xmm0, (%rsp)
	call	Cipher
	movl	$15, %eax
.L82:
	movzbl	176(%r12,%rax), %edx
	cmpb	$-1, %dl
	je	.L92
	cltq
	addl	$1, %edx
	movb	%dl, 176(%r12,%rax)
.L83:
	movl	$1, %ecx
	xorl	%eax, %eax
	jmp	.L80
	.p2align 4,,10
	.p2align 3
.L92:
	movb	$0, 176(%r12,%rax)
	subq	$1, %rax
	jnb	.L82
	jmp	.L83
.L91:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE33:
	.size	AES_CTR_xcrypt_buffer, .-AES_CTR_xcrypt_buffer
	.section	.rodata
	.align 8
	.type	Rcon, @object
	.size	Rcon, 11
Rcon:
	.ascii	"\215\001\002\004\b\020 @\200\0336"
	.align 32
	.type	rsbox, @object
	.size	rsbox, 256
rsbox:
	.string	"R\tj\32506\2458\277@\243\236\201\363\327\373|\3439\202\233/\377\2074\216CD\304\336\351\313T{\2242\246\302#=\356L\225\013B\372\303N\b.\241f(\331$\262v[\242Im\213\321%r\370\366d\206h\230\026\324\244\\\314]e\266\222lpHP\375\355\271\332^\025FW\247\215\235\204\220\330\253"
	.ascii	"\214\274\323\n\367\344X\005\270\263E\006\320,\036\217\312?\017"
	.ascii	"\002\301\257\275\003\001\023\212k:\221\021AOg\334\352\227\362"
	.ascii	"\317\316\360\264\346s\226\254t\"\347\2555\205\342\3717\350\034"
	.ascii	"u\337nG\361\032q\035)\305\211o\267b\016\252\030\276\033\374V"
	.ascii	">K\306\322y \232\333\300\376x\315Z\364\037\335\2503\210\007\307"
	.ascii	"1\261\022\020Y'\200\354_`Q\177\251\031\265J\r-\345z\237\223\311"
	.ascii	"\234\357\240\340;M\256*\365\260\310\353\273<\203S\231a\027+\004"
	.ascii	"~\272w\326&\341i\024cU!\f}"
	.align 32
	.type	sbox, @object
	.size	sbox, 256
sbox:
	.string	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321"
	.ascii	"\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002"
	.ascii	"\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363"
	.ascii	"\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220"
	.ascii	"\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221"
	.ascii	"\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034"
	.ascii	"\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5"
	.ascii	"W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207"
	.ascii	"\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
