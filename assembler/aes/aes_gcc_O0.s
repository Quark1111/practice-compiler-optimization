	.file	"aes.c"
	.text
	.section	.rodata
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
	.align 8
	.type	Rcon, @object
	.size	Rcon, 11
Rcon:
	.ascii	"\215\001\002\004\b\020 @\200\0336"
	.text
	.type	KeyExpansion, @function
KeyExpansion:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$0, -24(%rbp)
	jmp	.L2
.L3:
	movl	-24(%rbp), %eax
	sall	$2, %eax
	movl	%eax, %edx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	movl	%edx, %ecx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movl	-24(%rbp), %eax
	sall	$2, %eax
	addl	$1, %eax
	movl	%eax, %edx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$1, %edx
	movl	%edx, %ecx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movl	-24(%rbp), %eax
	sall	$2, %eax
	addl	$2, %eax
	movl	%eax, %edx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$2, %edx
	movl	%edx, %ecx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	movl	-24(%rbp), %eax
	sall	$2, %eax
	addl	$3, %eax
	movl	%eax, %edx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movl	-24(%rbp), %edx
	sall	$2, %edx
	addl	$3, %edx
	movl	%edx, %ecx
	movq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	addl	$1, -24(%rbp)
.L2:
	cmpl	$3, -24(%rbp)
	jbe	.L3
	movl	$4, -24(%rbp)
	jmp	.L4
.L6:
	movl	-24(%rbp), %eax
	subl	$1, %eax
	sall	$2, %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -12(%rbp)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -11(%rbp)
	movl	-20(%rbp), %eax
	addl	$2, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -10(%rbp)
	movl	-20(%rbp), %eax
	addl	$3, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -9(%rbp)
	movl	-24(%rbp), %eax
	andl	$3, %eax
	testl	%eax, %eax
	jne	.L5
	movzbl	-12(%rbp), %eax
	movb	%al, -25(%rbp)
	movzbl	-11(%rbp), %eax
	movb	%al, -12(%rbp)
	movzbl	-10(%rbp), %eax
	movb	%al, -11(%rbp)
	movzbl	-9(%rbp), %eax
	movb	%al, -10(%rbp)
	movzbl	-25(%rbp), %eax
	movb	%al, -9(%rbp)
	movzbl	-12(%rbp), %eax
	movzbl	%al, %eax
	cltq
	leaq	sbox(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -12(%rbp)
	movzbl	-11(%rbp), %eax
	movzbl	%al, %eax
	cltq
	leaq	sbox(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -11(%rbp)
	movzbl	-10(%rbp), %eax
	movzbl	%al, %eax
	cltq
	leaq	sbox(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -10(%rbp)
	movzbl	-9(%rbp), %eax
	movzbl	%al, %eax
	cltq
	leaq	sbox(%rip), %rdx
	movzbl	(%rax,%rdx), %eax
	movb	%al, -9(%rbp)
	movzbl	-12(%rbp), %edx
	movl	-24(%rbp), %eax
	shrl	$2, %eax
	movl	%eax, %ecx
	leaq	Rcon(%rip), %rax
	movzbl	(%rcx,%rax), %eax
	xorl	%edx, %eax
	movb	%al, -12(%rbp)
.L5:
	movl	-24(%rbp), %eax
	sall	$2, %eax
	movl	%eax, -16(%rbp)
	movl	-24(%rbp), %eax
	subl	$4, %eax
	sall	$2, %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %esi
	movzbl	-12(%rbp), %ecx
	movl	-16(%rbp), %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	xorl	%ecx, %esi
	movl	%esi, %edx
	movb	%dl, (%rax)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %ecx
	movzbl	-11(%rbp), %edx
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	movq	-40(%rbp), %rax
	addq	%rsi, %rax
	xorl	%ecx, %edx
	movb	%dl, (%rax)
	movl	-20(%rbp), %eax
	addl	$2, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %ecx
	movzbl	-10(%rbp), %edx
	movl	-16(%rbp), %eax
	addl	$2, %eax
	movl	%eax, %esi
	movq	-40(%rbp), %rax
	addq	%rsi, %rax
	xorl	%ecx, %edx
	movb	%dl, (%rax)
	movl	-20(%rbp), %eax
	addl	$3, %eax
	movl	%eax, %edx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %ecx
	movzbl	-9(%rbp), %edx
	movl	-16(%rbp), %eax
	addl	$3, %eax
	movl	%eax, %esi
	movq	-40(%rbp), %rax
	addq	%rsi, %rax
	xorl	%ecx, %edx
	movb	%dl, (%rax)
	addl	$1, -24(%rbp)
.L4:
	cmpl	$43, -24(%rbp)
	jbe	.L6
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	KeyExpansion, .-KeyExpansion
	.globl	AES_init_ctx
	.type	AES_init_ctx, @function
AES_init_ctx:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	KeyExpansion
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	AES_init_ctx, .-AES_init_ctx
	.globl	AES_init_ctx_iv
	.type	AES_init_ctx_iv, @function
AES_init_ctx_iv:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	KeyExpansion
	movq	-8(%rbp), %rax
	leaq	176(%rax), %rcx
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	AES_init_ctx_iv, .-AES_init_ctx_iv
	.globl	AES_ctx_set_iv
	.type	AES_ctx_set_iv, @function
AES_ctx_set_iv:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	leaq	176(%rax), %rcx
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	AES_ctx_set_iv, .-AES_ctx_set_iv
	.type	AddRoundKey, @function
AddRoundKey:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movb	%al, -20(%rbp)
	movb	$0, -2(%rbp)
	jmp	.L12
.L15:
	movb	$0, -1(%rbp)
	jmp	.L13
.L14:
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %edx
	movq	-32(%rbp), %rcx
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %esi
	movzbl	-20(%rbp), %eax
	leal	0(,%rax,4), %edx
	movzbl	-2(%rbp), %eax
	addl	%edx, %eax
	leal	0(,%rax,4), %edx
	movzbl	-1(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %edx
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	xorl	%esi, %edx
	movq	-32(%rbp), %rsi
	movslq	%ecx, %rcx
	cltq
	salq	$2, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	%dl, (%rax)
	addb	$1, -1(%rbp)
.L13:
	cmpb	$3, -1(%rbp)
	jbe	.L14
	addb	$1, -2(%rbp)
.L12:
	cmpb	$3, -2(%rbp)
	jbe	.L15
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	AddRoundKey, .-AddRoundKey
	.type	SubBytes, @function
SubBytes:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movb	$0, -2(%rbp)
	jmp	.L17
.L20:
	movb	$0, -1(%rbp)
	jmp	.L18
.L19:
	movzbl	-1(%rbp), %eax
	movzbl	-2(%rbp), %edx
	movq	-24(%rbp), %rcx
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movzbl	-1(%rbp), %edi
	movzbl	-2(%rbp), %ecx
	cltq
	leaq	sbox(%rip), %rdx
	movzbl	(%rax,%rdx), %edx
	movq	-24(%rbp), %rsi
	movslq	%ecx, %rcx
	movslq	%edi, %rax
	salq	$2, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	%dl, (%rax)
	addb	$1, -1(%rbp)
.L18:
	cmpb	$3, -1(%rbp)
	jbe	.L19
	addb	$1, -2(%rbp)
.L17:
	cmpb	$3, -2(%rbp)
	jbe	.L20
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	SubBytes, .-SubBytes
	.type	ShiftRows, @function
ShiftRows:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movzbl	1(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	5(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 1(%rax)
	movq	-24(%rbp), %rax
	movzbl	9(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 5(%rax)
	movq	-24(%rbp), %rax
	movzbl	13(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 9(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 13(%rax)
	movq	-24(%rbp), %rax
	movzbl	2(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	10(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 2(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 10(%rax)
	movq	-24(%rbp), %rax
	movzbl	6(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	14(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 6(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 14(%rax)
	movq	-24(%rbp), %rax
	movzbl	3(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	15(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 3(%rax)
	movq	-24(%rbp), %rax
	movzbl	11(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 15(%rax)
	movq	-24(%rbp), %rax
	movzbl	7(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 11(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 7(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	ShiftRows, .-ShiftRows
	.type	xtime, @function
xtime:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, %eax
	movb	%al, -4(%rbp)
	movzbl	-4(%rbp), %eax
	leal	(%rax,%rax), %ecx
	movzbl	-4(%rbp), %eax
	shrb	$7, %al
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	leal	0(,%rax,8), %edx
	addl	%edx, %eax
	xorl	%ecx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	xtime, .-xtime
	.type	MixColumns, @function
MixColumns:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$24, %rsp
	movq	%rdi, -24(%rbp)
	movb	$0, -4(%rbp)
	jmp	.L25
.L26:
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %eax
	movb	%al, -3(%rbp)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %ecx
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %eax
	xorl	%eax, %ecx
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %eax
	xorl	%eax, %ecx
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -2(%rbp)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %ecx
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %ecx
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movzbl	-4(%rbp), %edx
	xorl	%eax, %ecx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movb	%cl, (%rax,%rdx,4)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %ecx
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %ecx
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movzbl	-4(%rbp), %edx
	xorl	%eax, %ecx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movb	%cl, 1(%rax,%rdx,4)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %ecx
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	xorl	%ecx, %eax
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %ecx
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movzbl	-4(%rbp), %edx
	xorl	%eax, %ecx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movb	%cl, 2(%rax,%rdx,4)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	xorb	-3(%rbp), %al
	movb	%al, -1(%rbp)
	movzbl	-1(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movb	%al, -1(%rbp)
	movzbl	-4(%rbp), %edx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %ecx
	movzbl	-1(%rbp), %eax
	xorb	-2(%rbp), %al
	movzbl	-4(%rbp), %edx
	xorl	%eax, %ecx
	movq	-24(%rbp), %rax
	movslq	%edx, %rdx
	movb	%cl, 3(%rax,%rdx,4)
	addb	$1, -4(%rbp)
.L25:
	cmpb	$3, -4(%rbp)
	jbe	.L26
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	MixColumns, .-MixColumns
	.type	InvMixColumns, @function
InvMixColumns:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -40(%rbp)
	movl	$0, -20(%rbp)
	jmp	.L28
.L29:
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	(%rax,%rdx,4), %eax
	movb	%al, -24(%rbp)
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	1(%rax,%rdx,4), %eax
	movb	%al, -23(%rbp)
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	2(%rax,%rdx,4), %eax
	movb	%al, -22(%rbp)
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movzbl	3(%rax,%rdx,4), %eax
	movb	%al, -21(%rbp)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-23(%rbp), %al
	movl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-22(%rbp), %al
	movl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ebx
	xorl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-21(%rbp), %al
	movl	%ebx, %ecx
	xorl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, (%rax,%rdx,4)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-24(%rbp), %al
	movl	%eax, %r12d
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-22(%rbp), %al
	movl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-21(%rbp), %al
	movl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ecx
	xorl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, 1(%rax,%rdx,4)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-24(%rbp), %al
	movl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-23(%rbp), %al
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	xorl	%eax, %r12d
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-21(%rbp), %al
	movl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ecx
	xorl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, 2(%rax,%rdx,4)
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	xorb	-24(%rbp), %al
	movl	%eax, %ebx
	movzbl	-24(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-23(%rbp), %al
	movl	%eax, %ebx
	movzbl	-23(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ebx
	xorl	%eax, %ebx
	movzbl	-22(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorb	-22(%rbp), %al
	xorl	%eax, %ebx
	movl	%ebx, %r12d
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%eax, %ebx
	movzbl	-21(%rbp), %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	movzbl	%al, %eax
	movl	%eax, %edi
	call	xtime
	xorl	%ebx, %eax
	movl	%r12d, %ecx
	xorl	%eax, %ecx
	movq	-40(%rbp), %rax
	movl	-20(%rbp), %edx
	movslq	%edx, %rdx
	movb	%cl, 3(%rax,%rdx,4)
	addl	$1, -20(%rbp)
.L28:
	cmpl	$3, -20(%rbp)
	jle	.L29
	nop
	nop
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	InvMixColumns, .-InvMixColumns
	.type	InvSubBytes, @function
InvSubBytes:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movb	$0, -2(%rbp)
	jmp	.L31
.L34:
	movb	$0, -1(%rbp)
	jmp	.L32
.L33:
	movzbl	-1(%rbp), %eax
	movzbl	-2(%rbp), %edx
	movq	-24(%rbp), %rcx
	movslq	%edx, %rdx
	cltq
	salq	$2, %rax
	addq	%rcx, %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movzbl	-1(%rbp), %edi
	movzbl	-2(%rbp), %ecx
	cltq
	leaq	rsbox(%rip), %rdx
	movzbl	(%rax,%rdx), %edx
	movq	-24(%rbp), %rsi
	movslq	%ecx, %rcx
	movslq	%edi, %rax
	salq	$2, %rax
	addq	%rsi, %rax
	addq	%rcx, %rax
	movb	%dl, (%rax)
	addb	$1, -1(%rbp)
.L32:
	cmpb	$3, -1(%rbp)
	jbe	.L33
	addb	$1, -2(%rbp)
.L31:
	cmpb	$3, -2(%rbp)
	jbe	.L34
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	InvSubBytes, .-InvSubBytes
	.type	InvShiftRows, @function
InvShiftRows:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movzbl	13(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	9(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 13(%rax)
	movq	-24(%rbp), %rax
	movzbl	5(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 9(%rax)
	movq	-24(%rbp), %rax
	movzbl	1(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 5(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 1(%rax)
	movq	-24(%rbp), %rax
	movzbl	2(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	10(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 2(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 10(%rax)
	movq	-24(%rbp), %rax
	movzbl	6(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	14(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 6(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 14(%rax)
	movq	-24(%rbp), %rax
	movzbl	3(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-24(%rbp), %rax
	movzbl	7(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 3(%rax)
	movq	-24(%rbp), %rax
	movzbl	11(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 7(%rax)
	movq	-24(%rbp), %rax
	movzbl	15(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, 11(%rax)
	movq	-24(%rbp), %rax
	movzbl	-1(%rbp), %edx
	movb	%dl, 15(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	InvShiftRows, .-InvShiftRows
	.type	Cipher, @function
Cipher:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movb	$0, -1(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	AddRoundKey
	movb	$1, -1(%rbp)
.L39:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	SubBytes
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	ShiftRows
	cmpb	$10, -1(%rbp)
	je	.L41
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	MixColumns
	movzbl	-1(%rbp), %eax
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	AddRoundKey
	addb	$1, -1(%rbp)
	jmp	.L39
.L41:
	nop
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$10, %edi
	call	AddRoundKey
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	Cipher, .-Cipher
	.type	InvCipher, @function
InvCipher:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movb	$0, -1(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$10, %edi
	call	AddRoundKey
	movb	$9, -1(%rbp)
.L45:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	InvShiftRows
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	InvSubBytes
	movzbl	-1(%rbp), %eax
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	AddRoundKey
	cmpb	$0, -1(%rbp)
	je	.L47
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	InvMixColumns
	subb	$1, -1(%rbp)
	jmp	.L45
.L47:
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	InvCipher, .-InvCipher
	.globl	AES_ECB_encrypt
	.type	AES_ECB_encrypt, @function
AES_ECB_encrypt:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	Cipher
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	AES_ECB_encrypt, .-AES_ECB_encrypt
	.globl	AES_ECB_decrypt
	.type	AES_ECB_decrypt, @function
AES_ECB_decrypt:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	InvCipher
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	AES_ECB_decrypt, .-AES_ECB_decrypt
	.type	XorWithIv, @function
XorWithIv:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movb	$0, -1(%rbp)
	jmp	.L51
.L52:
	movzbl	-1(%rbp), %edx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %esi
	movzbl	-1(%rbp), %edx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %ecx
	movzbl	-1(%rbp), %edx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	xorl	%ecx, %esi
	movl	%esi, %edx
	movb	%dl, (%rax)
	addb	$1, -1(%rbp)
.L51:
	cmpb	$15, -1(%rbp)
	jbe	.L52
	nop
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	XorWithIv, .-XorWithIv
	.globl	AES_CBC_encrypt_buffer
	.type	AES_CBC_encrypt_buffer, @function
AES_CBC_encrypt_buffer:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$40, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-24(%rbp), %rax
	addq	$176, %rax
	movq	%rax, -8(%rbp)
	movq	$0, -16(%rbp)
	jmp	.L54
.L55:
	movq	-8(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XorWithIv
	movq	-24(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	Cipher
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	addq	$16, -32(%rbp)
	addq	$16, -16(%rbp)
.L54:
	movq	-16(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.L55
	movq	-24(%rbp), %rax
	leaq	176(%rax), %rcx
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	AES_CBC_encrypt_buffer, .-AES_CBC_encrypt_buffer
	.globl	AES_CBC_decrypt_buffer
	.type	AES_CBC_decrypt_buffer, @function
AES_CBC_decrypt_buffer:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -40(%rbp)
	jmp	.L57
.L58:
	movq	-64(%rbp), %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	InvCipher
	movq	-56(%rbp), %rax
	leaq	176(%rax), %rdx
	movq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	XorWithIv
	movq	-56(%rbp), %rax
	leaq	176(%rax), %rcx
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rax, (%rcx)
	movq	%rdx, 8(%rcx)
	addq	$16, -64(%rbp)
	addq	$16, -40(%rbp)
.L57:
	movq	-40(%rbp), %rax
	cmpq	-72(%rbp), %rax
	jb	.L58
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L59
	call	__stack_chk_fail@PLT
.L59:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	AES_CBC_decrypt_buffer, .-AES_CBC_decrypt_buffer
	.globl	AES_CTR_xcrypt_buffer
	.type	AES_CTR_xcrypt_buffer, @function
AES_CTR_xcrypt_buffer:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -40(%rbp)
	movl	$16, -44(%rbp)
	jmp	.L61
.L68:
	cmpl	$16, -44(%rbp)
	jne	.L62
	movq	-56(%rbp), %rax
	addq	$176, %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-56(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	Cipher
	movl	$15, -44(%rbp)
	jmp	.L63
.L67:
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %eax
	cltq
	movzbl	176(%rdx,%rax), %eax
	cmpb	$-1, %al
	jne	.L64
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %eax
	cltq
	movb	$0, 176(%rdx,%rax)
	jmp	.L70
.L64:
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %eax
	cltq
	movzbl	176(%rdx,%rax), %eax
	leal	1(%rax), %ecx
	movq	-56(%rbp), %rdx
	movl	-44(%rbp), %eax
	cltq
	movb	%cl, 176(%rdx,%rax)
	jmp	.L66
.L70:
	subl	$1, -44(%rbp)
.L63:
	cmpl	$0, -44(%rbp)
	jns	.L67
.L66:
	movl	$0, -44(%rbp)
.L62:
	movq	-64(%rbp), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %esi
	movl	-44(%rbp), %eax
	cltq
	movzbl	-32(%rbp,%rax), %ecx
	movq	-64(%rbp), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	xorl	%ecx, %esi
	movl	%esi, %edx
	movb	%dl, (%rax)
	addq	$1, -40(%rbp)
	addl	$1, -44(%rbp)
.L61:
	movq	-40(%rbp), %rax
	cmpq	-72(%rbp), %rax
	jb	.L68
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L69
	call	__stack_chk_fail@PLT
.L69:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	AES_CTR_xcrypt_buffer, .-AES_CTR_xcrypt_buffer
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
