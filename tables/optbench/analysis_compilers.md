# Сравнение и анализ оптимизаций компиляторов

# Размножение констант и копий
Проверить, заменят ли компиляторы при -O2 переменную j4 = 2 на константу 2 во всех местах использования.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| j4 = 2;<br>printf("%d", j4);<br>if (i2 < j4 && i4 < j4) {<br>&nbsp;&nbsp;&nbsp;&nbsp;i2 = 2;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", i2);<br>} | `xorl %eax, %eax`<br>`movl $2, %edi`<br>`leaq .LC0(%rip), %rbx`<br>`movq %rbx, %rsi`<br>`movl $2, j4(%rip)`<br>`call __printf_chk@PLT`<br>`movl j4(%rip), %eax`<br>`cmpl %eax, i2(%rip)`<br>`jge .L27` | `movl $2, j4(%rip)`<br>`movl $2, %esi`<br>`callq printf@PLT`<br>`movl i2(%rip), %r14d`<br>`cmpl $1, %r14d`<br>`jg .LBB0_3`<br>...<br>`movl $2, %esi` | `movl $2, %esi`<br>`...`<br>`callq printf`<br>`movl i2(%rip), %r14d`<br>`movl i4(%rip), %ebp`<br>`cmpl $1, %r14d`<br>`jg .LBB0_3`<br>`# %bb.1:`<br>`cmpl $1, %ebp`<br>`jg .LBB0_3`<br>`...` |

**Вывод:** Все компиляторы подставили константу 2 в вызов printf. GCC сохранил значение в переменную j4, а затем считал её обратно для проверки условия. AOCC также сохранил j4, но для передачи в printf и для условия использовал константу, заменив i2 < 2 на i2 <= 1. ICX также заменил проверки i2 < 2 и i4 < 2 на сравнения с единицей, но в отличие от AOCC и GCC не стал сохранять '2' в переменной j4. ICX логичнее всех оптимизировал код, убрав ненужные обращения к памяти.

## Свертка констант, арифметические тождества и излишние операции загрузки сохранения
Исследовать, будут ли выражения 1 + 2 и 2.4 + 6.3 вычислены на этапе компиляции. Посмотреть, заменят ли компиляторы операции i + 0, i / 1, i * 1 на инструкцию mov, а i * 0 — на обнуление регистра. Проверить, сохранят ли компиляторы инструкцию умножения для выражения flt_6 * 0.0.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| i3 = 1 + 2; | `movl $3, i3(%rip)` | `movl $3, i3(%rip)` | `movl $3, i3(%rip)` |
| flt_1 = 2.4 + 6.3; | `movq .LC1(%rip), %rax`<br>`movq %rax, flt_1(%rip)` | `movabsq $4621087282649523814, %rax`<br>`movq %rax, flt_1(%rip)` | `movabsq $4621087282649523814, %rax`<br>`movq %rax, flt_1(%rip)` |
| i2 = 5; | `movl $5, i2(%rip)` | `movl $5, i2(%rip)` | `movl $5, i2(%rip)` |
| j2 = i + 0;<br>k2 = i / 1;<br>i4 = i * 1; | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl %eax, k2(%rip)`<br>`movl %eax, i4(%rip)` | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl %eax, i4(%rip)` | `movl i(%rip), %eax`<br>`movl %eax, j2(%rip)`<br>`movl %eax, k2(%rip)`<br>`movl %eax, i4(%rip)` |
| i5 = i * 0; | `movl $0, i5(%rip)` | `отсутствует` | `movl $0, i5(%rip)` |
| flt_3 = 2.4 / 1.0; | `movsd .LC3(%rip), %xmm0`<br>`movsd %xmm0, flt_3(%rip)` | `movabsq $4612586738352862003, %rax`<br>`movq %rax, flt_3(%rip)` | `movabsq $4612586738352862003, %rax`<br>`movq %rax, flt_3(%rip)` |
| flt_4 = 1.0 + 0.0000001; | `movq .LC4(%rip), %rax`<br>`movq %rax, flt_4(%rip)` | `movabsq $4607182419250377371, %rax`<br>`movq %rax, flt_4(%rip)` | `movabsq $4607182419250377371, %rax`<br>`movq %rax, flt_4(%rip)` |
| flt_5 = flt_6 * 0.0;| `pxor %xmm1, %xmm1`<br>`movsd %xmm1, flt_5(%rip)` | `xorpd %xmm0, %xmm0`<br>`mulsd flt_6(%rip), %xmm0`<br>`movsd %xmm0, flt_5(%rip)` | `xorpd %xmm0, %xmm0`<br>`mulsd flt_6(%rip), %xmm0`<br>`movsd %xmm0, flt_5(%rip)` |
| flt_6 = flt_2 * flt_3; | `movsd %xmm0, flt_3(%rip)`<br>`mulsd flt_2(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | `movsd flt_2(%rip), %xmm0`<br>`mulsd .LCPI0_0(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` | `movsd flt_2(%rip), %xmm0`<br>`mulsd .LCPI0_0(%rip), %xmm0`<br>`movsd %xmm0, flt_6(%rip)` |

**Вывод:** Все компиляторы выполнили свёртку констант, выражения 1 + 2, 2.4 + 6.3, 2.4 / 1.0, 1.0 + 0.0000001 вычислились на этапе компиляции. GCC загрузил готовые значения из .rodata, а AOCC и ICX использовали загрузку 64-битной константы через movabsq. Для тождеств i + 0, i / 1, i * 1 GCC и ICX выполнили одно чтение i и несколько записей, а AOCC дополнительно удалил запись в k2. Выражение i * 0 GCC и ICX свернули, а AOCC удалил это выражение. Для flt_5 = flt_6 * 0.0 GCC удалил умножение, а AOCC и ICX сохранили его. Наиболее эффективную оптимизацию в данном фрагменте продемонстрировал AOCC. Компилятор применил наиболее глубокий анализ потоков данных, удалив избыточные записи в переменные k2 и i5. Кроме того, AOCC использовал прямую загрузку 64-битных констант через инструкцию movabsq, избежав лишних обращений к памяти, характерных для GCC.

## Лишние присваивания
Проверить, удалят ли компиляторы лишнее присваивание.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| k3 = 1;<br>k3 = 1; | `movl $1, k3(%rip)` | `movl	$1, k3(%rip)` | `movl $1,k3(%rip)` |

**Вывод:** Все компиляторы удалили повторное присваивание. В этом блоке нет различий между компиляторами.


## Снижение мощности
Исследовать, заменят ли компиляторы умножение 4 * j5 на сдвиг. Посмотреть, как компиляторы обработают i * 2 внутри цикла — возможно, умножение будет заменено на сложение add.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| k2 = 4 * j5;<br>for (i = 0; i <= 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = i * 2; | `movl j5(%rip), %eax`<br>`sall $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movl $655368, 8+ivector4(%rip)`<br>`movq .LC6(%rip), %rax`<br>`movq %rax, ivector4(%rip)` | `movl j5(%rip), %eax`<br>`shll $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movabsq $1688867040264192, %rax`<br>`movq %rax, ivector4(%rip)`<br>`movl $655368, ivector4+8(%rip)` | `movl j5(%rip), %eax`<br>`shll $2, %eax`<br>`movl %eax, k2(%rip)`<br>`movabsq $1688867040264192, %rax`<br>`movq %rax, ivector4(%rip)`<br>`movl $655368, ivector4+8(%rip)` |

**Вывод:** Все компиляторы заменили умножение 4 * j5 на сдвиг shll $2 / sall $2. Цикл, который заполняет ivector4, удалён. Компиляторы предвычислили значения массива 0, 2, 4, 6, 8, 10 и записали их. AOCC и ICX использовали прямую загрузку 64-битной константы через movabsq, избежав обращения к памяти. GCC загрузил константу из .rodata, что требует дополнительного обращения к памяти. AOCC и ICX оптимизировали код эффективнее.

## Простой цикл
Проверить, удалят ли компиляторы при -O2 цикл, вычислив его на этапе компиляции.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| j5 = 0;<br>k5 = 10000;<br>do {<br>&nbsp;&nbsp;&nbsp;&nbsp;k5 = k5 - 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;j5 = j5 + 1<br>&nbsp;&nbsp;&nbsp;&nbsp;i5 = (k5 * 3) / (j5 * constant5);<br>} while (k5 > 0); | `movl $10000, j5(%rip)`<br>`movl $0, i5(%rip)` | `movl $10000, j5(%rip)`<br>`movl $0, i5(%rip)` | `movl $10000, j5(%rip)`<br>`movl $0, i5(%rip)` |

**Вывод:** Все компиляторы удалили цикл. Вместо цикла компиляторы записали только конечные значения переменных: j5 = 10000 и i5 = 0. В этом блоке нет различий между компиляторами.

## Управление переменной индукции цикла
Посмотреть, устранит ли компилятор умножение i * 2 в выражении ivector5[i * 2 + 3] = 5. Возможно, будет введена переменная индукции, увеличивающаяся на 8 через add.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| for (i = 0; i < 100; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector5[i * 2 + 3] = 5; | `leaq 12+ivector5(%rip), %rax`<br>`leaq 800(%rax), %rdx`<br>`.L29:`<br>`movl $5, (%rax)`<br>`addq $16, %rax`<br>`movl $5, -8(%rax)`<br>`cmpq %rax, %rdx`<br>`jne .L29` |  `xorl %eax, %eax`<br>`leaq ivector5(%rip), %rcx`<br>`.LBB0_7:`<br>`movl $5, 12(%rcx,%rax,8)`<br>`movl $5, 20(%rcx,%rax,8)`<br>`movl $5, 28(%rcx,%rax,8)`<br>`movl $5, 36(%rcx,%rax,8)`<br>`addq $4, %rax`<br>`cmpq $100, %rax`<br>`jne .LBB0_7` | `movq $-768, %rax`<br>`.LBB0_7:`<br>`movl $5, ivector5+780(%rax)`<br>`movl $5, ivector5+788(%rax)`<br>`...`<br>`movl $5, ivector5+836(%rax)`<br>`addq $64, %rax`<br>`jne .LBB0_7` |

**Вывод:** Все компиляторы заменили вычисление индекса i * 2 + 3 на адресную арифметику и развернули цикл. GCC развернул цикл в 2 раза, AOCC — в 4 раза, ICX — в 8 раз. ICX логичнее оптимизировал код, уменьшив накладные расходы на сравнение и условные переходы.

## Глубокие подвыражения
Исследовать, вычислят ли компиляторы выражение i5 + i2 один раз до проверки условия.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| if (i < 10) <br> &nbsp;&nbsp;&nbsp;&nbsp;j5 = i5 + i2;<br> else <br> &nbsp;&nbsp;&nbsp;&nbsp;k5 = i5 + i2; | `movl i2(%rip), %eax`<br>`movl %eax, k5(%rip)` | `movl $100, i(%rip)`<br>`movl $5, k5(%rip)` | `movl	$100, i(%rip)`<br>`movl $5, k5(%rip)` |

**Вывод:** Все компиляторы учли, что после предыдущего цикла переменная i = 100, тогда условие i < 10 всегда ложно. ICX свернул результат i5 + i2 до константы 5 и выполнил одну запись. AOCC также записал константу 5 и сохранил значение i = 100. GCC считал i2 из памяти и свернул выражение. IAOCC и ICX эффективнее оптимизировали код, убрав лишние обращения к памяти.


## Проверка того, как компилятор генерирует адрес переменной с константным индексом, размножает копии и регистры
Проверить, как компиляторы сгенерируют адрес для ivector[i2]. Возможно, будет использована прямая адресация по смещению ([rbp+20]) вместо индексного регистра.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| ivector[0] = 1;<br>printf("%d", ivector[0]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[i2] = 2;<br>printf("%d", ivector[i2]);<br>ivector[2] = 3;<br>printf("%d", ivector[2]); | `leaq ivector(%rip), %rbp`<br>`movl $1, ivector(%rip)`<br>`movl $1, %edx`<br>`call __printf_chk@PLT`<br>`movslq i2(%rip), %rax`<br>`movl $2, 0(%rbp,%rax,4)`<br>`movl $2, %edx`<br>`call __printf_chk@PLT`<br>`...`<br>`movl $3, 8+ivector(%rip)`<br>`movl $3, %edx`<br>`call __printf_chk@PLT` | `movl $1, ivector(%rip)`<br>`movl $1, %esi`<br>`callq printf@PLT`<br>`movl $2, ivector+20(%rip)`<br>`movl $2, %esi`<br>`callq printf@PLT`<br>...<br>`movl $3, ivector+8(%rip)`<br>`movl $3, %esi`<br>`callq printf@PLT` | `movl $1, ivector(%rip)`<br>`movl $1, %esi`<br>`...`<br>`callq printf`<br>`movl $2, ivector+20(%rip)`<br>`movl $2, %esi`<br>`...`<br>`callq printf`<br>`movl $3, ivector+8(%rip)`<br>`movl $3, %esi`<br>`...`<br>`callq printf` |

**Вывод:** AOCC и ICX использовали значение i2 = 5, поэтому обращение ivector[i2] заменилось на адрес ivector+20. GCC сохранил вычисление индекса через регистр. Все компиляторы устранили лишние чтения из памяти перед printf, передавав значения 1, 2, 3 как константы. Избыточные повторные операции удалены. AOCC и ICX логичнее оптимизировали код, убрав одну загрузку из памяти и одну инструкцию адресации.

## Удаление общих подвыражений
Посмотреть, вычислят ли компиляторы выражение (h3 + k3) один раз и сохранят ли результат в регистре для всех операций, вместо 4 отдельных инструкций add.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| if ((h3 + k3) < 0 \|\| (h3 + k3) > 5)<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("Common subexpression elimination\n");<br>else {<br>&nbsp;&nbsp;&nbsp;&nbsp;m3 = (h3 + k3) / i3;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", m3);<br>&nbsp;&nbsp;&nbsp;&nbsp;g3 = i3 + (h3 + k3);<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", g3);<br>} | `movl k3(%rip), %eax`<br>`addl h3(%rip), %eax`<br>`cmpl $5, %eax`<br>`jbe .L30`<br>`call puts@PLT`<br>`.L30:`<br>`idivl i3(%rip)`<br>`movl %eax, m3(%rip)`<br>`call __printf_chk@PLT`<br>`movl k3(%rip), %edx`<br>`addl h3(%rip), %edx`<br>`addl i3(%rip), %edx`<br>`movl %edx, g3(%rip)`<br>`call __printf_chk@PLT` | `movl h3(%rip), %ebx`<br>`leal -5(%rbx), %eax`<br>`cmpl $-7, %eax`<br>`ja .LBB0_10`<br>...<br>`leal -2(%rbx), %eax`<br>`cmpl $-3, %eax`<br>`setb %sil`<br>`movl %esi, m3(%rip)`<br>...<br>`addl $4, %ebx`<br>`movl %ebx, g3(%rip)` | `movl h3(%rip), %ebx`<br>`leal 1(%rbx), %eax`<br>`cmpl $5, %eax`<br>`jbe .LBB0_9`<br>`...`<br>`.LBB0_9:`<br>`movl %eax, %eax`<br>`movl $2863311531, %esi`<br>`imulq %rax, %rsi`<br>`shrq $33, %rsi`<br>`movl %esi, m3(%rip)`<br>`...`<br>`addl $4, %ebx`<br>`movl %ebx, g3(%rip)` |

**Вывод:** 
Все три компилятора применили устранение общих подвыражений, вычислив выражение h3 + k3 один раз для проверок условий, но дальнейшее использование результата различается. GCC вычислил выражение h3 + k3 и переиспользовал его, но деление остаётся инструкцией idivl. AOCC и ICX ведут себя более схоже: они учли, что k3 = 1 и i3 = 3. AOCC превратил проверки в диапазонные сравнения и заменил деление на последовательность с setb. ICX вычислил h3 + 1 через leal и заменил деление на 3 умножением на константу с последующим сдвигом. AOCC и ICX в этом блоке показали более сильное устранение общих подвыражений и снижение стоимости операций. В этом блоке логичнее оптимизировал код - ICX. Компилятор не только вычислил общее подвыражение один раз через быструю инструкцию leal, но и применил оптимизацию деления на константу, заменив дорогостоящую инструкцию idivl на комбинацию imul + shrq, что дает ускорение в 5-10 раз для этой операции.

## Вынесение инвариантного кода

Исследовать, вынесут ли компиляторы выражение j * k, которое не зависит от переменной i4 перед циклом. Возможно, внутри цикла останется только запись в память и инкремент счетчика

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| for (i4 = 0; i4 <= max_vector; i4++){<br>&nbsp;&nbsp;&nbsp;&nbsp;ivector2[i4] = j * k;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector2[i4]);<br>} | `movl $0, i4(%rip)`<br>`xorl %ecx, %ecx`<br>`leaq ivector2(%rip), %rbp`<br>`.L32:`<br>`movzbl j(%rip), %eax`<br>`movslq %ecx, %rcx`<br>`movq %rbx, %rsi`<br>`movl $2, %edi`<br>`mulb k(%rip)`<br>`movb %al, 0(%rbp,%rcx)`<br>`movzbl %al, %edx`<br>`xorl %eax, %eax`<br>`call __printf_chk@PLT`<br>`...`<br>`cmpl $2, %ecx`<br>`jle .L32` | `movl k(%rip), %eax`<br>`imull j(%rip), %eax`<br>`movzbl %al, %ebp`<br>`movb %bpl, ivector2(%rip)`<br>`movl %ebp, %esi`<br>`callq printf@PLT`<br>`movb %bpl, ivector2+1(%rip)`<br>`movl %ebp, %esi`<br>`callq printf@PLT`<br>`movb %bpl, ivector2+2(%rip)`<br>`movl %ebp, %esi`<br>`callq printf@PLT` | `movl k(%rip), %eax`<br>`imull j(%rip), %eax`<br>`movzbl %al, %ebx`<br>`xorl %r14d, %r14d`<br>`.LBB0_11:`<br>`movb %bl, ivector2(%r14)`<br>`...`<br>`movb %bl, ivector2+3(%r14)`<br>`...`<br>`addq $4, %r14`<br>`...`<br>`js .LBB0_11` |

**Вывод:** GCC не вынес умножение j * k из цикла, оставив его внутри тела цикла. AOCC и ICX вынесли выражение j * k до цикла. AOCC развернул цикл на 3 итерации без лишнего кода. ICX также вынес инвариант и развернул цикл, но сгенерировал ненужный код с дополнительными проверками. В этом фрагменте логичнее оптимизировал код - AOCC, так как вынес инвариант и не сгенерировал ненужный код.

## Вызов функции
Проверить, применят ли компиляторы встраивание и последующее упрощение кода.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| dead_code(1, "This line should not be printed");<br>unnecessary_loop();<br>loop_jamming(7);<br>loop_unrolling(7);<br>jump_compression(1, 2, 3, 4, 5); | `call unnecessary_loop`<br>`movl $7, %edi`<br>`call loop_jamming`<br>`movl $7, %edi`<br>`call loop_unrolling`<br>`movl $5, %r8d`<br>`...`<br>`call jump_compression` | *(отсутствует)*<br><br>`movl $10000, k5(%rip)`<br>`...`<br>`callq printf@PLT`<br><br>`movl $7, k5(%rip)`<br>`...`<br>`callq printf@PLT`<br><br>`movw $0, ivector4(%rip)`<br>`...`<br>`callq printf@PLT`<br><br>*(отсутствует)* | `# dead_code — отсутствует`<br>`# unnecessary_loop, цикл удалён`<br>`movl $10000, %esi`<br>`callq printf`<br>`# loop_jamming, оба цикла развёрнуты`<br>`movl $7, %esi`<br>`callq printf`<br>`movl $10007, %esi`<br>`callq printf`<br>`...`<br>`# loop_unrolling, цикл развёрнут`<br>`movq $0, ivector4(%rip)`<br>`...`<br>`# jump_compression — отсутствует` | 

**Вывод:** GCC удалил только вызов dead_code, остальные функции остались обычными вызовами. AOCC и ICX встроили функции в main. AOCC и ICX удалили или существенно упростили циклы внутри функций и убирали накладные расходы на вызовы, но увеличили размер файла.

## Функция: dead_code
Проверить, удалят ли компиляторы вызов printf внутри dead_code.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| void dead_code(int a, char *b)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int idead_store;<br>&nbsp;&nbsp;&nbsp;&nbsp;idead_store = a;<br>&nbsp;&nbsp;&nbsp;&nbsp;if (0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%s\n", b);<br>}  | `.cfi_startproc`<br>`endbr64`<br>`ret` | `dead_code:`<br>&nbsp;&nbsp;`retq` |  `dead_code:`<br>`retq` |

**Вывод:** Все компиляторы удалили тело функции dead_code. Различий в оптимизации между компиляторами в этом блоке нет.

## Функция: unnecessary_loop
Посмотреть, удалят ли компиляторы цикл в unnecessary_loop.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| void unnecessary_loop()<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;int x;<br>&nbsp;&nbsp;&nbsp;&nbsp;x = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5;<br>&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>} | `movl j5(%rip), %edx`<br>`leaq .LC0(%rip), %rsi`<br>`movl $2, %edi`<br>`xorl %eax, %eax`<br>`movl $5, i(%rip)`<br>`movl %edx, k5(%rip)`<br>`jmp __printf_chk@PLT` | `movl j5(%rip), %esi`<br>`movl %esi, k5(%rip)`<br>`movl $5, i(%rip)`<br>`leaq .L.str(%rip), %rdi`<br>`xorl %eax, %eax`<br>`jmp printf@PLT` | `movl j5(%rip), %esi`<br>`movl %esi, k5(%rip)`<br>`movl $5, i(%rip)`<br>`movl $.L.str, %edi`<br>`xorl %eax, %eax`<br>`jmp printf` |

**Вывод:** Все компиляторы удалили цикл. В оптимизированном коде осталось только присваивание k5 = j5 и i = 5. Вызов printf заменился на хвостовой jmp, что уменьшило накладные расходы на возврат из функции.  Различий между компиляторами в этом блоке нет, все три показали одинаковый результат.

## Функция: loop_jamming
Исследовать, выполнят ли компиляторы слияние двух циклов с одинаковыми границами в loop_jamming в один.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2|
|---|---|---|---|
| void loop_jamming(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k5 = x + j5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 5; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i5 = x * k5 * i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", k5);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `movl $0, i(%rip)`<br>`.L5:`<br>`imull j5(%rip), %edx`<br>`addl %ebx, %edx`<br>`movl %edx, k5(%rip)`<br>`call __printf_chk@PLT`<br>`...`<br>`.L6:`<br>`imull %ebx, %edx`<br>`...`<br>`call __printf_chk@PLT` | *(Циклы отсутствуют)*<br>`movl $0, i(%rip)`<br>`movl %edi, k5(%rip)`<br>`callq printf@PLT`<br>`movl $1, i(%rip)`<br>`leal (%r15,%rbx), %esi`<br>`movl %esi, k5(%rip)`<br>`callq printf@PLT`<br>`...`<br>`movl $4, i(%rip)`<br>`leal (%rbx,%r15,4), %ebp`<br>`movl %ebp, k5(%rip)`<br>`callq printf@PLT`<br><br>`movl $0, i(%rip)`<br>`movl $0, i5(%rip)`<br>`callq printf@PLT`<br>`...`<br>`movl $4, i(%rip)`<br>`shll $2, %ebx`<br>`movl %ebx, i5(%rip)`<br>`callq printf@PLT`<br>`movl $5, i(%rip)` | `movl %edi, k5(%rip)`<br>`callq printf`<br>`leal (%rbx,%r14), %esi`<br>`movl %esi, k5(%rip)`<br>`callq printf`<br>`leal (%rbx,%r14,2), %esi`<br>`movl %esi, k5(%rip)`<br>`callq printf`<br>`...`<br>`leal (%rbx,%r14,4), %ebp`<br>`movl %ebp, k5(%rip)`<br>`callq printf`<br>`movl $0, i5(%rip)`<br>`callq printf`<br>`imull %ebp, %ebx`<br>`movl %ebx, i5(%rip)`<br>`callq printf`<br>`...`<br>`movl $5, i(%rip)` |

**Вывод:** Ни один компилятор не выполнил слияние циклов, так как второй цикл зависит от конечного значения k5, вычисленного в первом цикле. GCC сохраняет циклы. AOCC и ICX эффективнее оптимизировали код в этом фрагменте так как, полностью развернули циклы, заменили часть умножений на leal и shll. Это уменьшило количество проверок и переходов, но увеличило размер кода. 

## Функция: loop_unrolling
Проверить, развернут ли компиляторы цикл в 6 последовательных блоков без переходов.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| void loop_unrolling(int x)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;for (i = 0; i < 6; i++) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ivector4[i] = 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", ivector4[i]);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>} | `xorl %eax, %eax`<br>`leaq ivector4(%rip), %rbp`<br>`leaq .LC0(%rip), %rbx`<br>`.L11:`<br>`cltq`<br>`xorl %edx, %edx`<br>`movw %dx, 0(%rbp,%rax,2)`<br>`xorl %edx, %edx`<br>`call __printf_chk@PLT`<br>`...`<br>`cmpl $5, %eax`<br>`jle .L11` | *(Цикл отсутствует)*<br>`movl $0, i(%rip)`<br>`movw $0, ivector4(%rip)`<br>`callq printf@PLT`<br>`movl $1, i(%rip)`<br>`movw $0, ivector4+2(%rip)`<br>`callq printf@PLT`<br>`movl $2, i(%rip)`<br>`movw $0, ivector4+4(%rip)`<br>`callq printf@PLT`<br>`...`<br>`movl $5, i(%rip)`<br>`movw $0, ivector4+10(%rip)`<br>`callq printf@PLT`<br>`movl $6, i(%rip)` | `xorl %esi, %esi`<br>`callq printf`<br>`movl $1, i(%rip)`<br>`...`<br>`callq printf`<br>`movl $3, i(%rip)`<br>`movq $0, ivector4(%rip)`<br>`callq printf`<br>`movl $4, i(%rip)`<br>`movw $0, ivector4+8(%rip)`<br>`callq printf`<br>`movl $5, i(%rip)`<br>`movw $0, ivector4+10(%rip)`<br>`callq printf`<br>`movl $6, i(%rip)` |

**Вывод:** GCC не выполнил полную раскрутку цикла и оставлил цикл с вычислением индекса. AOCC полностью развернул цикл и использовал отдельные movw для каждого элемента массива. ICX также развернул цикл, но дополнительно объединил записи: инструкция movq $0 записывает сразу несколько элементов массива, что уменьшило количество инструкций записи. ICX логичнее оптимизировал код в этом блоке, благодаря развёртке цикла и уменьшению количества инструкций.

## Функция: jump_compression
Посмотреть, оптимизируют ли компиляторы цепочку переходов goto end_1 → goto beg_1 в jump_compression. Возможно, косвенный переход будет заменен на прямой переход на beg_1.

| Исходный код | GCC_O2 | AOCC_O2 | ICX_O2 |
|---|---|---|---|
| int jump_compression(int i, int j, int k, int l, int m)<br>{<br>beg_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;if (i < j)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (j < k)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (k < l)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (l < m)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;l += m;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto end_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k += l;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j += k;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf("%d", j);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end_1:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto beg_1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;else<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i += j;<br>&nbsp;&nbsp;&nbsp;&nbsp;return(i + j + k + l + m);<br>} | `movl %r8d, %r14d`<br>`...`<br>`movl %esi, %ebx`<br>`cmpl %edi, %esi`<br>`jg .L15`<br>`jmp .L16`<br>`.L25:`<br>`...`<br>`jle .L16`<br>`.L15:`<br>`addl %ebp, %ebx`<br>`call __printf_chk@PLT`<br>`jg .L15`<br>`.L16:`<br>`addl %ebx, %r12d`<br>`.L20:`<br>`leal (%r12,%rbx), %eax`<br>`...`<br>`ret` | `movl %esi, %ebx`<br>`movl %edi, %r15d`<br>`cmpl %edi, %esi`<br>`jle .LBB5_9`<br>`...`<br>`.LBB5_8:`<br>`cmpl %r15d, %ebx`<br>`jle .LBB5_9`<br>`.LBB5_2:`<br>`cmpl %r14d, %ebx`<br>`jge .LBB5_7`<br>`...`<br>`cmpl %ebp, %r12d`<br>`jge .LBB5_8` | `movl %edi, %r12d`<br>`cmpl %esi, %edi`<br>`jl .LBB5_1`<br>`...`<br>`.LBB5_1:`<br>`cmpl %r15d, %r14d`<br>`jge .LBB5_6`<br>`...`<br>`cmpl %ebp, %ebx`<br>`jge .LBB5_7`<br>`.LBB5_7:`<br>`cmpl %r14d, %r12d`<br>`jge .LBB5_8` |

**Вывод:** Все компиляторы упростили цепочки переходов. GCC cформировал компактный цикл и объединил часть проверок, использовав регистры вместо стека. AOCC явно выделил блок end_1 и заголовок цикла, заменив goto прямыми условными переходами. ICX сделал так же как и AOCC. Во всех случаях переход к началу цикла выполнен без лишней цепочки jmp. Различий в оптимизациях между тремя компиляторами в этом блоке практически нет — все справились с задачей одинаково хорошо.

## Итоговый вывод по оптимизациям компиляторов
- ICX - Логичнее всех оптимизировал код. Компилятор глубоко проанализировал потоки данных, устранив лишние обращения к памяти, выполнил максимальную развёртку цикла — в 8 раз, сгруппировал операции записи через movq и встроил функции.
- AOCC - применил, меньше оптимизаций, в отличие от ICX. AOCC хорошо показал себя в удалении избыточных записей, эффективной загрузке 64-битных констант через movabsq, вынесении инвариантов из циклов.
- GCC - приминил, меньшее количество оптимизаций, компилятор практически не меняет структуру исходного кода, оставляя ассемблерный вывод максимально предсказуемым и близким к оригиналу. GCC применяет только стандартные оптимизации, например, свёртка констант, удаление мёртвого кода, что сохраняет логику программы понятной и удобной для отладки.
