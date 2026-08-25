# Сравнение и анализ оптимизаций компилятора AOCC

# Параметры сборки
```
icx -S -O0 -DNO_ZERO_DIVIDE source/optbench/optbench.c -o assembler/optbench/optbench_icx_O0.s
icx -S -O2 -DNO_ZERO_DIVIDE source/optbench/optbench.c -o assembler/optbench/optbench_icx_O2.s
```

## Размножение констант и копий

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| j4 = 2;<br>printf("%d", j4);<br>if (i2 < j4 && i4 < j4) {<br>&nbsp;&nbsp;&nbsp;&nbsp;i2 = 2;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", i2);<br>} | `movl $2, j4`<br>`movl j4, %esi`<br>`...`<br>`callq printf`<br>`movl i2, %eax`<br>`cmpl j4, %eax`<br>`jge .LBB0_3`<br>`# %bb.1:`<br>`movl i4, %eax`<br>`cmpl j4, %eax`<br>`jge .LBB0_3`<br>`...` | `movl $2, %esi`<br>`...`<br>`callq printf`<br>`movl i2(%rip), %r14d`<br>`movl i4(%rip), %ebp`<br>`cmpl $1, %r14d`<br>`jg .LBB0_3`<br>`# %bb.1:`<br>`cmpl $1, %ebp`<br>`jg .LBB0_3`<br>`...` | O2 подставил константу `2`  регистр `%esi`. Условие `i2 < 2` поменялось на `i2 <= 1` (`cmpl $1`). |

## Свертка констант, арифметические тождества и излишние операции загрузки сохранения

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| i3 = 1 + 2; | `movl $3, i3` | `movl $3, i3(%rip)` | В обоих случаях константа свернута. |
| flt_1 = 2.4 + 6.3; | `movsd .LCPI0_2(%rip), %xmm0`<br>`movsd %xmm0, flt_1` | `movabsq $4621087282649523814, %rax`<br>`movq %rax, flt_1(%rip)` | В обоих случаях, значение выражения вычислено на этапе компиляции. |
| i2 = 5; | `movl $5, i2` | `movl $5, i2(%rip)` | Одинаково.|
| j2 = i + 0;<br>k2 = i / 1;<br>i4 = i * 1; | `movl i, %eax`<br>`addl $0, %eax`<br>`movl %eax, j2`<br>`movl i, %eax`<br>`movl	$1, %ecx`<br>`cltd`<br>`idivl %ecx`<br>`movl %eax, k2`<br>`movl i, %eax`<br>`shll $0, %eax`<br>`movl %eax, i4` | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl %eax, k2(%rip)`<br>`movl %eax, i4(%rip)` | в O2 `+ 0`, `/ 1`, `* 1` не выполняются как отдельные операции. |
| i5 = i * 0; | `imull $0, i, %eax`<br>`movl %eax, i5` | `movl $0, i5(%rip)` | В O0 выполняется умножение на ноль. В O2 выражение `i * 0` сворачивается в константу. |
| flt_3 = 2.4 / 1.0; | `movsd .LCPI0_1(%rip), %xmm0`<br>`movsd %xmm0, flt_3` | `movabsq $4612586738352862003, %rax`<br>`movq %rax, flt_3(%rip)` | В обоих случаях выражение `2.4 / 1.0` свёрнуто в константу. |
| flt_4 = 1.0 + 0.0000001; | `movsd .LCPI0_0(%rip), %xmm0`<br>`movsd %xmm0, flt_4` | `movabsq $4607182419250377371, %rax`<br>`movq %rax, flt_4(%rip)` | В обоих случаях выражение `1.0 + 0.0000001` свёрнуто в константу. |
| flt_5 = flt_6 * 0.0; | `xorps %xmm0, %xmm0`<br>`mulsd flt_6, %xmm0`<br>`movsd %xmm0, flt_5` | `xorpd %xmm0, %xmm0`<br>`mulsd flt_6(%rip), %xmm0`<br>`movsd %xmm0, flt_5(%rip)` | **Нет оптимизации.** |
| flt_6 = flt_2 * flt_3; | `movsd flt_2, %xmm0`<br>`mulsd flt_3, %xmm0`<br>`movsd %xmm0, flt_6` | `movsd flt_2(%rip), %xmm0`<br>`mulsd .LCPI0_0(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | O2 использует литерал из .rodata вместо загрузки `flt_3`. |

## Лишние присваивания

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| k3 = 1;<br>k3 = 1; | `movl	$1, k3`<br>`movl	$1, k3` | `movl $1,k3(%rip)` | в O2 отсутствует повторное присваивание. |

## Снижение мощности

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| k2 = 4 * j5;<br>for (i = 0; i <= 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = i * 2; | `movl j5, %eax`<br>`shll $2, %eax`<br>`movl %eax, k2`<br>`movl $0, i`<br>`.LBB0_7:`<br>`cmpl $5, i`<br>`jg .LBB0_10`<br>`movl i, %eax`<br>`shll %eax`<br>`...`<br>`movw %cx, ivector4(,%rax,2)`<br>`...`<br>`jmp .LBB0_7` | `movl j5(%rip), %eax`<br>`shll $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movabsq $1688867040264192, %rax`<br>`movq %rax, ivector4(%rip)`<br>`movl $655368, ivector4+8(%rip)` | Умножение `4 * j5` заменено на сдвиг `shll $2`. В O2 цикл отсутствует, компилятор вычислил значения на 6 итерациях и записал в массив готовые значения `0, 2, 4, 6, 8, 10`. |

## Простой цикл

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| j5 = 0;<br>k5 = 10000;<br>do {<br>&nbsp;&nbsp;&nbsp;&nbsp;k5 = k5 - 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;j5 = j5 + 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;i5 = (k5 * 3) / (j5 * constant5);<br>} while (k5 > 0); | `movl $0, j5`<br>`movl $10000, k5`<br>`.LBB0_11:`<br>`movl k5, %eax`<br>`subl $1, %eax`<br>`movl %eax, k5`<br>`...`<br>`imull $3, k5, %eax`<br>`imull $5, j5, %ecx`<br>`cltd`<br>`idivl %ecx`<br>`movl %eax, i5`<br>`cmpl $0, k5`<br>`jg .LBB0_11` | `movl $10000, j5(%rip)`<br>`movl $0, i5(%rip)` | В O2 цикл свернут. Компилятор записал только финальные значения глобальных переменных. Сам цикл и промежуточные вычисления удалены. |

## Управление переменной индукции цикла

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| for (i = 0; i < 100; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector5[i * 2 + 3] = 5; | `movl	$0, i`<br>`.LBB0_14:`<br>`cmpl $100, i`<br>`jge .LBB0_17`<br>`movl i, %eax`<br>`shll %eax`<br>`addl $3, %eax`<br>`cltq`<br>`movl $5, ivector5(,%rax,4)`<br>`...`<br>`jmp .LBB0_14` | `movq $-768, %rax`<br>`.LBB0_7:`<br>`movl $5, ivector5+780(%rax)`<br>`movl $5, ivector5+788(%rax)`<br>`...`<br>`movl $5, ivector5+836(%rax)`<br>`addq $64, %rax`<br>`jne .LBB0_7` | O0 на каждой итерации вычисляет индекс `i*2+3` через сдвиг и сложение. в O2 цикл развернут в 8 раз. |

## Глубокие подвыражения

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| if (i < 10)<br>&nbsp;&nbsp;&nbsp;&nbsp;j5 = i5 + i2;<br>else<br>&nbsp;&nbsp;&nbsp;&nbsp;k5 = i5 + i2; | `cmpl $10, i`<br>`jge .LBB0_19`<br>`movl i5, %eax`<br>`addl i2, %eax`<br>`movl %eax, j5`<br>`jmp .LBB0_20`<br>`.LBB0_19:`<br>`movl i5, %eax`<br>`addl i2, %eax`<br>`movl %eax, k5` | `movl $5, k5(%rip)` | O0 вычисляет `i5 + i2` в обеих ветках. O2 знает, что после цикла `i = 100`, поэтому условие `i < 10` всегда ложно. Ветка `if` удалена, а `i5 + i2` свёрнуто в константу `5`. |

## Проверка того, как компилятор генерирует адрес переменной с константным индексом, размножает копии и регистры

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| ivector[0] = 1;<br>printf("%d", ivector[0]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[2] = 3;<br>printf("%d", ivector[2]); | `movl $1, ivector`<br>`movl ivector, %esi`<br>`...`<br>`callq printf`<br>`movslq i2, %rax`<br>`movl $2, ivector(,%rax,4)`<br>`movslq i2, %rax`<br>`movl ivector(,%rax,4), %esi`<br>`...`<br>`callq printf`<br>`movslq i2, %rax`<br>`movl $2, ivector(,%rax,4)`<br>`movslq i2, %rax`<br>`movl ivector(,%rax,4), %esi`<br>`...`<br>`callq printf`<br>`movl $3, ivector+8`<br>`movl ivector+8, %esi`<br>`...`<br>`callq printf` | `movl $1, ivector(%rip)`<br>`movl $1, %esi`<br>`...`<br>`callq printf`<br>`movl $2, ivector+20(%rip)`<br>`movl $2, %esi`<br>`...`<br>`callq printf`<br>`movl $3, ivector+8(%rip)`<br>`movl $3, %esi`<br>`...`<br>`callq printf` | O0 каждый раз загружает `i2`, расширяет до 64 бит и вычисляет адрес. O2 знает, что `i2 = 5`, поэтому `ivector[i2]` = `ivector+20`. Значения для `printf` передаются как константы. Первая запись `ivector[i2] = 2` удалена. |

## Удаление общих подвыражений

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| if ((h3 + k3) < 0 \|\| (h3 + k3) > 5)<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("Common subexpression elimination\n");<br>else {<br>&nbsp;&nbsp;&nbsp;&nbsp;m3 = (h3 + k3) / i3;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", m3);<br>&nbsp;&nbsp;&nbsp;&nbsp;g3 = i3 + (h3 + k3);<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", g3);<br>} | `movl h3, %eax`<br>`addl k3, %eax`<br>`cmpl $0, %eax`<br>`jl .LBB0_22`<br>`movl h3, %eax`<br>`addl k3, %eax`<br>`cmpl $5, %eax`<br>`jle .LBB0_23`<br>`...`<br>`.LBB0_23:`<br>`movl h3, %eax`<br>`addl k3, %eax`<br>`cltd`<br>`idivl i3`<br>`movl %eax, m3`<br>`...`<br>`movl i3, %eax`<br>`movl h3, %ecx`<br>`addl k3, %ecx`<br>`addl %ecx, %eax`<br>`movl %eax, g3`<br>`...` | `movl h3(%rip), %ebx`<br>`leal 1(%rbx), %eax`<br>`cmpl $5, %eax`<br>`jbe .LBB0_9`<br>`...`<br>`.LBB0_9:`<br>`movl %eax, %eax`<br>`movl $2863311531, %esi`<br>`imulq %rax, %rsi`<br>`shrq $33, %rsi`<br>`movl %esi, m3(%rip)`<br>`...`<br>`addl $4, %ebx`<br>`movl %ebx, g3(%rip)` | O0 вычисляет `h3 + k3` четыре раза. O2 знает, что `k3 = 1`, поэтому вычисляет `h3 + 1` один раз через `leal`. Выражение `i3 + (h3 + k3)` свёрнуто в `h3 + 4`. |

## Вынесение инвариантного кода

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| for (i4 = 0; i4 <= max_vector; i4++){<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector2[i4] = j * k;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector2[i4]);<br>} | `movl	$0, i4`<br>`.LBB0_25:`<br>`cmpl $2, i4`<br>`jg .LBB0_28`<br>`movl j, %eax`<br>`imull k, %eax`<br>`movb %al, %cl`<br>`movslq i4, %rax`<br>`movb %cl, ivector2(,%rax)`<br>`...`<br>`jmp .LBB0_25` | `movl k(%rip), %eax`<br>`imull j(%rip), %eax`<br>`movzbl %al, %ebx`<br>`xorl %r14d, %r14d`<br>`.LBB0_11:`<br>`movb %bl, ivector2(%r14)`<br>`...`<br>`movb %bl, ivector2+3(%r14)`<br>`...`<br>`addq $4, %r14`<br>`...`<br>`js .LBB0_11` | O0 вычисляет `j * k` на каждой итерации цикла. O2 вынес инвариантное умножение за пределы цикла. Цикл развёрнут в 4 раза, но так как `max_vector = 2` в O2 сгенерировал лишний код. |

## Вызов функции

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| dead_code(1, "This line should not be printed");<br>unnecessary_loop();<br>loop_jamming(7);<br>loop_unrolling(7);<br>jump_compression(1, 2, 3, 4, 5); | `movl $1, %edi`<br>`movabsq $.L.str.3, %rsi`<br>`callq dead_code`<br>`callq unnecessary_loop`<br>`movl $7, %edi`<br>`callq loop_jamming`<br>`movl $7, %edi`<br>`callq loop_unrolling`<br>`movl $1, %edi`<br>`movl $2, %esi`<br>`...`<br>`callq jump_compression` | `# dead_code — отсутствует`<br>`# unnecessary_loop, цикл удалён`<br>`movl $10000, %esi`<br>`callq printf`<br>`# loop_jamming, оба цикла развёрнуты`<br>`movl $7, %esi`<br>`callq printf`<br>`movl $10007, %esi`<br>`callq printf`<br>`...`<br>`# loop_unrolling, цикл развёрнут`<br>`movq $0, ivector4(%rip)`<br>`...`<br>`# jump_compression — отсутствует` |  O2 встроил все функции в `main`. Вызовы `dead_code` и `jump_compression` удалены. `unnecessary_loop` заменён одним `printf` с tail call. `loop_jamming` и `loop_unrolling` развёрнуты в последовательные вызовы `printf`. |

## Функция: dead_code

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| void dead_code(int a, char *b)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int idead_store;<br>&nbsp;&nbsp;&nbsp;&nbsp;idead_store = a;<br>&nbsp;&nbsp;&nbsp;&nbsp;if (0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%s\n", b);<br>} | `dead_code:`<br>`movl %edi, -4(%rbp)`<br>`movq %rsi, -16(%rbp)`<br>`movl -4(%rbp), %eax`<br>`movl %eax, -20(%rbp)`<br>`...`<br>`retq` | `dead_code:`<br>`retq` | O0 сохраняет аргументы и локальную переменную в стек, хотя ветка `if (0)` удалена. O2 полностью удаляет мёртвое присваивание и недостижимый вызов `printf`. |

## Функция: unnecessary_loop

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| void unnecessary_loop()<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int x;<br>&nbsp;&nbsp;&nbsp;&nbsp;x = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>} | `unnecessary_loop:`<br>`movl $0, -4(%rbp)`<br>`movl $0, i`<br>`.LBB2_1:`<br>`cmpl $5, i`<br>`jge .LBB2_4`<br>`movl -4(%rbp), %eax`<br>`addl j5, %eax`<br>`movl %eax, k5`<br>`...`<br>`jmp .LBB2_1`<br>`.LBB2_4:`<br>`...`<br>`callq printf` | `unnecessary_loop:`<br>`movl j5(%rip), %esi`<br>`movl %esi, k5(%rip)`<br>`movl $5, i(%rip)`<br>`movl $.L.str, %edi`<br>`xorl %eax, %eax`<br>`jmp printf` |  O2 цикл отсутствует, остаётся только запись результата и установка конечного значения счётчика `i = 5`. Вызов `printf` заменён на хвостовой `jmp printf`. |

## Функция: loop_jamming

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| void loop_jamming(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i5 = x * k5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `.LBB3_1:`<br>`cmpl $5, i`<br>`jge .LBB3_4`<br>`movl j5, %ecx`<br>`imull i, %ecx`<br>`addl %ecx, %eax`<br>`movl %eax, k5`<br>`...`<br>`callq printf`<br>`...`<br>`jmp .LBB3_1`<br>`.LBB3_5:`<br>`cmpl $5, i`<br>`jge .LBB3_8`<br>`imull k5, %eax`<br>`imull i, %eax`<br>`movl %eax, i5`<br>`...`<br>`callq printf`<br>`...`<br>`jmp .LBB3_5` | `movl %edi, k5(%rip)`<br>`callq printf`<br>`leal (%rbx,%r14), %esi`<br>`movl %esi, k5(%rip)`<br>`callq printf`<br>`leal (%rbx,%r14,2), %esi`<br>`movl %esi, k5(%rip)`<br>`callq printf`<br>`...`<br>`leal (%rbx,%r14,4), %ebp`<br>`movl %ebp, k5(%rip)`<br>`callq printf`<br>`movl $0, i5(%rip)`<br>`callq printf`<br>`imull %ebp, %ebx`<br>`movl %ebx, i5(%rip)`<br>`callq printf`<br>`...`<br>`movl $5, i(%rip)` | в O2 нет слияния циклов, но они оба развернуты. Умножения `j5 * i` заменены на инструкции `leal (%rbx,%r14,2), %esi`, вместо `imull`, `x * k5` вычисляется один раз. |

## Функция: loop_unrolling

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| void loop_unrolling(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 6; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector4[i]);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `.LBB4_1:`<br>`cmpl $6, i`<br>`jge .LBB4_4`<br>`movslq i, %rax`<br>`movw $0, ivector4(,%rax,2)`<br>`movslq i, %rax`<br>`movswl ivector4(,%rax,2), %esi`<br>`...`<br>`callq printf`<br>`...`<br>`jmp .LBB4_1` | `xorl %esi, %esi`<br>`callq printf`<br>`movl $1, i(%rip)`<br>`...`<br>`callq printf`<br>`movl $3, i(%rip)`<br>`movq $0, ivector4(%rip)`<br>`callq printf`<br>`movl $4, i(%rip)`<br>`movw $0, ivector4+8(%rip)`<br>`callq printf`<br>`movl $5, i(%rip)`<br>`movw $0, ivector4+10(%rip)`<br>`callq printf`<br>`movl $6, i(%rip)` | в O2 полностью развернут цикл. Записи в массив объединены: `movq $0` записывает сразу 4 элемента. |

## Функция: jump_compression

| Исходный код | ICX_O0 | ICX_O2 | Вывод |
|---|---|---|---|
| int jump_compression(int i, int j, int k, int l, int m)<br>{<br>beg_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;if (i < j)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (j < k)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (k < l)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (l < m)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;l += m;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto end_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k += l;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j += k;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", j);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto beg_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i += j;<br>&nbsp;&nbsp;&nbsp;&nbsp;return(i + j + k + l + m);<br>} | `.LBB5_1:`<br>`movl -4(%rbp), %eax`<br>`cmpl -8(%rbp), %eax`<br>`jge .LBB5_13`<br>`...`<br>`.LBB5_6:`<br>`jmp .LBB5_11`<br>`...`<br>`.LBB5_11:`<br>`jmp .LBB5_1`<br>`...`<br>`.LBB5_12:`<br>`jmp .LBB5_14` | `movl %edi, %r12d`<br>`cmpl %esi, %edi`<br>`jl .LBB5_1`<br>`...`<br>`.LBB5_1:`<br>`cmpl %r15d, %r14d`<br>`jge .LBB5_6`<br>`...`<br>`cmpl %ebp, %ebx`<br>`jge .LBB5_7`<br>`.LBB5_7:`<br>`cmpl %r14d, %r12d`<br>`jge .LBB5_8` | O0 хранит аргументы в стеке и реализует `goto end_1` цепочкой переходов: `.LBB5_6 -> .LBB5_11 -> .LBB5_1`, а также содержит много промежуточных `jmp`. O2 держит переменные в регистрах, перестраивает блоки управления и заменяет цепочку переходов прямым переходом на блок проверки цикла `.LBB5_7`, откуда управление передаётся обратно в `.LBB5_1`. |
