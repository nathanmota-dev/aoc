.data
string1: .asciiz "\nO numero lido e maior que 10!!!"

.text

li $t1, 1 #armazenamento para posterior verificação
li $t2, 10 #verificar se é maior que 10 depois

li $v0, 5 # Faz a leitura de um inteiro e armazena no registrador $v0
syscall
move $s1, $v0 #Passo o valor lido para o reg $s1

li $v0, 5 # Faz a leitura de um inteiro e armazena no registrador $v0
syscall
move $s2, $v0 #Passo o valor lido para o reg $s2

slt $t0, $s1, $s2 #vejo qual dos dois é o menor
beq $t0, $t1, printa_s2 #se s2 for maior que s1, eu printo s2

move $a0,$s1 #preparo para printar s1
li $v0, 1 #printar inteiro
syscall

slt $t0, $s1, $t2 #vejo se s1 é menor que 10
beq $t0, $t1,Exit #se for menor que 10 pulo pra saida

la $a0,string1 #carrego o endereço da string em a0
li $v0,4
syscall

Exit:
	li,$v0,10
	syscall

printa_s2:
	move $a0,$s2 #preparo para printar s1
	li $v0, 1 #printar inteiro
	syscall
	slt $t0, $s2, $t2 #vejo se s1 é menor que 10
	beq $t0, $t1,Exit_S2 #se for menor que 10 pulo pra saida
	
	la $a0,string1 #carrego o endereço da string em a0
	li $v0,4
	syscall
	
	Exit_S2:
	li,$v0,10
	syscall
	