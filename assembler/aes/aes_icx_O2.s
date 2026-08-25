	.file	"aes.c"
	.text
	.globl	AES_init_ctx                    # -- Begin function AES_init_ctx
	.p2align	4
	.type	AES_init_ctx,@function
AES_init_ctx:                           # 
	.cfi_startproc
# %bb.0:
	jmp	KeyExpansion                    # TAILCALL
.Lfunc_end0:
	.size	AES_init_ctx, .Lfunc_end0-AES_init_ctx
	.cfi_endproc
                                        # -- End function
	.p2align	4                               # -- Begin function KeyExpansion
	.type	KeyExpansion,@function
KeyExpansion:                           # 
	.cfi_startproc
# %bb.0:
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
	movzbl	(%rsi), %eax
	movb	%al, (%rdi)
	movzbl	1(%rsi), %ebp
	movb	%bpl, 1(%rdi)
	movzbl	2(%rsi), %ebx
	movb	%bl, 2(%rdi)
	movzbl	3(%rsi), %r11d
	movb	%r11b, 3(%rdi)
	movzbl	4(%rsi), %r10d
	movb	%r10b, 4(%rdi)
	movzbl	5(%rsi), %r13d
	movb	%r13b, 5(%rdi)
	movb	%r13b, -43(%rsp)                # 1-byte Spill
	movzbl	6(%rsi), %r15d
	movb	%r15b, 6(%rdi)
	movb	%r15b, -41(%rsp)                # 1-byte Spill
	movzbl	7(%rsi), %r12d
	movb	%r12b, 7(%rdi)
	movb	%r12b, -32(%rsp)                # 1-byte Spill
	movzbl	8(%rsi), %ecx
	movb	%cl, -44(%rsp)                  # 1-byte Spill
	movb	%cl, 8(%rdi)
	movzbl	9(%rsi), %ecx
	movb	%cl, -46(%rsp)                  # 1-byte Spill
	movb	%cl, 9(%rdi)
	movzbl	10(%rsi), %ecx
	movb	%cl, -45(%rsp)                  # 1-byte Spill
	movb	%cl, 10(%rdi)
	movzbl	11(%rsi), %r14d
	movb	%r14b, 11(%rdi)
	movzbl	12(%rsi), %ecx
	movb	%cl, 12(%rdi)
	movzbl	13(%rsi), %edx
	movb	%dl, 13(%rdi)
	movzbl	14(%rsi), %r9d
	movb	%r9b, 14(%rdi)
	movq	%r9, -24(%rsp)                  # 8-byte Spill
	movzbl	15(%rsi), %esi
	movq	%rsi, -16(%rsp)                 # 8-byte Spill
	movb	%sil, 15(%rdi)
	xorb	sbox(%rdx), %al
	movq	%rdx, -40(%rsp)                 # 8-byte Spill
	xorb	$1, %al
	movb	%al, 16(%rdi)
	xorb	sbox(%r9), %bpl
	movb	%bpl, 17(%rdi)
	xorb	sbox(%rsi), %bl
	movb	%bl, 18(%rdi)
	xorb	sbox(%rcx), %r11b
	movb	%r11b, 19(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 20(%rdi)
	xorb	%bpl, %r13b
	movb	%r13b, 21(%rdi)
	xorb	%bl, %r15b
	movb	%r15b, 22(%rdi)
	movl	%r12d, %r9d
	xorb	%r11b, %r9b
	movb	%r9b, 23(%rdi)
	movzbl	-44(%rsp), %esi                 # 1-byte Folded Reload
	xorb	%r10b, %sil
	movb	%sil, 24(%rdi)
	xorb	-46(%rsp), %r13b                # 1-byte Folded Reload
	movb	%r13b, 25(%rdi)
	movb	%r13b, -42(%rsp)                # 1-byte Spill
	xorb	-45(%rsp), %r15b                # 1-byte Folded Reload
	movb	%r15b, 26(%rdi)
	movl	%r15d, %r12d
	movb	%r15b, -45(%rsp)                # 1-byte Spill
	xorb	%r14b, %r9b
	movb	%r9b, 27(%rdi)
	movl	%r9d, %r14d
	movb	%r9b, -46(%rsp)                 # 1-byte Spill
	xorb	%cl, %sil
	movb	%sil, 28(%rdi)
	movl	%edx, %ecx
	xorb	%r13b, %cl
	movb	%cl, 29(%rdi)
	movq	-24(%rsp), %r15                 # 8-byte Reload
	movl	%r15d, %r8d
	xorb	%r12b, %r8b
	movb	%r8b, 30(%rdi)
	movq	-16(%rsp), %r9                  # 8-byte Reload
	movl	%r9d, %r12d
	xorb	%r14b, %r12b
	movb	%r12b, 31(%rdi)
	movzbl	%cl, %ecx
	movzbl	%sil, %edx
	movq	%rdx, -8(%rsp)                  # 8-byte Spill
	movzbl	sbox(%rdx), %edx
	movzbl	%r12b, %esi
	movzbl	sbox(%rsi), %esi
	movzbl	%r8b, %r8d
	movzbl	sbox(%r8), %r8d
	xorb	sbox(%rcx), %al
	xorb	$2, %al
	movb	%al, 32(%rdi)
	xorb	%r8b, %bpl
	movb	%bpl, 33(%rdi)
	xorb	%sil, %bl
	movb	%bl, 34(%rdi)
	xorb	%dl, %r11b
	movb	%r11b, 35(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 36(%rdi)
	movzbl	-43(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r8b, %cl
	movb	%cl, 37(%rdi)
	movl	%ecx, %r8d
	movzbl	-41(%rsp), %r14d                # 1-byte Folded Reload
	xorb	%sil, %r14b
	movb	%r14b, 38(%rdi)
	movl	%r14d, %r13d
	movzbl	-32(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%dl, %cl
	movb	%cl, 39(%rdi)
	movl	%ecx, %r12d
	movzbl	-44(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%al, %cl
	movb	%cl, 40(%rdi)
	movl	%ecx, %edx
	movb	%cl, -44(%rsp)                  # 1-byte Spill
	movzbl	-42(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r8b, %cl
	movb	%cl, 41(%rdi)
	movzbl	-45(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r14b, %cl
	movb	%cl, 42(%rdi)
	movzbl	-46(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r12b, %cl
	movb	%cl, 43(%rdi)
	movq	-8(%rsp), %rcx                  # 8-byte Reload
                                        # kill: def $cl killed $cl killed $rcx
	xorb	%dl, %cl
	movb	%cl, 44(%rdi)
	movq	-40(%rsp), %rdx                 # 8-byte Reload
                                        # kill: def $dl killed $dl killed $rdx
	xorb	%r8b, %dl
	movl	%r8d, %r14d
	movb	%r8b, -43(%rsp)                 # 1-byte Spill
	movb	%dl, 45(%rdi)
	movl	%r15d, %esi
	xorb	%r13b, %sil
	movl	%r13d, %r15d
	movb	%sil, 46(%rdi)
	movl	%r9d, %r8d
	xorb	%r12b, %r8b
	movl	%r12d, %r9d
	movb	%r12b, -32(%rsp)                # 1-byte Spill
	movb	%r8b, 47(%rdi)
	movzbl	%dl, %r12d
	movzbl	%cl, %ecx
	movzbl	%r8b, %edx
	movzbl	%sil, %esi
	xorb	sbox(%r12), %al
	xorb	$4, %al
	movb	%al, 48(%rdi)
	xorb	sbox(%rsi), %bpl
	movb	%bpl, 49(%rdi)
	xorb	sbox(%rdx), %bl
	movb	%bl, 50(%rdi)
	xorb	sbox(%rcx), %r11b
	movb	%r11b, 51(%rdi)
	movl	%r10d, %r13d
	xorb	%al, %r13b
	movb	%r13b, 52(%rdi)
	xorb	%bpl, %r14b
	movb	%r14b, 53(%rdi)
	movl	%r15d, %ecx
	movl	%r15d, %r14d
	xorb	%bl, %cl
	movb	%cl, 54(%rdi)
	movl	%r9d, %ecx
	xorb	%r11b, %cl
	movb	%cl, 55(%rdi)
	movzbl	-44(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r13b, %cl
	movb	%cl, 56(%rdi)
	movzbl	-42(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%bpl, %cl
	movb	%cl, 57(%rdi)
	movl	%ecx, %r9d
	movb	%cl, -42(%rsp)                  # 1-byte Spill
	movzbl	-45(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%bl, %cl
	movb	%cl, 58(%rdi)
	movl	%ecx, %r15d
	movb	%cl, -45(%rsp)                  # 1-byte Spill
	movzbl	-46(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r11b, %cl
	movb	%cl, 59(%rdi)
	movl	%ecx, %r10d
	movb	%cl, -46(%rsp)                  # 1-byte Spill
	movq	-8(%rsp), %rcx                  # 8-byte Reload
	xorb	%r13b, %cl
	movb	%cl, 60(%rdi)
	movq	%rcx, %r8
	xorb	%r9b, %r12b
	movb	%r12b, 61(%rdi)
	xorb	%r15b, %sil
	movb	%sil, 62(%rdi)
	xorb	%r10b, %dl
	movb	%dl, 63(%rdi)
	movzbl	%r12b, %ecx
	movzbl	%r8b, %r12d
	movzbl	sbox(%r12), %r10d
	movzbl	%dl, %edx
	movzbl	sbox(%rdx), %r8d
	movzbl	%sil, %esi
	movzbl	sbox(%rsi), %esi
	xorb	sbox(%rcx), %al
	xorb	$8, %al
	movb	%al, 64(%rdi)
	xorb	%sil, %bpl
	movb	%bpl, 65(%rdi)
	xorb	%r8b, %bl
	movb	%bl, 66(%rdi)
	xorb	%r10b, %r11b
	movb	%r11b, 67(%rdi)
	xorb	%al, %r13b
	movb	%r13b, 68(%rdi)
	movzbl	-43(%rsp), %r15d                # 1-byte Folded Reload
	xorb	%sil, %r15b
	movb	%r15b, 69(%rdi)
	movb	%r15b, -43(%rsp)                # 1-byte Spill
	movl	%r14d, %edx
	xorb	%r8b, %dl
	movb	%dl, 70(%rdi)
	movb	%dl, -41(%rsp)                  # 1-byte Spill
	movzbl	-32(%rsp), %r9d                 # 1-byte Folded Reload
	xorb	%r10b, %r9b
	movb	%r9b, 71(%rdi)
	movl	%r9d, %r14d
	movzbl	-44(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%al, %cl
	movb	%cl, 72(%rdi)
	movl	%ecx, %r9d
	movzbl	-42(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r15b, %cl
	movb	%cl, 73(%rdi)
	movzbl	-45(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%dl, %cl
	movb	%cl, 74(%rdi)
	movzbl	-46(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r14b, %cl
	movl	%r14d, %r15d
	movb	%r14b, -32(%rsp)                # 1-byte Spill
	movb	%cl, 75(%rdi)
	movl	%r12d, %ecx
	xorb	%r9b, %cl
	movb	%r9b, -44(%rsp)                 # 1-byte Spill
	movb	%cl, 76(%rdi)
	xorb	-40(%rsp), %sil                 # 1-byte Folded Reload
	movb	%sil, 77(%rdi)
	xorb	-24(%rsp), %r8b                 # 1-byte Folded Reload
	movb	%r8b, 78(%rdi)
	xorb	-16(%rsp), %r10b                # 1-byte Folded Reload
	movb	%r10b, 79(%rdi)
	movzbl	%sil, %esi
	movzbl	%r8b, %r14d
	xorb	sbox(%rsi), %al
	movq	%rsi, -40(%rsp)                 # 8-byte Spill
	xorb	$16, %al
	movb	%al, 80(%rdi)
	xorb	sbox(%r14), %bpl
	movq	%r14, -16(%rsp)                 # 8-byte Spill
	movzbl	%r10b, %edx
	movb	%bpl, 81(%rdi)
	xorb	sbox(%rdx), %bl
	movq	%rdx, -24(%rsp)                 # 8-byte Spill
	movzbl	%cl, %ecx
	movb	%bl, 82(%rdi)
	xorb	sbox(%rcx), %r11b
	movb	%r11b, 83(%rdi)
	xorb	%al, %r13b
	movb	%r13b, 84(%rdi)
	movl	%r13d, %r10d
	movzbl	-43(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%bpl, %cl
	movb	%cl, 85(%rdi)
	movzbl	-41(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%bl, %cl
	movb	%cl, 86(%rdi)
	xorb	%r11b, %r15b
	movb	%r15b, 87(%rdi)
	movl	%r9d, %ecx
	xorb	%r13b, %cl
	movb	%cl, 88(%rdi)
	movzbl	-42(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%bpl, %cl
	movb	%cl, 89(%rdi)
	movl	%ecx, %r8d
	movb	%cl, -42(%rsp)                  # 1-byte Spill
	movzbl	-45(%rsp), %r13d                # 1-byte Folded Reload
	xorb	%bl, %r13b
	movb	%r13b, 90(%rdi)
	movb	%r13b, -45(%rsp)                # 1-byte Spill
	movzbl	-46(%rsp), %r9d                 # 1-byte Folded Reload
	xorb	%r11b, %r9b
	movb	%r9b, 91(%rdi)
	movb	%r9b, -46(%rsp)                 # 1-byte Spill
	xorb	%r10b, %r12b
	movb	%r12b, 92(%rdi)
	movl	%esi, %ecx
	xorb	%r8b, %cl
	movb	%cl, 93(%rdi)
	movl	%r14d, %esi
	xorb	%r13b, %sil
	movb	%sil, 94(%rdi)
	movl	%edx, %r8d
	xorb	%r9b, %r8b
	movb	%r8b, 95(%rdi)
	movzbl	%cl, %ecx
	movzbl	%r12b, %r9d
	movzbl	sbox(%r9), %edx
	movq	%r9, %r12
	movq	%r9, -8(%rsp)                   # 8-byte Spill
	movzbl	%r8b, %r8d
	movzbl	sbox(%r8), %r8d
	movzbl	%sil, %esi
	xorb	sbox(%rcx), %al
	movzbl	sbox(%rsi), %ecx
	xorb	$32, %al
	movb	%al, 96(%rdi)
	xorb	%cl, %bpl
	movb	%bpl, 97(%rdi)
	xorb	%r8b, %bl
	movb	%bl, 98(%rdi)
	xorb	%dl, %r11b
	movb	%r11b, 99(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 100(%rdi)
	movzbl	-43(%rsp), %r15d                # 1-byte Folded Reload
	xorb	%cl, %r15b
	movb	%r15b, 101(%rdi)
	movzbl	-41(%rsp), %r14d                # 1-byte Folded Reload
	xorb	%r8b, %r14b
	movb	%r14b, 102(%rdi)
	movzbl	-32(%rsp), %r13d                # 1-byte Folded Reload
	xorb	%dl, %r13b
	movb	%r13b, 103(%rdi)
	movzbl	-44(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%al, %cl
	movb	%cl, 104(%rdi)
	movl	%ecx, %edx
	movb	%cl, -44(%rsp)                  # 1-byte Spill
	movzbl	-42(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r15b, %cl
	movb	%cl, 105(%rdi)
	movzbl	-45(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r14b, %cl
	movb	%cl, 106(%rdi)
	movzbl	-46(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r13b, %cl
	movb	%cl, 107(%rdi)
	movl	%r12d, %r8d
	xorb	%dl, %r8b
	movb	%r8b, 108(%rdi)
	movq	-40(%rsp), %rcx                 # 8-byte Reload
                                        # kill: def $cl killed $cl killed $rcx
	xorb	%r15b, %cl
	movb	%r15b, -43(%rsp)                # 1-byte Spill
	movb	%cl, 109(%rdi)
	movq	-16(%rsp), %rdx                 # 8-byte Reload
	movl	%edx, %esi
	xorb	%r14b, %sil
	movb	%sil, 110(%rdi)
	movq	-24(%rsp), %rdx                 # 8-byte Reload
                                        # kill: def $dl killed $dl killed $rdx
	xorb	%r13b, %dl
	movb	%dl, 111(%rdi)
	movzbl	%cl, %r9d
	movzbl	%sil, %r12d
	xorb	sbox(%r9), %al
	xorb	$64, %al
	movb	%al, 112(%rdi)
	xorb	sbox(%r12), %bpl
	movzbl	%dl, %esi
	movb	%bpl, 113(%rdi)
	xorb	sbox(%rsi), %bl
	movzbl	%r8b, %edx
	movb	%bl, 114(%rdi)
	xorb	sbox(%rdx), %r11b
	movb	%r11b, 115(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 116(%rdi)
	movl	%r15d, %edx
	xorb	%bpl, %dl
	movb	%dl, 117(%rdi)
	movl	%r14d, %edx
	xorb	%bl, %dl
	movb	%dl, 118(%rdi)
	movl	%r13d, %edx
	xorb	%r11b, %dl
	movb	%dl, 119(%rdi)
	movzbl	-44(%rsp), %edx                 # 1-byte Folded Reload
	xorb	%r10b, %dl
	movb	%dl, 120(%rdi)
	movzbl	-42(%rsp), %r15d                # 1-byte Folded Reload
	xorb	%bpl, %r15b
	movb	%r15b, 121(%rdi)
	movzbl	-45(%rsp), %edx                 # 1-byte Folded Reload
	xorb	%bl, %dl
	movb	%dl, 122(%rdi)
	movl	%edx, %r8d
	movb	%dl, -45(%rsp)                  # 1-byte Spill
	movzbl	-46(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r11b, %cl
	movb	%cl, 123(%rdi)
	movb	%cl, -46(%rsp)                  # 1-byte Spill
	movq	-8(%rsp), %rdx                  # 8-byte Reload
	xorb	%r10b, %dl
	movb	%dl, 124(%rdi)
	xorb	%r15b, %r9b
	movb	%r15b, -42(%rsp)                # 1-byte Spill
	movb	%r9b, 125(%rdi)
	xorb	%r8b, %r12b
	movb	%r12b, 126(%rdi)
	xorb	%cl, %sil
	movb	%sil, 127(%rdi)
	movzbl	%r9b, %r8d
	movzbl	%dl, %ecx
	movq	%rcx, -32(%rsp)                 # 8-byte Spill
	movzbl	sbox(%rcx), %edx
	movzbl	%sil, %esi
	movzbl	sbox(%rsi), %esi
	movzbl	%r12b, %r12d
	movzbl	sbox(%r12), %r12d
	xorb	sbox(%r8), %al
	addb	$-128, %al
	movb	%al, 128(%rdi)
	xorb	%r12b, %bpl
	movb	%bpl, 129(%rdi)
	xorb	%sil, %bl
	movb	%bl, 130(%rdi)
	xorb	%dl, %r11b
	movb	%r11b, 131(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 132(%rdi)
	movzbl	-43(%rsp), %ecx                 # 1-byte Folded Reload
	xorb	%r12b, %cl
	movb	%cl, 133(%rdi)
	movb	%cl, -43(%rsp)                  # 1-byte Spill
	xorb	%sil, %r14b
	movb	%r14b, 134(%rdi)
	xorb	%dl, %r13b
	movb	%r13b, 135(%rdi)
	movzbl	-44(%rsp), %r9d                 # 1-byte Folded Reload
	xorb	%al, %r9b
	movb	%r9b, 136(%rdi)
	movb	%r9b, -44(%rsp)                 # 1-byte Spill
	movl	%r15d, %r8d
	xorb	%cl, %r8b
	movb	%r8b, 137(%rdi)
	movzbl	-45(%rsp), %r8d                 # 1-byte Folded Reload
	xorb	%r14b, %r8b
	movl	%r14d, %r15d
	movb	%r14b, -41(%rsp)                # 1-byte Spill
	movb	%r8b, 138(%rdi)
	movzbl	-46(%rsp), %r8d                 # 1-byte Folded Reload
	xorb	%r13b, %r8b
	movb	%r8b, 139(%rdi)
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	movl	%ecx, %r8d
	xorb	%r9b, %r8b
	movb	%r8b, 140(%rdi)
	movq	-40(%rsp), %r9                  # 8-byte Reload
	xorb	%r12b, %r9b
	movb	%r9b, 141(%rdi)
	movq	-16(%rsp), %r14                 # 8-byte Reload
	xorb	%sil, %r14b
	movb	%r14b, 142(%rdi)
	movq	-24(%rsp), %rsi                 # 8-byte Reload
	xorb	%dl, %sil
	movb	%sil, 143(%rdi)
	movzbl	%r9b, %ecx
	movzbl	%r8b, %edx
	movzbl	%r14b, %r8d
	xorb	sbox(%rcx), %al
	movq	%rcx, %r12
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	xorb	$27, %al
	movb	%al, 144(%rdi)
	xorb	sbox(%r8), %bpl
	movq	%r8, -24(%rsp)                  # 8-byte Spill
	movzbl	%sil, %ecx
	movq	%rcx, -40(%rsp)                 # 8-byte Spill
	movb	%bpl, 145(%rdi)
	xorb	sbox(%rcx), %bl
	movb	%bl, 146(%rdi)
	xorb	sbox(%rdx), %r11b
	movb	%r11b, 147(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 148(%rdi)
	movzbl	-43(%rsp), %edx                 # 1-byte Folded Reload
	xorb	%bpl, %dl
	movb	%dl, 149(%rdi)
	xorb	%bl, %r15b
	movb	%r15b, 150(%rdi)
	movl	%r13d, %edx
	xorb	%r11b, %dl
	movb	%dl, 151(%rdi)
	movzbl	-44(%rsp), %edx                 # 1-byte Folded Reload
	xorb	%r10b, %dl
	movb	%dl, 152(%rdi)
	movzbl	-42(%rsp), %r15d                # 1-byte Folded Reload
	xorb	%bpl, %r15b
	movb	%r15b, 153(%rdi)
	movzbl	-45(%rsp), %r14d                # 1-byte Folded Reload
	xorb	%bl, %r14b
	movb	%r14b, 154(%rdi)
	movzbl	-46(%rsp), %r9d                 # 1-byte Folded Reload
	xorb	%r11b, %r9b
	movb	%r9b, 155(%rdi)
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	xorb	%r10b, %cl
	movb	%cl, 156(%rdi)
	movl	%r12d, %edx
	xorb	%r15b, %dl
	movb	%dl, 157(%rdi)
	movl	%r8d, %esi
	xorb	%r14b, %sil
	movb	%sil, 158(%rdi)
	movq	-40(%rsp), %r8                  # 8-byte Reload
                                        # kill: def $r8b killed $r8b killed $r8
	xorb	%r9b, %r8b
	movb	%r8b, 159(%rdi)
	movzbl	%dl, %edx
	movzbl	%cl, %ecx
	movzbl	sbox(%rcx), %r12d
	movzbl	%r8b, %r8d
	movzbl	sbox(%r8), %r8d
	movzbl	%sil, %esi
	movzbl	sbox(%rsi), %esi
	xorb	sbox(%rdx), %al
	xorb	$54, %al
	movb	%al, 160(%rdi)
	xorb	%sil, %bpl
	movb	%bpl, 161(%rdi)
	xorb	%r8b, %bl
	movb	%bl, 162(%rdi)
	xorb	%r12b, %r11b
	movb	%r11b, 163(%rdi)
	xorb	%al, %r10b
	movb	%r10b, 164(%rdi)
	movzbl	-43(%rsp), %edx                 # 1-byte Folded Reload
	xorb	%sil, %dl
	movb	%dl, 165(%rdi)
	movl	%edx, %esi
	movzbl	-41(%rsp), %edx                 # 1-byte Folded Reload
	xorb	%r8b, %dl
	movb	%dl, 166(%rdi)
	xorb	%r12b, %r13b
	movb	%r13b, 167(%rdi)
	xorb	-44(%rsp), %al                  # 1-byte Folded Reload
	movb	%al, 168(%rdi)
	xorb	%sil, %r15b
	movb	%r15b, 169(%rdi)
	xorb	%dl, %r14b
	movb	%r14b, 170(%rdi)
	xorb	%r13b, %r9b
	movb	%r9b, 171(%rdi)
	xorb	%al, %cl
	movb	%cl, 172(%rdi)
	xorb	-16(%rsp), %sil                 # 1-byte Folded Reload
	movb	%sil, 173(%rdi)
	xorb	-24(%rsp), %dl                  # 1-byte Folded Reload
	movb	%dl, 174(%rdi)
	xorb	-40(%rsp), %r13b                # 1-byte Folded Reload
	movb	%r13b, 175(%rdi)
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
.Lfunc_end1:
	.size	KeyExpansion, .Lfunc_end1-KeyExpansion
	.cfi_endproc
                                        # -- End function
	.globl	AES_init_ctx_iv                 # -- Begin function AES_init_ctx_iv
	.p2align	4
	.type	AES_init_ctx_iv,@function
AES_init_ctx_iv:                        # 
	.cfi_startproc
# %bb.0:
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
	.p2align	4
	.type	AES_ctx_set_iv,@function
AES_ctx_set_iv:                         # 
	.cfi_startproc
# %bb.0:
	movups	(%rsi), %xmm0
	movups	%xmm0, 176(%rdi)
	retq
.Lfunc_end3:
	.size	AES_ctx_set_iv, .Lfunc_end3-AES_ctx_set_iv
	.cfi_endproc
                                        # -- End function
	.globl	AES_ECB_encrypt                 # -- Begin function AES_ECB_encrypt
	.p2align	4
	.type	AES_ECB_encrypt,@function
AES_ECB_encrypt:                        # 
	.cfi_startproc
# %bb.0:
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
	.text
	.p2align	4
	.type	Cipher,@function
Cipher:                                 # 
	.cfi_startproc
# %bb.0:
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
	leaq	15(%rdi), %rax
	cmpq	%rsi, %rax
	jb	.LBB5_13
# %bb.1:
	leaq	15(%rsi), %rax
	cmpq	%rdi, %rax
	jb	.LBB5_13
# %bb.2:
	xorl	%edx, %edx
	movq	%rdi, %rax
	movq	%rsi, %rcx
	.p2align	4
.LBB5_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_4 Depth 2
	xorl	%r9d, %r9d
	.p2align	4
.LBB5_4:                                #   Parent Loop BB5_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rcx,%r9), %r8d
	xorb	%r8b, (%rax,%r9)
	incq	%r9
	cmpq	$4, %r9
	jne	.LBB5_4
# %bb.5:                                #   in Loop: Header=BB5_3 Depth=1
	addq	$4, %rcx
	addq	$4, %rax
	cmpq	$3, %rdx
	leaq	1(%rdx), %rdx
	jne	.LBB5_3
	jmp	.LBB5_14
.LBB5_13:
	movdqu	(%rdi), %xmm0
	movdqu	(%rsi), %xmm1
	pxor	%xmm0, %xmm1
	movdqu	%xmm1, (%rdi)
.LBB5_14:
	movq	%rsi, -80(%rsp)                 # 8-byte Spill
	leaq	16(%rsi), %rax
	movq	%rax, -96(%rsp)                 # 8-byte Spill
	movl	$1, %eax
	movq	%rax, -88(%rsp)                 # 8-byte Spill
	movdqa	.LCPI5_0(%rip), %xmm0           # xmm0 = [27,27,27,27,u,u,u,u,u,u,u,u,u,u,u,u]
	jmp	.LBB5_6
	.p2align	4
.LBB5_15:                               #   in Loop: Header=BB5_6 Depth=1
	movdqu	(%rdi), %xmm1
	movdqu	(%rax), %xmm2
	pxor	%xmm1, %xmm2
	movdqu	%xmm2, (%rdi)
	movq	-96(%rsp), %r10                 # 8-byte Reload
.LBB5_16:                               #   in Loop: Header=BB5_6 Depth=1
	incq	%r9
	movq	%r9, -88(%rsp)                  # 8-byte Spill
	addq	$16, %r10
	movq	%r10, -96(%rsp)                 # 8-byte Spill
.LBB5_6:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_10 Depth 2
                                        #       Child Loop BB5_11 Depth 3
	movzbl	(%rdi), %eax
	movzbl	sbox(%rax), %eax
	movb	%al, -99(%rsp)                  # 1-byte Spill
	movb	%al, (%rdi)
	movzbl	4(%rdi), %eax
	movzbl	sbox(%rax), %eax
	movb	%al, -97(%rsp)                  # 1-byte Spill
	movb	%al, 4(%rdi)
	movzbl	8(%rdi), %eax
	movzbl	sbox(%rax), %eax
	movb	%al, -98(%rsp)                  # 1-byte Spill
	movb	%al, 8(%rdi)
	movzbl	12(%rdi), %eax
	movzbl	sbox(%rax), %r13d
	movb	%r13b, 12(%rdi)
	movzbl	1(%rdi), %eax
	movzbl	sbox(%rax), %edx
	movzbl	5(%rdi), %ecx
	movzbl	sbox(%rcx), %ebp
	movzbl	9(%rdi), %ecx
	movzbl	sbox(%rcx), %r15d
	movzbl	13(%rdi), %ecx
	movzbl	sbox(%rcx), %eax
	movzbl	2(%rdi), %ecx
	movzbl	sbox(%rcx), %ebx
	movzbl	6(%rdi), %ecx
	movzbl	sbox(%rcx), %r14d
	movzbl	10(%rdi), %ecx
	movzbl	sbox(%rcx), %r12d
	movzbl	14(%rdi), %ecx
	movzbl	sbox(%rcx), %esi
	movzbl	3(%rdi), %ecx
	movzbl	sbox(%rcx), %r11d
	movzbl	7(%rdi), %r8d
	movzbl	sbox(%r8), %r8d
	movzbl	11(%rdi), %r9d
	movzbl	sbox(%r9), %r10d
	movzbl	15(%rdi), %r9d
	movzbl	sbox(%r9), %ecx
	movb	%bpl, 1(%rdi)
	movb	%r15b, 5(%rdi)
	movb	%al, 9(%rdi)
	movb	%dl, 13(%rdi)
	movb	%r12b, 2(%rdi)
	movb	%bl, 10(%rdi)
	movb	%sil, 6(%rdi)
	movb	%r14b, 14(%rdi)
	movb	%cl, 3(%rdi)
	movb	%r10b, 15(%rdi)
	movb	%r8b, 11(%rdi)
	movb	%r11b, 7(%rdi)
	movq	-88(%rsp), %r9                  # 8-byte Reload
	cmpq	$10, %r9
	je	.LBB5_17
# %bb.7:                                #   in Loop: Header=BB5_6 Depth=1
	movd	(%rdi), %xmm2                   # xmm2 = mem[0],zero,zero,zero
	movdqa	%xmm2, %xmm1
	psrld	$8, %xmm1
	movdqa	%xmm2, %xmm3
	pslld	$24, %xmm3
	por	%xmm1, %xmm3
	pxor	%xmm2, %xmm3
	movdqa	%xmm3, -72(%rsp)
	movzbl	-70(%rsp), %eax
	xorb	-72(%rsp), %al
	pxor	%xmm4, %xmm4
	pcmpgtb	%xmm3, %xmm4
	paddb	%xmm3, %xmm3
	pand	%xmm0, %xmm4
	movzbl	%al, %eax
	movd	%eax, %xmm1
	punpcklbw	%xmm1, %xmm1            # xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm1, %xmm1                # xmm1 = xmm1[0,0,0,0,4,5,6,7]
	pxor	%xmm3, %xmm1
	pxor	%xmm4, %xmm1
	movd	8(%rdi), %xmm3                  # xmm3 = mem[0],zero,zero,zero
	movdqa	%xmm3, %xmm4
	psrld	$8, %xmm4
	movdqa	%xmm3, %xmm5
	pslld	$24, %xmm5
	por	%xmm4, %xmm5
	pxor	%xmm3, %xmm5
	movdqa	%xmm5, -40(%rsp)
	movzbl	-38(%rsp), %eax
	xorb	-40(%rsp), %al
	pxor	%xmm2, %xmm1
	pxor	%xmm4, %xmm4
	pcmpgtb	%xmm5, %xmm4
	paddb	%xmm5, %xmm5
	pand	%xmm0, %xmm4
	movzbl	%al, %eax
	movd	%eax, %xmm2
	punpcklbw	%xmm2, %xmm2            # xmm2 = xmm2[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm2, %xmm2                # xmm2 = xmm2[0,0,0,0,4,5,6,7]
	pxor	%xmm5, %xmm2
	pxor	%xmm4, %xmm2
	pxor	%xmm3, %xmm2
	movd	12(%rdi), %xmm3                 # xmm3 = mem[0],zero,zero,zero
	movdqa	%xmm3, %xmm4
	psrld	$8, %xmm4
	movdqa	%xmm3, %xmm5
	pslld	$24, %xmm5
	por	%xmm4, %xmm5
	pxor	%xmm3, %xmm5
	movdqa	%xmm5, -56(%rsp)
	movzbl	-54(%rsp), %eax
	xorb	-56(%rsp), %al
	pxor	%xmm4, %xmm4
	pcmpgtb	%xmm5, %xmm4
	paddb	%xmm5, %xmm5
	pand	%xmm0, %xmm4
	movzbl	%al, %eax
	movd	%eax, %xmm6
	punpcklbw	%xmm6, %xmm6            # xmm6 = xmm6[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm6, %xmm6                # xmm6 = xmm6[0,0,0,0,4,5,6,7]
	pxor	%xmm5, %xmm6
	pxor	%xmm4, %xmm6
	pxor	%xmm3, %xmm6
	punpckldq	%xmm6, %xmm2            # xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1]
	movd	4(%rdi), %xmm3                  # xmm3 = mem[0],zero,zero,zero
	movdqa	%xmm3, %xmm4
	psrld	$8, %xmm4
	movdqa	%xmm3, %xmm5
	pslld	$24, %xmm5
	por	%xmm4, %xmm5
	pxor	%xmm3, %xmm5
	movdqa	%xmm5, -24(%rsp)
	movzbl	-22(%rsp), %eax
	xorb	-24(%rsp), %al
	pxor	%xmm4, %xmm4
	pcmpgtb	%xmm5, %xmm4
	paddb	%xmm5, %xmm5
	pand	%xmm0, %xmm4
	movzbl	%al, %eax
	movd	%eax, %xmm6
	punpcklbw	%xmm6, %xmm6            # xmm6 = xmm6[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
	pshuflw	$0, %xmm6, %xmm6                # xmm6 = xmm6[0,0,0,0,4,5,6,7]
	pxor	%xmm5, %xmm6
	pxor	%xmm4, %xmm6
	pxor	%xmm3, %xmm6
	punpckldq	%xmm6, %xmm1            # xmm1 = xmm1[0],xmm6[0],xmm1[1],xmm6[1]
	punpcklqdq	%xmm2, %xmm1            # xmm1 = xmm1[0],xmm2[0]
	movdqu	%xmm1, (%rdi)
	movq	%r9, %rcx
	shlq	$4, %rcx
	movq	-80(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rcx), %rax
	leaq	15(%rdi), %rsi
	cmpq	%rax, %rsi
	jb	.LBB5_15
# %bb.8:                                #   in Loop: Header=BB5_6 Depth=1
	addq	%rdx, %rcx
	addq	$15, %rcx
	cmpq	%rdi, %rcx
	jb	.LBB5_15
# %bb.9:                                #   in Loop: Header=BB5_6 Depth=1
	movq	%rdi, %rax
	movq	-96(%rsp), %r10                 # 8-byte Reload
	movq	%r10, %rcx
	xorl	%edx, %edx
	.p2align	4
.LBB5_10:                               #   Parent Loop BB5_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB5_11 Depth 3
	xorl	%esi, %esi
	.p2align	4
.LBB5_11:                               #   Parent Loop BB5_6 Depth=1
                                        #     Parent Loop BB5_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	(%rcx,%rsi), %r8d
	xorb	%r8b, (%rax,%rsi)
	incq	%rsi
	cmpq	$4, %rsi
	jne	.LBB5_11
# %bb.12:                               #   in Loop: Header=BB5_10 Depth=2
	addq	$4, %rcx
	addq	$4, %rax
	cmpq	$3, %rdx
	leaq	1(%rdx), %rdx
	jne	.LBB5_10
	jmp	.LBB5_16
.LBB5_17:
	movb	%dl, -105(%rsp)                 # 1-byte Spill
	movb	%r11b, -104(%rsp)               # 1-byte Spill
	movb	%cl, -103(%rsp)                 # 1-byte Spill
	movb	%sil, -102(%rsp)                # 1-byte Spill
	movb	%al, -101(%rsp)                 # 1-byte Spill
	movb	%r12b, -100(%rsp)               # 1-byte Spill
	movb	%r15b, -96(%rsp)                # 1-byte Spill
	movzbl	-98(%rsp), %esi                 # 1-byte Folded Reload
	movb	%bpl, -88(%rsp)                 # 1-byte Spill
	movzbl	-97(%rsp), %ecx                 # 1-byte Folded Reload
	movq	-80(%rsp), %rax                 # 8-byte Reload
	leaq	160(%rax), %r9
	leaq	15(%rdi), %r11
	cmpq	%r9, %r11
	jb	.LBB5_24
# %bb.18:
	addq	$175, %rax
	cmpq	%rdi, %rax
	jb	.LBB5_24
# %bb.19:
	xorl	%eax, %eax
	.p2align	4
.LBB5_20:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_21 Depth 2
	xorl	%ecx, %ecx
	.p2align	4
.LBB5_21:                               #   Parent Loop BB5_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%r9,%rcx), %edx
	xorb	%dl, (%rdi,%rcx)
	incq	%rcx
	cmpq	$4, %rcx
	jne	.LBB5_21
# %bb.22:                               #   in Loop: Header=BB5_20 Depth=1
	addq	$4, %r9
	addq	$4, %rdi
	cmpq	$3, %rax
	leaq	1(%rax), %rax
	jne	.LBB5_20
	jmp	.LBB5_23
.LBB5_24:
	movdqu	(%r9), %xmm0
	movzbl	%r10b, %r9d
	movd	%r9d, %xmm1
	movzbl	%r14b, %edx
	movd	%edx, %xmm2
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movzbl	-105(%rsp), %eax                # 1-byte Folded Reload
	movd	%eax, %xmm1
	movzbl	%r13b, %eax
	movd	%eax, %xmm3
	punpcklbw	%xmm1, %xmm3            # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3],xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
	punpcklwd	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movzbl	%r8b, %eax
	movd	%eax, %xmm1
	movzbl	%bl, %eax
	movd	%eax, %xmm2
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movzbl	-101(%rsp), %eax                # 1-byte Folded Reload
	movd	%eax, %xmm4
	movzbl	%sil, %eax
	movd	%eax, %xmm1
	punpcklbw	%xmm4, %xmm1            # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3],xmm1[4],xmm4[4],xmm1[5],xmm4[5],xmm1[6],xmm4[6],xmm1[7],xmm4[7]
	punpcklwd	%xmm2, %xmm1            # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1],xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	punpckldq	%xmm3, %xmm1            # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
	movzbl	-104(%rsp), %eax                # 1-byte Folded Reload
	movd	%eax, %xmm2
	movzbl	-102(%rsp), %eax                # 1-byte Folded Reload
	movd	%eax, %xmm3
	punpcklbw	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	movzbl	-96(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm2
	movzbl	%cl, %eax
	movd	%eax, %xmm4
	punpcklbw	%xmm2, %xmm4            # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3],xmm4[4],xmm2[4],xmm4[5],xmm2[5],xmm4[6],xmm2[6],xmm4[7],xmm2[7]
	punpcklwd	%xmm3, %xmm4            # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3]
	movzbl	-103(%rsp), %eax                # 1-byte Folded Reload
	movd	%eax, %xmm2
	movzbl	-100(%rsp), %eax                # 1-byte Folded Reload
	movd	%eax, %xmm3
	punpcklbw	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	movzbl	-88(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm2
	movzbl	-99(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm5
	punpcklbw	%xmm2, %xmm5            # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1],xmm5[2],xmm2[2],xmm5[3],xmm2[3],xmm5[4],xmm2[4],xmm5[5],xmm2[5],xmm5[6],xmm2[6],xmm5[7],xmm2[7]
	punpcklwd	%xmm3, %xmm5            # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1],xmm5[2],xmm3[2],xmm5[3],xmm3[3]
	punpckldq	%xmm4, %xmm5            # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
	punpcklqdq	%xmm1, %xmm5            # xmm5 = xmm5[0],xmm1[0]
	pxor	%xmm0, %xmm5
	movdqu	%xmm5, (%rdi)
.LBB5_23:
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
	.p2align	4
	.type	AES_ECB_decrypt,@function
AES_ECB_decrypt:                        # 
	.cfi_startproc
# %bb.0:
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rax, %rsi
	jmp	InvCipher                       # TAILCALL
.Lfunc_end6:
	.size	AES_ECB_decrypt, .Lfunc_end6-AES_ECB_decrypt
	.cfi_endproc
                                        # -- End function
	.p2align	4                               # -- Begin function InvCipher
	.type	InvCipher,@function
InvCipher:                              # 
	.cfi_startproc
# %bb.0:
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
	leaq	15(%rdi), %rcx
	leaq	160(%rsi), %rax
	movq	%rcx, -16(%rsp)                 # 8-byte Spill
	cmpq	%rax, %rcx
	jb	.LBB7_15
# %bb.1:
	leaq	175(%rsi), %rcx
	cmpq	%rdi, %rcx
	jb	.LBB7_15
# %bb.2:
	xorl	%edx, %edx
	movq	%rdi, %rcx
	.p2align	4
.LBB7_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_4 Depth 2
	xorl	%r8d, %r8d
	.p2align	4
.LBB7_4:                                #   Parent Loop BB7_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rax,%r8), %r9d
	xorb	%r9b, (%rcx,%r8)
	incq	%r8
	cmpq	$4, %r8
	jne	.LBB7_4
# %bb.5:                                #   in Loop: Header=BB7_3 Depth=1
	addq	$4, %rax
	addq	$4, %rcx
	cmpq	$3, %rdx
	leaq	1(%rdx), %rdx
	jne	.LBB7_3
	jmp	.LBB7_16
.LBB7_15:
	movdqu	(%rdi), %xmm0
	movdqu	(%rax), %xmm1
	pxor	%xmm0, %xmm1
	movdqu	%xmm1, (%rdi)
.LBB7_16:
	movq	%rsi, -8(%rsp)                  # 8-byte Spill
	leaq	144(%rsi), %rax
	movq	%rax, -32(%rsp)                 # 8-byte Spill
	movl	$9, %eax
	movq	%rax, -24(%rsp)                 # 8-byte Spill
	.p2align	4
.LBB7_6:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB7_9 Depth 2
                                        #       Child Loop BB7_10 Depth 3
                                        #     Child Loop BB7_12 Depth 2
	movzbl	13(%rdi), %ecx
	movzbl	9(%rdi), %edx
	movzbl	5(%rdi), %esi
	movzbl	1(%rdi), %r10d
	movzbl	2(%rdi), %r15d
	movq	%rdi, %rbx
	movzbl	10(%rdi), %r9d
	movzbl	6(%rdi), %edi
	movzbl	14(%rbx), %r12d
	movzbl	3(%rbx), %eax
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	movzbl	7(%rbx), %r13d
	movzbl	11(%rbx), %eax
	movzbl	15(%rbx), %r8d
	movzbl	(%rbx), %r11d
	movzbl	rsbox(%r11), %r11d
	movb	%r11b, -48(%rsp)                # 1-byte Spill
	movb	%r11b, (%rbx)
	movzbl	4(%rbx), %r11d
	movzbl	rsbox(%r11), %r11d
	movb	%r11b, -57(%rsp)                # 1-byte Spill
	movb	%r11b, 4(%rbx)
	movzbl	8(%rbx), %r11d
	movzbl	rsbox(%r11), %r11d
	movb	%r11b, 8(%rbx)
	movzbl	12(%rbx), %r14d
	movzbl	rsbox(%r14), %r14d
	movb	%r14b, 12(%rbx)
	movzbl	rsbox(%rcx), %ecx
	movb	%cl, -56(%rsp)                  # 1-byte Spill
	movb	%cl, 1(%rbx)
	movzbl	rsbox(%r10), %ecx
	movb	%cl, -59(%rsp)                  # 1-byte Spill
	movb	%cl, 5(%rbx)
	movzbl	rsbox(%rsi), %esi
	movb	%sil, 9(%rbx)
	movzbl	rsbox(%rdx), %ecx
	movb	%cl, 13(%rbx)
	movzbl	rsbox(%r9), %edx
	movb	%dl, -58(%rsp)                  # 1-byte Spill
	movb	%dl, 2(%rbx)
	movzbl	rsbox(%r12), %ebp
	movb	%bpl, 6(%rbx)
	movzbl	rsbox(%r15), %r12d
	movb	%r12b, 10(%rbx)
	movzbl	rsbox(%rdi), %edi
	movb	%dil, 14(%rbx)
	movzbl	rsbox(%r13), %r10d
	movb	%r10b, 3(%rbx)
	movzbl	rsbox(%rax), %edx
	movb	%dl, 7(%rbx)
	movzbl	rsbox(%r8), %eax
	movb	%al, 11(%rbx)
	movq	-40(%rsp), %r8                  # 8-byte Reload
	movzbl	rsbox(%r8), %r8d
	movb	%r8b, 15(%rbx)
	movq	-24(%rsp), %r13                 # 8-byte Reload
	shlq	$4, %r13
	movq	-8(%rsp), %r9                   # 8-byte Reload
	leaq	(%r9,%r13), %r15
	cmpq	%r15, -16(%rsp)                 # 8-byte Folded Reload
	jb	.LBB7_17
# %bb.7:                                #   in Loop: Header=BB7_6 Depth=1
	addq	%r9, %r13
	addq	$15, %r13
	cmpq	%rbx, %r13
	jb	.LBB7_17
# %bb.8:                                #   in Loop: Header=BB7_6 Depth=1
	movq	%rbx, %rax
	movq	-32(%rsp), %rcx                 # 8-byte Reload
	xorl	%edx, %edx
	movq	%rbx, %rdi
	.p2align	4
.LBB7_9:                                #   Parent Loop BB7_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB7_10 Depth 3
	xorl	%esi, %esi
	.p2align	4
.LBB7_10:                               #   Parent Loop BB7_6 Depth=1
                                        #     Parent Loop BB7_9 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	(%rcx,%rsi), %r8d
	xorb	%r8b, (%rax,%rsi)
	incq	%rsi
	cmpq	$4, %rsi
	jne	.LBB7_10
# %bb.11:                               #   in Loop: Header=BB7_9 Depth=2
	addq	$4, %rcx
	addq	$4, %rax
	cmpq	$3, %rdx
	leaq	1(%rdx), %rdx
	jne	.LBB7_9
# %bb.18:                               #   in Loop: Header=BB7_6 Depth=1
	subq	$1, -24(%rsp)                   # 8-byte Folded Spill
	jae	.LBB7_19
	jmp	.LBB7_14
	.p2align	4
.LBB7_17:                               #   in Loop: Header=BB7_6 Depth=1
	movdqu	(%r15), %xmm0
	movzbl	%r8b, %r8d
	movd	%r8d, %xmm1
	movzbl	%dil, %edi
	movd	%edi, %xmm2
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movzbl	%cl, %ecx
	movd	%ecx, %xmm1
	movzbl	%r14b, %ecx
	movd	%ecx, %xmm3
	punpcklbw	%xmm1, %xmm3            # xmm3 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3],xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
	punpcklwd	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
	movzbl	%al, %eax
	movd	%eax, %xmm1
	movzbl	%r12b, %eax
	movd	%eax, %xmm2
	punpcklbw	%xmm1, %xmm2            # xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3],xmm2[4],xmm1[4],xmm2[5],xmm1[5],xmm2[6],xmm1[6],xmm2[7],xmm1[7]
	movzbl	%sil, %eax
	movd	%eax, %xmm4
	movzbl	%r11b, %eax
	movd	%eax, %xmm1
	punpcklbw	%xmm4, %xmm1            # xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1],xmm1[2],xmm4[2],xmm1[3],xmm4[3],xmm1[4],xmm4[4],xmm1[5],xmm4[5],xmm1[6],xmm4[6],xmm1[7],xmm4[7]
	punpcklwd	%xmm2, %xmm1            # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1],xmm1[2],xmm2[2],xmm1[3],xmm2[3]
	punpckldq	%xmm3, %xmm1            # xmm1 = xmm1[0],xmm3[0],xmm1[1],xmm3[1]
	movzbl	%dl, %eax
	movd	%eax, %xmm2
	movzbl	%bpl, %eax
	movd	%eax, %xmm3
	punpcklbw	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	movzbl	-59(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm2
	movzbl	-57(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm4
	punpcklbw	%xmm2, %xmm4            # xmm4 = xmm4[0],xmm2[0],xmm4[1],xmm2[1],xmm4[2],xmm2[2],xmm4[3],xmm2[3],xmm4[4],xmm2[4],xmm4[5],xmm2[5],xmm4[6],xmm2[6],xmm4[7],xmm2[7]
	punpcklwd	%xmm3, %xmm4            # xmm4 = xmm4[0],xmm3[0],xmm4[1],xmm3[1],xmm4[2],xmm3[2],xmm4[3],xmm3[3]
	movzbl	%r10b, %eax
	movd	%eax, %xmm2
	movzbl	-58(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm3
	punpcklbw	%xmm2, %xmm3            # xmm3 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3],xmm3[4],xmm2[4],xmm3[5],xmm2[5],xmm3[6],xmm2[6],xmm3[7],xmm2[7]
	movzbl	-56(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm2
	movzbl	-48(%rsp), %eax                 # 1-byte Folded Reload
	movd	%eax, %xmm5
	punpcklbw	%xmm2, %xmm5            # xmm5 = xmm5[0],xmm2[0],xmm5[1],xmm2[1],xmm5[2],xmm2[2],xmm5[3],xmm2[3],xmm5[4],xmm2[4],xmm5[5],xmm2[5],xmm5[6],xmm2[6],xmm5[7],xmm2[7]
	punpcklwd	%xmm3, %xmm5            # xmm5 = xmm5[0],xmm3[0],xmm5[1],xmm3[1],xmm5[2],xmm3[2],xmm5[3],xmm3[3]
	punpckldq	%xmm4, %xmm5            # xmm5 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
	punpcklqdq	%xmm1, %xmm5            # xmm5 = xmm5[0],xmm1[0]
	pxor	%xmm0, %xmm5
	movdqu	%xmm5, (%rbx)
	movq	%rbx, %rdi
	subq	$1, -24(%rsp)                   # 8-byte Folded Spill
	jb	.LBB7_14
.LBB7_19:                               #   in Loop: Header=BB7_6 Depth=1
	xorl	%eax, %eax
	.p2align	4
.LBB7_12:                               #   Parent Loop BB7_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rax, -40(%rsp)                 # 8-byte Spill
	leaq	(%rdi,%rax,4), %rax
	movq	%rax, -48(%rsp)                 # 8-byte Spill
	movzbl	(%rax), %r13d
	movzbl	1(%rax), %ecx
	movzbl	2(%rax), %r15d
	movzbl	3(%rax), %r14d
	leal	(%r13,%r13), %r11d
	movq	%rcx, %rax
	leal	(%rcx,%rcx), %ebx
	movl	%eax, %r12d
	movl	%r15d, %ebp
	xorb	%cl, %bpl
	movl	%r15d, %eax
	xorb	%r13b, %al
	xorb	%r13b, %cl
	movq	%rcx, -56(%rsp)                 # 8-byte Spill
                                        # kill: def $r13b killed $r13b killed $r13 def $r13
	sarb	$7, %r13b
	andb	$27, %r13b
	xorb	%r11b, %r13b
	leal	(,%r13,2), %ecx
	sarb	$7, %r11b
	andb	$27, %r11b
	xorb	%cl, %r11b
	leal	(%r11,%r11), %edx
	sarb	$7, %cl
	andb	$27, %cl
	xorb	%dl, %cl
	sarb	$7, %r12b
	andb	$27, %r12b
	xorb	%bl, %r12b
	leal	(%r12,%r12), %r8d
	sarb	$7, %bl
	andb	$27, %bl
	xorb	%r8b, %bl
	leal	(%rbx,%rbx), %edx
	sarb	$7, %r8b
	andb	$27, %r8b
	xorb	%dl, %r8b
	leal	(%r15,%r15), %esi
	xorb	%r14b, %bpl
	xorb	%r13b, %bpl
	xorb	%r15b, %r13b
                                        # kill: def $r15b killed $r15b killed $r15 def $r15
	sarb	$7, %r15b
	andb	$27, %r15b
	xorb	%sil, %r15b
	leal	(%r15,%r15), %edx
	sarb	$7, %sil
	andb	$27, %sil
	xorb	%dl, %sil
	leal	(%rsi,%rsi), %r9d
	sarb	$7, %dl
	andb	$27, %dl
	xorb	%r9b, %dl
	xorb	%r8b, %dl
	leal	(%r14,%r14), %r8d
	xorb	%r14b, %al
	xorb	%r12b, %al
	xorb	%r15b, %al
	xorb	%r14b, %r15b
                                        # kill: def $r14b killed $r14b killed $r14 def $r14
	sarb	$7, %r14b
	andb	$27, %r14b
	xorb	%r8b, %r14b
	leal	(%r14,%r14), %r9d
	sarb	$7, %r8b
	andb	$27, %r8b
	xorb	%r9b, %r8b
	movq	%rdi, %r10
	leal	(%r8,%r8), %edi
	sarb	$7, %r9b
	andb	$27, %r9b
	xorb	%dil, %r9b
	movq	%r10, %rdi
	xorb	%r12b, %bpl
	movq	-56(%rsp), %r10                 # 8-byte Reload
	xorb	%r14b, %r10b
	xorb	%r11b, %bpl
	xorb	%r10b, %r15b
	xorb	%r11b, %r15b
	xorb	%sil, %bpl
	xorb	%sil, %r15b
	xorb	%cl, %bpl
	xorb	%dl, %bpl
	xorb	%r9b, %bpl
	movq	-48(%rsp), %rsi                 # 8-byte Reload
	movb	%bpl, (%rsi)
	xorb	%bl, %al
	xorb	%r8b, %al
	xorb	%cl, %al
	xorb	%dl, %al
	xorb	%r9b, %al
	movb	%al, 1(%rsi)
	movq	-40(%rsp), %rax                 # 8-byte Reload
	xorb	%cl, %r15b
	xorb	%dl, %r15b
	xorb	%r9b, %r15b
	movb	%r15b, 2(%rsi)
	xorb	%r10b, %r13b
	xorb	%bl, %r13b
	xorb	%r8b, %r13b
	xorb	%cl, %r13b
	xorb	%dl, %r13b
	xorb	%r9b, %r13b
	movb	%r13b, 3(%rsi)
	incq	%rax
	cmpq	$4, %rax
	jne	.LBB7_12
# %bb.13:                               #   in Loop: Header=BB7_6 Depth=1
	addq	$-16, -32(%rsp)                 # 8-byte Folded Spill
	jmp	.LBB7_6
.LBB7_14:
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
	.p2align	4
	.type	AES_CBC_encrypt_buffer,@function
AES_CBC_encrypt_buffer:                 # 
	.cfi_startproc
# %bb.0:
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
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	leaq	176(%rdi), %r12
	movq	%r12, %r15
	testq	%rdx, %rdx
	je	.LBB8_7
# %bb.1:
	movq	%rdx, %rbx
	movq	%rdi, %r14
	xorl	%r13d, %r13d
	movq	%r12, %rax
	jmp	.LBB8_2
	.p2align	4
.LBB8_8:                                #   in Loop: Header=BB8_2 Depth=1
	movups	(%r15), %xmm0
	movups	(%rax), %xmm1
	xorps	%xmm0, %xmm1
	movups	%xmm1, (%r15)
.LBB8_6:                                #   in Loop: Header=BB8_2 Depth=1
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	Cipher
	leaq	16(%r15), %rsi
	addq	$16, %r13
	movq	%r15, %rax
	cmpq	%rbx, %r13
	jae	.LBB8_7
.LBB8_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB8_5 Depth 2
	movq	%rsi, %r15
	leaq	15(%rsi), %rcx
	cmpq	%rax, %rcx
	jb	.LBB8_8
# %bb.3:                                #   in Loop: Header=BB8_2 Depth=1
	leaq	15(%rax), %rcx
	cmpq	%r15, %rcx
	jb	.LBB8_8
# %bb.4:                                #   in Loop: Header=BB8_2 Depth=1
	xorl	%ecx, %ecx
	.p2align	4
.LBB8_5:                                #   Parent Loop BB8_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rax,%rcx), %edx
	xorb	%dl, (%r15,%rcx)
	incq	%rcx
	cmpq	$16, %rcx
	jne	.LBB8_5
	jmp	.LBB8_6
.LBB8_7:
	movups	(%r15), %xmm0
	movups	%xmm0, (%r12)
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
	retq
.Lfunc_end8:
	.size	AES_CBC_encrypt_buffer, .Lfunc_end8-AES_CBC_encrypt_buffer
	.cfi_endproc
                                        # -- End function
	.globl	AES_CBC_decrypt_buffer          # -- Begin function AES_CBC_decrypt_buffer
	.p2align	4
	.type	AES_CBC_decrypt_buffer,@function
AES_CBC_decrypt_buffer:                 # 
	.cfi_startproc
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB9_8
# %bb.1:
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r15
	leaq	176(%rdi), %r12
	leaq	191(%rdi), %r13
	xorl	%ebp, %ebp
	jmp	.LBB9_2
	.p2align	4
.LBB9_9:                                #   in Loop: Header=BB9_2 Depth=1
	movups	(%r14), %xmm0
	movups	(%r12), %xmm1
	xorps	%xmm0, %xmm1
	movups	%xmm1, (%r14)
.LBB9_6:                                #   in Loop: Header=BB9_2 Depth=1
	movaps	(%rsp), %xmm0
	movups	%xmm0, (%r12)
	addq	$16, %r14
	addq	$16, %rbp
	cmpq	%rbx, %rbp
	jae	.LBB9_7
.LBB9_2:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB9_5 Depth 2
	movups	(%r14), %xmm0
	movaps	%xmm0, (%rsp)
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	InvCipher
	leaq	15(%r14), %rax
	cmpq	%r12, %rax
	jb	.LBB9_9
# %bb.3:                                #   in Loop: Header=BB9_2 Depth=1
	cmpq	%r14, %r13
	jb	.LBB9_9
# %bb.4:                                #   in Loop: Header=BB9_2 Depth=1
	xorl	%eax, %eax
	.p2align	4
.LBB9_5:                                #   Parent Loop BB9_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	176(%r15,%rax), %ecx
	xorb	%cl, (%r14,%rax)
	incq	%rax
	cmpq	$16, %rax
	jne	.LBB9_5
	jmp	.LBB9_6
.LBB9_7:
	addq	$24, %rsp
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
.LBB9_8:
	retq
.Lfunc_end9:
	.size	AES_CBC_decrypt_buffer, .Lfunc_end9-AES_CBC_decrypt_buffer
	.cfi_endproc
                                        # -- End function
	.globl	AES_CTR_xcrypt_buffer           # -- Begin function AES_CTR_xcrypt_buffer
	.p2align	4
	.type	AES_CTR_xcrypt_buffer,@function
AES_CTR_xcrypt_buffer:                  # 
	.cfi_startproc
# %bb.0:
	testq	%rdx, %rdx
	je	.LBB10_8
# %bb.1:
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r15
	leaq	191(%rdi), %rbp
	movl	$16, %eax
	xorl	%r13d, %r13d
	movq	%rsp, %r12
	jmp	.LBB10_2
	.p2align	4
.LBB10_4:                               #   in Loop: Header=BB10_2 Depth=1
	incb	%al
	movb	%al, (%rcx)
.LBB10_5:                               #   in Loop: Header=BB10_2 Depth=1
	xorl	%eax, %eax
.LBB10_6:                               #   in Loop: Header=BB10_2 Depth=1
	movl	%eax, %ecx
	movzbl	(%rsp,%rcx), %ecx
	xorb	%cl, (%r14,%r13)
	incq	%r13
	incl	%eax
	cmpq	%r13, %rbx
	je	.LBB10_7
.LBB10_2:                               # =>This Inner Loop Header: Depth=1
	cmpl	$16, %eax
	jne	.LBB10_6
# %bb.3:                                #   in Loop: Header=BB10_2 Depth=1
	leaq	176(%r15), %rax
	movups	(%rax), %xmm0
	movaps	%xmm0, (%rsp)
	movq	%r12, %rdi
	movq	%r15, %rsi
	callq	Cipher
	movzbl	191(%r15), %eax
	movq	%rbp, %rcx
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.9:                                #   in Loop: Header=BB10_2 Depth=1
	movb	$0, (%rbp)
	leaq	190(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.10:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	190(%r15), %rax
	movb	$0, (%rax)
	leaq	189(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.11:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	189(%r15), %rax
	movb	$0, (%rax)
	leaq	188(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.12:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	188(%r15), %rax
	movb	$0, (%rax)
	leaq	187(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.13:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	187(%r15), %rax
	movb	$0, (%rax)
	leaq	186(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.14:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	186(%r15), %rax
	movb	$0, (%rax)
	leaq	185(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.15:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	185(%r15), %rax
	movb	$0, (%rax)
	leaq	184(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.16:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	184(%r15), %rax
	movb	$0, (%rax)
	leaq	183(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.17:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	183(%r15), %rax
	movb	$0, (%rax)
	leaq	182(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.18:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	182(%r15), %rax
	movb	$0, (%rax)
	leaq	181(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.19:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	181(%r15), %rax
	movb	$0, (%rax)
	leaq	180(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.20:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	180(%r15), %rax
	movb	$0, (%rax)
	leaq	179(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.21:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	179(%r15), %rax
	movb	$0, (%rax)
	leaq	178(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.22:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	178(%r15), %rax
	movb	$0, (%rax)
	leaq	177(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.23:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	177(%r15), %rax
	movb	$0, (%rax)
	leaq	176(%r15), %rcx
	movzbl	(%rcx), %eax
	cmpb	$-1, %al
	jne	.LBB10_4
# %bb.24:                               #   in Loop: Header=BB10_2 Depth=1
	leaq	176(%r15), %rax
	movb	$0, (%rax)
	jmp	.LBB10_5
.LBB10_7:
	addq	$24, %rsp
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
.LBB10_8:
	retq
.Lfunc_end10:
	.size	AES_CTR_xcrypt_buffer, .Lfunc_end10-AES_CTR_xcrypt_buffer
	.cfi_endproc
                                        # -- End function
	.type	sbox,@object                    # 
	.section	.rodata,"a",@progbits
	.p2align	4, 0x0
sbox:
	.ascii	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321\000\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.size	sbox, 256

	.type	rsbox,@object                   # 
	.p2align	4, 0x0
rsbox:
	.ascii	"R\tj\32506\2458\277@\243\236\201\363\327\373|\3439\202\233/\377\2074\216CD\304\336\351\313T{\2242\246\302#=\356L\225\013B\372\303N\b.\241f(\331$\262v[\242Im\213\321%r\370\366d\206h\230\026\324\244\\\314]e\266\222lpHP\375\355\271\332^\025FW\247\215\235\204\220\330\253\000\214\274\323\n\367\344X\005\270\263E\006\320,\036\217\312?\017\002\301\257\275\003\001\023\212k:\221\021AOg\334\352\227\362\317\316\360\264\346s\226\254t\"\347\2555\205\342\3717\350\034u\337nG\361\032q\035)\305\211o\267b\016\252\030\276\033\374V>K\306\322y \232\333\300\376x\315Z\364\037\335\2503\210\007\3071\261\022\020Y'\200\354_`Q\177\251\031\265J\r-\345z\237\223\311\234\357\240\340;M\256*\365\260\310\353\273<\203S\231a\027+\004~\272w\326&\341i\024cU!\f}"
	.size	rsbox, 256

	.ident	"Intel(R) oneAPI DPC++/C++ Compiler 2026.0.0 (2026.0.0.20260331)"
	.section	".note.GNU-stack","",@progbits
