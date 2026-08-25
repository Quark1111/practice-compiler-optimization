# Сравнение и анализ оптимизаций компилятора GCC

# Параметры сборки
```
gcc -S -O0 source/optbench/optbench.c -o assembler/optbench/optbench_gcc_O0.s
gcc -S -O2 source/optbench/optbench.c -o assembler/optbench/optbench_gcc_O2.s
```

# Размножение констант и копий

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| j4 = 2;<br>printf("%d", j4);<br>if (i2 < j4 && i4 < j4) {<br>&nbsp;&nbsp;&nbsp;&nbsp;i2 = 2;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", i2);<br>} | `movl $2, j4(%rip)`<br>`movl j4(%rip), %eax`<br>`movl %eax, %esi`<br>`leaq .LC0(%rip), %rax`<br>`movq %rax, %rdi`<br>`movl $0, %eax`<br>`call printf@PLT`<br>`movl i2(%rip), %edx`<br>`movl j4(%rip), %eax`<br>`cmpl %eax, %edx`<br>`jge .L2` | `xorl %eax, %eax`<br>`movl $2, %edi`<br>`leaq .LC0(%rip), %rbx`<br>`movq %rbx, %rsi`<br>`movl $2, j4(%rip)`<br>`call __printf_chk@PLT`<br>`movl j4(%rip), %eax`<br>`cmpl %eax, i2(%rip)`<br>`jge .L27` | При **O2** сохраняется адрес строки в регистре `%rbx`, также используется более быстрая инстуркция `xorl` вместо `movl`. |

## Свертка констант, арифметические тождества и излишние операции загрузки сохранения

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| i3 = 1 + 2; | `movl $3, i3(%rip)` | `movl $3, i3(%rip)` | Свертка констант в обоих случаях. |
| flt_1 = 2.4 + 6.3; | `movsd .LC1(%rip), %xmm0`<br>`movsd %xmm0, flt_1(%rip)` | `movq .LC1(%rip), %rax`<br>`movq %rax, flt_1(%rip)` | **O2** использует регистры общего назначения, вместо **SIMD** регистров. |
| i2 = 5; | `movl $5, i2(%rip)` | `movl $5, i2(%rip)` | Одинаково. |
| j2 = i + 0;<br>k2 = i / 1;<br>i4 = i * 1; | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl i(%rip), %eax`<br>`movl %eax, k2(%rip)`<br>`movl i(%rip), %eax`<br>`movl %eax, i4(%rip)` | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl %eax, k2(%rip)`<br>`movl %eax, i4(%rip)` | **O2** делает **одно чтение** из памяти вместо трех. |
| i5 = i * 0; | `movl $0, i5(%rip)` | `movl $0, i5(%rip)` | Одинаково. |
| flt_3 = 2.4 / 1.0; | `movsd .LC3(%rip), %xmm0`<br>`movsd %xmm0, flt_3(%rip)` | `movsd .LC3(%rip), %xmm0`<br>`movsd %xmm0, flt_3(%rip)` | Одинаково. |
| flt_4 = 1.0 + 0.0000001; | `movsd .LC4(%rip), %xmm0`<br>`movsd %xmm0, flt_4(%rip)` | `movq .LC4(%rip), %rax`<br>`movq %rax, flt_4(%rip)` | **O2** использует регистры общего назначения, вместо **SIMD** регистров. |
| flt_5 = flt_6 * 0.0; | `pxor %xmm0, %xmm0`<br>`mulsd flt_6(%rip), %xmm0`<br>`movsd %xmm0, flt_5(%rip)` | `pxor %xmm1, %xmm1`<br>`movsd %xmm1, flt_5(%rip)` | **O2** полностью удаляет умножение, сразу записывает 0. |
| flt_6 = flt_2 * flt_3; | `movsd flt_2(%rip), %xmm1`<br>`movsd flt_3(%rip), %xmm0`<br>`mulsd %xmm1, %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | `movsd %xmm0, flt_3(%rip)`<br>`mulsd flt_2(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | **O2** использует меньше инструкции, не использует дополнительный регистр. |

## Лишние присваивания

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| k3 = 1;<br>k3 = 1; | `movl $1, k3(%rip)`<br>`movl $1, k3(%rip)` | `movl $1, k3(%rip)` | **O2** загружает значение один раз. |

## Снижение мощности

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| k2 = 4 * j5;<br>for (i = 0; i <= 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = i * 2; | `movl j5(%rip), %eax`<br>`sall $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movl $0, i(%rip)`<br>`.L5:`<br>`movl i(%rip), %eax`<br>`leal (%rax,%rax), %edx`<br>`...` *(14 инструкций на итерацию)*<br>`cmpl $5, %eax`<br>`jle .L5` | `movl j5(%rip), %eax`<br>`sall $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movl $655368, 8+ivector4(%rip)`<br>`movq .LC6(%rip), %rax`<br>`movq %rax, ivector4(%rip)` | **O2** вычисляет значения (0,2,4,6,8,10) на этапе компиляции, записывает за 3 инструкции вместо 84. Цикл полностью отсутствует. |

## Простой цикл

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| j5 = 0;<br>k5 = 10000;<br>do {<br>&nbsp;&nbsp;&nbsp;&nbsp;k5 = k5 - 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;j5 = j5 + 1<br>&nbsp;&nbsp;&nbsp;&nbsp;i5 = (k5 * 3) / (j5 * constant5);<br>} while (k5 > 0); | `movl $0, j5(%rip)`<br>`movl $10000, k5(%rip)`<br>`.L6:`<br>`movl k5(%rip), %eax`<br>`subl $1, %eax`<br>`movl %eax, k5(%rip)`<br>`movl j5(%rip), %eax`<br>`addl $1, %eax`<br>`movl %eax, j5(%rip)`<br>`...`<br>`idivl %esi`<br>`movl %eax, i5(%rip)`<br>`testl %eax, %eax`<br>`jg .L6` | `movl $10000, j5(%rip)`<br>`movl $0, i5(%rip)` | **O2** полностью удалён цикл. Весь цикл заменен двумя инстуркциями. |

## Управление переменной индукции цикла

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| for (i = 0; i < 100; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector5[i * 2 + 3] = 5; | `movl $0, i(%rip)`<br>`.L8:`<br>`addl %eax, %eax`<br>`addl $3, %eax`<br>`leaq 0(,%rax,4), %rdx`<br>`movl $5, (%rdx,%rax)`<br>`...`<br>`cmpl $99, %eax`<br>`jle .L8` | `leaq 12+ivector5(%rip), %rax`<br>`leaq 800(%rax), %rdx`<br>`.L29:`<br>`movl $5, (%rax)`<br>`addq $16, %rax`<br>`movl $5, -8(%rax)`<br>`cmpq %rax, %rdx`<br>`jne .L29` | **O2** применяет раскрутку цикла и заменяет вычисление индекса на адресную арифметику. |

## Глубокие подвыражения

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| if (i < 10) <br> &nbsp;&nbsp;&nbsp;&nbsp;j5 = i5 + i2;<br> else <br> &nbsp;&nbsp;&nbsp;&nbsp;k5 = i5 + i2; | `cmpl $9, %eax`<br>`jg .L9`<br>`movl i5(%rip), %edx`<br>`addl i2(%rip), %edx`<br>`movl %edx, j5(%rip)`<br>`jmp .L10`<br>`.L9:`<br>`movl i5(%rip), %edx`<br>`addl i2(%rip), %edx`<br>`movl %edx, k5(%rip)` | `movl i2(%rip), %eax`<br>`movl %eax, k5(%rip)` | **O2** полностью отсутствует ветвление и так как до этого было вычеслено `i5 = 0`, выражение `i5 + i2` превращается в `i2` |

## Проверка того, как компилятор генерирует адрес переменной с константным индексом, размножает копии и регистры

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| ivector[0] = 1;<br>printf("%d", ivector[0]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[2] = 3;<br>printf("%d", ivector[2]); | `movl $1, ivector(%rip)`<br>`movl ivector(%rip), %eax`<br>`movl %eax, %esi`<br>`...`<br>`movl i2(%rip), %eax`<br>`cltq`<br>`leaq 0(,%rax,4), %rdx`<br>`movl $2, (%rdx,%rax)`<br>`movl i2(%rip), %eax`<br>`cltq`<br>`leaq 0(,%rax,4), %rdx`<br>`movl (%rdx,%rax), %eax`<br>`...`<br>`movl $3, 8+ivector(%rip)`<br>`movl 8+ivector(%rip), %eax` | `leaq ivector(%rip), %rbp`<br>`movl $1, ivector(%rip)`<br>`movl $1, %edx`<br>`call __printf_chk@PLT`<br>`movslq i2(%rip), %rax`<br>`movl $2, 0(%rbp,%rax,4)`<br>`movl $2, %edx`<br>`call __printf_chk@PLT`<br>`...`<br>`movl $3, 8+ivector(%rip)`<br>`movl $3, %edx`<br>`call __printf_chk@PLT` | **O2** сохраняет адрес начала массива в `%rbp`. Устраняет чтения из памяти перед `printf` — константы `$1`, `$2`, `$3` передаются напрямую в регистр аргумента `%edx`. Использует `__printf_chk` вместо `printf`. |

## Удаление общих подвыражений

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| if ((h3 + k3) < 0 \|\| (h3 + k3) > 5)<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("Common subexpression elimination\n");<br>else {<br>&nbsp;&nbsp;&nbsp;&nbsp;m3 = (h3 + k3) / i3;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", m3);<br>&nbsp;&nbsp;&nbsp;&nbsp;g3 = i3 + (h3 + k3);<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", g3);<br>} | `movl h3(%rip), %edx`<br>`addl k3(%rip), %eax`<br>`testl %eax, %eax`<br>`js .L11`<br>`movl h3(%rip), %edx`<br>`addl k3(%rip), %eax`<br>`cmpl $5, %eax`<br>`...`<br>`movl h3(%rip), %edx`<br>`addl k3(%rip), %eax`<br>`idivl %ecx`<br>`...`<br>`addl %edx, %eax`<br>`movl %eax, g3(%rip)` | `movl k3(%rip), %eax`<br>`addl h3(%rip), %eax`<br>`cmpl $5, %eax`<br>`jbe .L30`<br>`call puts@PLT`<br>`.L30:`<br>`idivl i3(%rip)`<br>`movl %eax, m3(%rip)`<br>`call __printf_chk@PLT`<br>`movl k3(%rip), %edx`<br>`addl h3(%rip), %edx`<br>`addl i3(%rip), %edx`<br>`movl %edx, g3(%rip)`<br>`call __printf_chk@PLT` | **O2** вычисляет `(h3+k3)` один раз и переиспользует результат |

## Вынесение инвариантного кода

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| for (i4 = 0; i4 <= max_vector; i4++){<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector2[i4] = j * k;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector2[i4]);<br>} | `movl $0, i4(%rip)`<br>`jmp .L14`<br>`.L15:`<br>`movl j(%rip), %eax`<br>`movl %eax, %esi`<br>`movl k(%rip), %eax`<br>`movl %eax, %edx`<br>`movl %esi, %eax`<br>`imull %edx, %eax`<br>`...`<br>`call printf@PLT`<br>`...`<br>`cmpl $2, %eax`<br>`jle .L15` | `movl $0, i4(%rip)`<br>`xorl %ecx, %ecx`<br>`leaq ivector2(%rip), %rbp`<br>`.L32:`<br>`movzbl j(%rip), %eax`<br>`movslq %ecx, %rcx`<br>`movq %rbx, %rsi`<br>`movl $2, %edi`<br>`mulb k(%rip)`<br>`movb %al, 0(%rbp,%rcx)`<br>`movzbl %al, %edx`<br>`xorl %eax, %eax`<br>`call __printf_chk@PLT`<br>`...`<br>`cmpl $2, %ecx`<br>`jle .L32` | **O2** выносит адрес начала массива в `%rbp` перед циклом, использует байтовое умножение `mulb` вместо `imull`. Выражение `j * k` осталось внутри цикла, но оптимизировано на уровне отдельных инструкций. |

## Вызов функции

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| dead_code(1, "This line should not be printed");<br>unnecessary_loop();<br>loop_jamming(7);<br>loop_unrolling(7);<br>jump_compression(1, 2, 3, 4, 5); | `leaq .LC6(%rip), %rax`<br>`movq %rax, %rsi`<br>`movl $1, %edi`<br>`call dead_code`<br>`call unnecessary_loop`<br>`movl $7, %edi`<br>`call loop_jamming`<br>`...`<br>`call jump_compression` | `call unnecessary_loop`<br>`movl $7, %edi`<br>`call loop_jamming`<br>`movl $7, %edi`<br>`call loop_unrolling`<br>`movl $5, %r8d`<br>`...`<br>`call jump_compression` | **O2** полностью удаляет вызов `dead_code`. Передача аргументов в обоих случаях через регистры, без обращения к стеку. |

## Функция: dead_code

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| void dead_code(int a, char *b)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int idead_store;<br>&nbsp;&nbsp;&nbsp;&nbsp;idead_store = a;<br>&nbsp;&nbsp;&nbsp;&nbsp;if (0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%s\n", b);<br>} | `pushq %rbp`<br>`movq %rsp, %rbp`<br>`movl %edi, -20(%rbp)`<br>`movl -20(%rbp), %eax`<br>`movl %eax, -4(%rbp)`<br>`nop`<br>`popq %rbp`<br>`ret` | `.cfi_startproc`<br>`endbr64`<br>`ret` | **O2** полностью удаляет создание фрейма стека и бесполезные присваивания. Так как ветка `if (0)` недостижима, а аргументы нигде не используются`ret`. |

## Функция: unnecessary_loop

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| void unnecessary_loop()<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int x;<br>&nbsp;&nbsp;&nbsp;&nbsp;x = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>} | `pushq %rbp`<br>`subq $16, %rsp`<br>`movl $0, i(%rip)`<br>`.L20:`<br>`addl %edx, %eax`<br>`movl %eax, k5(%rip)`<br>`...`<br>`jle .L20`<br>`call printf@PLT` | `movl j5(%rip), %edx`<br>`leaq .LC0(%rip), %rsi`<br>`movl $2, %edi`<br>`xorl %eax, %eax`<br>`movl $5, i(%rip)`<br>`movl %edx, k5(%rip)`<br>`jmp __printf_chk@PLT` | **O2** полностью удаляя цикл. Так как `x = 0`, выражение `x + j5` сворачивается до простого чтения `j5`, переменной `i` сразу присваивается итоговое значение `5`, а вызов функции заменен на хвостовой `jmp`. |

## Функция: loop_jamming

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| void loop_jamming(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i5 = x * k5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `movl $0, i(%rip)`<br>`jmp .L22`<br>`.L23:`<br>`...`<br>`imull %eax, %edx`<br>`addl %edx, %eax`<br>`movl %eax, k5(%rip)`<br>`...`<br>`call printf@PLT`<br>`...`<br>`.L25:`<br>`imull -4(%rbp), %eax`<br>`...`<br>`call printf@PLT` | `movl $0, i(%rip)`<br>`.L5:`<br>`imull j5(%rip), %edx`<br>`addl %ebx, %edx`<br>`movl %edx, k5(%rip)`<br>`call __printf_chk@PLT`<br>`...`<br>`.L6:`<br>`imull %ebx, %edx`<br>`...`<br>`call __printf_chk@PLT` | **O2** нет слияние циклов. Однако оптимизировал передачу аргументов регистр `%ebx` вместо стека `-4(%rbp)` и заменил `printf` на `__printf_chk`. |

## Функция: loop_unrolling

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| void loop_unrolling(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 6; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector4[i]);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `movl $0, i(%rip)`<br>`.L28:`<br>`cltq`<br>`leaq (%rax,%rax), %rdx`<br>`leaq ivector4(%rip), %rax`<br>`movw $0, (%rdx,%rax)`<br>`...`<br>`call printf@PLT`<br>`...`<br>`cmpl $5, %eax`<br>`jle .L28` | `xorl %eax, %eax`<br>`leaq ivector4(%rip), %rbp`<br>`leaq .LC0(%rip), %rbx`<br>`.L11:`<br>`cltq`<br>`xorl %edx, %edx`<br>`movw %dx, 0(%rbp,%rax,2)`<br>`xorl %edx, %edx`<br>`call __printf_chk@PLT`<br>`...`<br>`cmpl $5, %eax`<br>`jle .L11` | **O2** не выполнил раскрутку цикла. Однако вынес адрес начала массива в `%rbp` и строку формата в `%rbx`. |

## Функция: jump_compression

| Исходный код | GCC_O0 | GCC_O2 | Вывод |
|---|---|---|---|
| int jump_compression(int i, int j, int k, int l, int m)<br>{<br>beg_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;if (i < j)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (j < k)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (k < l)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (l < m)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;l += m;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto end_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k += l;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j += k;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", j);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto beg_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i += j;<br>&nbsp;&nbsp;&nbsp;&nbsp;return(i + j + k + l + m);<br>} | `movl %edi, -4(%rbp)`<br>`...`<br>`.L30:`<br>`cmpl -8(%rbp), %eax`<br>`jge .L31`<br>`...`<br>`jmp .L30`<br>`.L38:`<br>`nop`<br>`.L36:`<br>`jmp .L30`<br>`.L31:`<br>`addl %eax, -4(%rbp)`<br>`.L35:`<br>`...`<br>`ret` | `movl %r8d, %r14d`<br>`...`<br>`movl %esi, %ebx`<br>`cmpl %edi, %esi`<br>`jg .L15`<br>`jmp .L16`<br>`.L25:`<br>`...`<br>`jle .L16`<br>`.L15:`<br>`addl %ebp, %ebx`<br>`call __printf_chk@PLT`<br>`jg .L15`<br>`.L16:`<br>`addl %ebx, %r12d`<br>`.L20:`<br>`leal (%r12,%rbx), %eax`<br>`...`<br>`ret` | **O2** применяет все аргументы в регистрах `%r12d`, `%ebx`, `%ebp`, `%r13d`, `%r14d` вместо стека, цепочки `goto beg_1`/`goto end_1` заменены на компактный цикл с метками `.L15` `.L25`, удалены лишние `jmp` и `nop`. |
