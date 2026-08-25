# Сравнение и анализ оптимизаций компилятора AOCC

# Параметры сборки
```
clang-17 -S -O0 -DNO_ZERO_DIVIDE source/optbench/optbench.c -o assembler/optbench/optbench_aocc_O0.s
clang-17 -S -O2 -DNO_ZERO_DIVIDE source/optbench/optbench.c -o assembler/optbench/optbench_aocc_O2.s

```

# Размножение констант и копий

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| j4 = 2;<br>printf("%d", j4);<br>if (i2 < j4 && i4 < j4) {<br>&nbsp;&nbsp;&nbsp;&nbsp;i2 = 2;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", i2);<br>} | `movl $2, j4(%rip)`<br>`movl j4(%rip), %esi`<br>`callq printf@PLT`<br>`movl i2(%rip), %eax`<br>`cmpl j4(%rip), %eax`<br>`jge .LBB0_3`<br>...<br>`movl i2(%rip), %esi` | `movl $2, j4(%rip)`<br>`movl $2, %esi`<br>`callq printf@PLT`<br>`movl i2(%rip), %r14d`<br>`cmpl $1, %r14d`<br>`jg .LBB0_3`<br>...<br>`movl $2, %esi` | в O2 вместо загрузки `j4` и `i2` из памяти в `printf` передаётся константа `$2`. Сравнение `i2 < 2` заменено эквивалентным `i2 <= 1` через `cmpl $1`/`jg`. |
 

## Свертка констант, арифметические тождества и излишние операции загрузки сохранения

| Исходный код | AOCC_O0 | AOCC_O2 | Вывод |
|--------------|--------|--------|-------|
| i3 = 1 + 2; |   `movl $3, i3(%rip)` | `movl $3, i3(%rip)` | выражение `1 + 2` свернут. |
| flt_1 = 2.4 + 6.3; | `movsd .LCPI0_2(%rip), %xmm0`<br>`movsd %xmm0, flt_1(%rip)` | `movabsq $4621087282649523814, %rax`<br>`movq %rax, flt_1(%rip)` | значение выражения вычеслено на этапе компиляции. |
| i2 = 5; |  `movl $5, i2(%rip)` | `movl $5, i2(%rip)` | Одинаково. |
| j2 = i + 0;<br>k2 = i / 1;<br>i4 = i * 1; | `movl	i(%rip), %eax `<br>`addl $0, %eax`<br>`movl %eax, j2(%rip)`<br>`movl $1, %ecx`<br>`idivl %ecx`<br>`movl %eax, k2(%rip)`<br>`shll $0, %eax`<br>`movl %eax, i4(%rip)` | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl %eax, i4(%rip)` |  в O2 `+ 0`, `/ 1`, `* 1` не выполняются как отдельные операции, также значение `k2` не меняется. |
| i5 = i * 0; | `imull $0, i(%rip), %eax`<br>`movl %eax, i5(%rip)` | `отсутствует` | В O0 есть умножение на 0. В O2 код отсутствует. |
| flt_3 = 2.4 / 1.0; | `movsd .LCPI0_1(%rip), %xmm0`<br>`movsd %xmm0, flt_3(%rip)` | `movabsq $4612586738352862003, %rax`<br>`movq %rax, flt_3(%rip)` | значение выражения вычеслено на этапе компиляции. |
| flt_4 = 1.0 + 0.0000001; | `movsd .LCPI0_0(%rip), %xmm0`<br>`movsd %xmm0, flt_4(%rip)` | `movabsq $4607182419250377371, %rax`<br>`movq %rax, flt_4(%rip)` |  значения выражение вычеслено на этапе компиляции. |
| flt_5 = flt_6 * 0.0; | `xorps %xmm0, %xmm0`<br>`mulsd flt_6(%rip), %xmm0`<br>`movsd %xmm0, flt_5(%rip)` | `xorpd %xmm0, %xmm0`<br>`mulsd flt_6(%rip), %xmm0`<br>`movsd %xmm0, flt_5(%rip)` | Умножение на `0.0` не заменено константой. O2 использует `xorpd` вместо `xorps`. |
| flt_6 = flt_2 * flt_3; | `movsd flt_2(%rip), %xmm0`<br>`mulsd flt_3(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | `movsd flt_2(%rip), %xmm0`<br>`mulsd .LCPI0_0(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | O2 использует литерал из .rodata вместо загрузки `flt_3`. |
## Лишние присваивания

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| k3 = 1;<br>k3 = 1; | `movl	$1, k3(%rip)`<br>`movl	$1, k3(%rip)` | `movl	$1, k3(%rip)` | в O2 отсутствует повторное присваивание. |
## Снижение мощности

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| k2 = 4 * j5;<br>for (i = 0; i <= 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = i * 2; |  `movl j5(%rip), %eax`<br>`shll $2, %eax`<br>`movl %eax, k2(%rip)`<br>...<br>`.LBB0_7:`<br>`cmpl $5, i(%rip)`<br>`jg .LBB0_10`<br>...<br>`shll %eax`<br>`movw %dx, (%rax,%rcx,2)` | `movl j5(%rip), %eax`<br>`shll $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movabsq $1688867040264192, %rax`<br>`movq %rax, ivector4(%rip)`<br>`movl $655368, ivector4+8(%rip)` | В обоих случаях `4 * j5` заменено на сдвиг `shll $2`. В O2 цикл отсутствует, компилятор вычислил значения на 6 итерациях и записал в массив готовые значения `0, 2, 4, 6, 8, 10`. |
## Простой цикл

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| j5 = 0;<br>k5 = 10000;<br>do {<br>&nbsp;&nbsp;&nbsp;&nbsp;k5 = k5 - 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;j5 = j5 + 1<br>&nbsp;&nbsp;&nbsp;&nbsp;i5 = (k5 * 3) / (j5 * constant5);<br>} while (k5 > 0); | `movl $0, j5(%rip)`<br>`movl $10000, k5(%rip)`<br>`.LBB0_11:`<br>`subl $1, %eax`<br>`movl %eax, k5(%rip)`<br>`addl $1, %eax`<br>`movl %eax, j5(%rip)`<br>`imull $3, k5(%rip), %eax`<br>`imull $5, j5(%rip), %ecx`<br>`idivl %ecx`<br>`movl %eax, i5(%rip)`<br>`cmpl $0, k5(%rip)`<br>`jg .LBB0_11` | `movl $10000, j5(%rip)`<br>`movl $0, i5(%rip)` |  O2 цикл свернут. Компилятор записал только финальные значения глобальных переменных. Сам цикл и промежуточные вычисления удалены. |

## Управление переменной индукции цикла

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| for (i = 0; i < 100; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector5[i * 2 + 3] = 5; | `movl $0, i(%rip)`<br>`.LBB0_14:`<br>`cmpl $100, i(%rip)`<br>`jge .LBB0_17`<br>`movl i(%rip), %eax`<br>`shll %eax`<br>`addl $3, %eax`<br>`movslq %eax, %rcx`<br>`leaq ivector5(%rip), %rax`<br>`movl $5, (%rax,%rcx,4)`<br>`addl $1, %eax`<br>`movl %eax, i(%rip)`<br>`jmp .LBB0_14` | `xorl %eax, %eax`<br>`leaq ivector5(%rip), %rcx`<br>`.LBB0_7:`<br>`movl $5, 12(%rcx,%rax,8)`<br>`movl $5, 20(%rcx,%rax,8)`<br>`movl $5, 28(%rcx,%rax,8)`<br>`movl $5, 36(%rcx,%rax,8)`<br>`addq $4, %rax`<br>`cmpq $100, %rax`<br>`jne .LBB0_7` | В O0 переменная `i` хранится в памяти и перезаписывается на каждой итерации. В O2 адрес вычисляется через смещение `%rax * 8 + 12`, цикл развёрнут в 4 раза, а переменная индукции `i` не сохраняется в память внутри цикла, что убирает лишние обращения к памяти. |

## Глубокие подвыражения 

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| if (i < 10) <br> &nbsp;&nbsp;&nbsp;&nbsp;j5 = i5 + i2;<br> else <br> &nbsp;&nbsp;&nbsp;&nbsp;k5 = i5 + i2; | `cmpl $10, i(%rip)`<br>`jge .LBB0_19`<br>`movl i5(%rip), %eax`<br>`addl i2(%rip), %eax`<br>`movl %eax, j5(%rip)`<br>`jmp .LBB0_20`<br>`.LBB0_19:`<br>`movl i5(%rip), %eax`<br>`addl i2(%rip), %eax`<br>`movl %eax, k5(%rip)` | `movl $100, i(%rip)`<br>`movl $5, k5(%rip)` | В O0 генерируются обе ветки условия. В O2 компилятор знает, что после предыдущего цикла `i` равно 100, условие `i < 10` всегда ложно. Ветка `if` удалена, а выражение `i5 + i2` свернуто до константы `5`. |

## Проверка того, как компилятор генерирует адрес переменной с константным индексом, размножает копии и регистры 

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| ivector[0] = 1;<br>printf("%d", ivector[0]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[2] = 3;<br>printf("%d", ivector[2]); | `movl $1, ivector(%rip)`<br>`movl ivector(%rip), %esi`<br>`callq printf@PLT`<br>`movslq i2(%rip), %rcx`<br>`leaq ivector(%rip), %rax`<br>`movl $2, (%rax,%rcx,4)`<br>`movl (%rax,%rcx,4), %esi`<br>`callq printf@PLT`<br>...<br>`movl $3, ivector+8(%rip)`<br>`movl ivector+8(%rip), %esi`<br>`callq printf@PLT` | `movl $1, ivector(%rip)`<br>`movl $1, %esi`<br>`callq printf@PLT`<br>`movl $2, ivector+20(%rip)`<br>`movl $2, %esi`<br>`callq printf@PLT`<br>...<br>`movl $3, ivector+8(%rip)`<br>`movl $3, %esi`<br>`callq printf@PLT` | В O0 адреса вычисляются через регистры, а значения загружаются из памяти для каждого `printf`. В O2 компилятор знает, что `i2 = 5`, поэтому вычисляет адрес `ivector[i2]` как `ivector+20` на этапе компиляции. Для `printf` значения передаются как константы, без загрузки из памяти. |

## Удаление общих подвыражений

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| if ((h3 + k3) < 0 \|\| (h3 + k3) > 5)<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("Common subexpression elimination\n");<br>else {<br>&nbsp;&nbsp;&nbsp;&nbsp;m3 = (h3 + k3) / i3;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", m3);<br>&nbsp;&nbsp;&nbsp;&nbsp;g3 = i3 + (h3 + k3);<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", g3);<br>} | `movl h3(%rip), %eax`<br>`addl k3(%rip), %eax`<br>`cmpl $0, %eax`<br>`jl .LBB0_22`<br>`movl h3(%rip), %eax`<br>`addl k3(%rip), %eax`<br>`cmpl $5, %eax`<br>`jle .LBB0_23`<br>...<br>`movl h3(%rip), %eax`<br>`addl k3(%rip), %eax`<br>`idivl i3(%rip)`<br>`movl %eax, m3(%rip)`<br>...<br>`movl i3(%rip), %eax`<br>`movl h3(%rip), %ecx`<br>`addl k3(%rip), %ecx`<br>`addl %ecx, %eax`<br>`movl %eax, g3(%rip)` | `movl h3(%rip), %ebx`<br>`leal -5(%rbx), %eax`<br>`cmpl $-7, %eax`<br>`ja .LBB0_10`<br>...<br>`leal -2(%rbx), %eax`<br>`cmpl $-3, %eax`<br>`setb %sil`<br>`movl %esi, m3(%rip)`<br>...<br>`addl $4, %ebx`<br>`movl %ebx, g3(%rip)` | В O0 выражение `h3 + k3` вычисляется 4 раза. В O2 компилятор знает, что `k3 = 1` и `i3 = 3`, поэтому условие превращается в проверку диапазона. Деление `(h3 + 1) / 3` заменено на `setb`, а `g3 = h3 + 4` вычисляется как `addl $4, %ebx`. |
## Вынесение инвариантного кода

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| for (i4 = 0; i4 <= max_vector; i4++){<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector2[i4] = j * k;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector2[i4]);<br>} | `movl j(%rip), %eax`<br>`imull k(%rip), %eax`<br>`movb %al, %dl`<br>`movslq i4(%rip), %rcx`<br>`leaq ivector2(%rip), %rax`<br>`movb %dl, (%rax,%rcx)`<br>`movzbl (%rax,%rcx), %esi`<br>`callq printf@PLT` | `movl k(%rip), %eax`<br>`imull j(%rip), %eax`<br>`movzbl %al, %ebp`<br>`movb %bpl, ivector2(%rip)`<br>`movl %ebp, %esi`<br>`callq printf@PLT`<br>`movb %bpl, ivector2+1(%rip)`<br>`movl %ebp, %esi`<br>`callq printf@PLT`<br>`movb %bpl, ivector2+2(%rip)`<br>`movl %ebp, %esi`<br>`callq printf@PLT` | В O0 умножение `j * k` выполняется на каждой итерации цикла внутри тела. В O2 применено вычисление `j * k` вынесено за пределы цикла и выполняется один раз и цикл развёрнут на 3 итерации, а значение передаётся в `printf` напрямую из регистра `%ebp`. |

## Вызов функции

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| dead_code(1, "This line should not be printed");<br>unnecessary_loop();<br>loop_jamming(7);<br>loop_unrolling(7);<br>jump_compression(1, 2, 3, 4, 5); | `movl $1, %edi`<br>`leaq .L.str.2(%rip), %rsi`<br>`callq dead_code`<br><br>`callq unnecessary_loop`<br><br>`movl $7, %edi`<br>`callq loop_jamming`<br><br>`movl $7, %edi`<br>`callq loop_unrolling`<br><br>`movl $1, %edi`<br>`...`<br>`callq jump_compression` | *(отсутствует)*<br><br>`movl $10000, k5(%rip)`<br>`...`<br>`callq printf@PLT`<br><br>`movl $7, k5(%rip)`<br>`...`<br>`callq printf@PLT`<br><br>`movw $0, ivector4(%rip)`<br>`...`<br>`callq printf@PLT`<br><br>*(отсутствует)* | В O0 выполняются обычные вызовы функций через `callq`. В O2 тела функций встроены в `main`, циклы удалены, а результаты просчитаны, `dead_code` и `jump_compression` удалены полностью. |


## Функция: dead_code

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
|void dead_code(int a, char *b)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int idead_store;<br>&nbsp;&nbsp;&nbsp;&nbsp;idead_store = a;<br>&nbsp;&nbsp;&nbsp;&nbsp;if (0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%s\n", b);<br>}| `pushq %rbp`<br>`movq %rsp, %rbp`<br>`movl %edi, -4(%rbp)`<br>`movq %rsi, -16(%rbp)`<br>`movl -4(%rbp), %eax`<br>`movl %eax, -20(%rbp)`<br>`popq %rbp`<br>`retq` | `dead_code:`<br>&nbsp;&nbsp;`retq` | В O0 компилятор сохраняет аргументы в стеке и выполняет `idead_store = a`, но удаляет ветку `if (0)`. В O2 функция полностью отсутствует. |

## Функция: unnecessary_loop

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| void unnecessary_loop()<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int x;<br>&nbsp;&nbsp;&nbsp;&nbsp;x = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>} | `movl $0, -4(%rbp)`<br>`movl $0, i(%rip)`<br>`.LBB2_1:`<br>&nbsp;&nbsp;`cmpl $5, i(%rip)`<br>&nbsp;&nbsp;`jge .LBB2_4`<br>&nbsp;&nbsp;`movl -4(%rbp), %eax`<br>&nbsp;&nbsp;`addl j5(%rip), %eax`<br>&nbsp;&nbsp;`movl %eax, k5(%rip)`<br>&nbsp;&nbsp;`...`<br>`.LBB2_4:`<br>&nbsp;&nbsp;`movl k5(%rip), %esi`<br>&nbsp;&nbsp;`callq printf@PLT`<br>&nbsp;&nbsp;`popq %rbp`<br>&nbsp;&nbsp;`retq` | `movl j5(%rip), %esi`<br>`movl %esi, k5(%rip)`<br>`movl $5, i(%rip)`<br>`leaq .L.str(%rip), %rdi`<br>`xorl %eax, %eax`<br>`jmp printf@PLT`<br>`# TAILCALL` | В O0 генерируется цикл, который на каждой итерации вычисляет `0 + j5` и записывает в `k5`. В O2 цикл удалён, компилятор сразу присваивает `k5 = j5`. Вызов `printf` заменён на `jmp`, чтобы сразу вернуться из `printf` в `main`. |

## Функция: loop_jamming

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| void loop_jamming(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i5 = x * k5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `.LBB3_1:`<br>&nbsp;&nbsp;`cmpl $5, i(%rip)`<br>&nbsp;&nbsp;`jge .LBB3_4`<br>&nbsp;&nbsp;`movl j5(%rip), %ecx`<br>&nbsp;&nbsp;`imull i(%rip), %ecx`<br>&nbsp;&nbsp;`addl -4(%rbp), %eax`<br>&nbsp;&nbsp;`movl %eax, k5(%rip)`<br>&nbsp;&nbsp;`callq printf@PLT`<br>&nbsp;&nbsp;`...`<br>&nbsp;&nbsp;`jmp .LBB3_1`<br>`.LBB3_4:`<br>...<br>`.LBB3_5:`<br>&nbsp;&nbsp;`cmpl $5, i(%rip)`<br>&nbsp;&nbsp;`jge .LBB3_8`<br>&nbsp;&nbsp;`imull k5(%rip), %eax`<br>&nbsp;&nbsp;`imull i(%rip), %eax`<br>&nbsp;&nbsp;`movl %eax, i5(%rip)`<br>&nbsp;&nbsp;`callq printf@PLT`<br>&nbsp;&nbsp;`...`<br>&nbsp;&nbsp;`jmp .LBB3_5` | *(Циклы отсутствуют)*<br>`movl $0, i(%rip)`<br>`movl %edi, k5(%rip)`<br>`callq printf@PLT`<br>`movl $1, i(%rip)`<br>`leal (%r15,%rbx), %esi`<br>`movl %esi, k5(%rip)`<br>`callq printf@PLT`<br>`...`<br>`movl $4, i(%rip)`<br>`leal (%rbx,%r15,4), %ebp`<br>`movl %ebp, k5(%rip)`<br>`callq printf@PLT`<br><br>`movl $0, i(%rip)`<br>`movl $0, i5(%rip)`<br>`callq printf@PLT`<br>`...`<br>`movl $4, i(%rip)`<br>`shll $2, %ebx`<br>`movl %ebx, i5(%rip)`<br>`callq printf@PLT`<br>`movl $5, i(%rip)` | Слияние циклов не произошло, потому что второй цикл зависит от финального значения `k5`, вычисленного в первом цикле. Вместо этого обы цикла развернуты.|
## Функция: loop_unrolling

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| void loop_unrolling(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 6; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector4[i]);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `movl $0, i(%rip)`<br>`.LBB4_1:`<br>&nbsp;&nbsp;`cmpl $6, i(%rip)`<br>&nbsp;&nbsp;`jge .LBB4_4`<br>&nbsp;&nbsp;`movslq i(%rip), %rcx`<br>&nbsp;&nbsp;`leaq ivector4(%rip), %rax`<br>&nbsp;&nbsp;`movw $0, (%rax,%rcx,2)`<br>&nbsp;&nbsp;`callq printf@PLT`<br>&nbsp;&nbsp;`...`<br>&nbsp;&nbsp;`jmp .LBB4_1`<br>`.LBB4_4:`<br>&nbsp;&nbsp;`...`<br>&nbsp;&nbsp;`retq` | *(Цикл отсутствует)*<br>`movl $0, i(%rip)`<br>`movw $0, ivector4(%rip)`<br>`callq printf@PLT`<br>`movl $1, i(%rip)`<br>`movw $0, ivector4+2(%rip)`<br>`callq printf@PLT`<br>`movl $2, i(%rip)`<br>`movw $0, ivector4+4(%rip)`<br>`callq printf@PLT`<br>`...`<br>`movl $5, i(%rip)`<br>`movw $0, ivector4+10(%rip)`<br>`callq printf@PLT`<br>`movl $6, i(%rip)` | Применено развертывание цикла. Условные переходы и вычисления адреса индекса на каждой итерации исчезли, вместо них используются записи по фиксированным смещениям. |

## Функция: jump_compression

| Исходный код| AOCC_O0| AOCC_O2 | Вывод |
|------------------------------|
| int jump_compression(int i, int j, int k, int l, int m)<br>{<br>beg_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;if (i < j)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (j < k)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (k < l)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (l < m)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;l += m;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto end_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k += l;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j += k;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", j);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto beg_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i += j;<br>&nbsp;&nbsp;&nbsp;&nbsp;return(i + j + k + l + m);<br>} | `.LBB5_1:`<br>`cmpl -8(%rbp), %eax`<br>`jge .LBB5_13`<br>...<br>`.LBB5_6:`<br>`jmp .LBB5_11`<br>...<br>`.LBB5_11:`<br>`jmp .LBB5_1` | `cmpl %ebp, %r12d`<br>`jge .LBB5_8`<br>...<br>`.LBB5_8:`<br>`cmpl %r15d, %ebx`<br>`jle .LBB5_9`<br>`.LBB5_2:` | В O0 `goto end_1` реализуется через `jmp .LBB5_11`, затем `jmp .LBB5_1`. В O2 выполнена лишние промежуточные переходы удалены, `end_1` объединён с проверкой начала цикла, а переход к `beg_1` выполняется без отдельной цепочки `jmp`. |
