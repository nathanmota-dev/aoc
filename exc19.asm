.data
str1:.asciiz "Digite o primeiro valor:"
str2:.asciiz "\nDigite o segundo valor:"
str3:.asciiz "Escolha:\n1:Soma\n2:Subtracao\n3:Multiplicacao\n4:Sair\n"
.text

li $t1,1 #opcoes do menu
li $t2,2
li $t3,3
li $t4,4

la $a0,str1 	#requisitando o primeiro valor
li $v0,4	#print
syscall
li $v0,5	#Lendo inteiro
syscall
move $s1,$v0	#salvo o valor lido em $s1

la $a0,str2 	#requisitando o segundo valor
li $v0,4	#print
syscall
li $v0,5	#Lendo inteiro
syscall
move $s2,$v0	#salvo o valor lido em $s2

Loop:
	la $a0,str3 	#requisitando o segundo valor
	li $v0,4	#print
	syscall
	li $v0,5	#Lendo inteiro
	syscall
	move $s3,$v0	#salvando a opcao em $s3
	
	beq $s3,$t1,somar
	beq $s3,$t2,subtrair
	beq $s3,$t3,multiplicar
	beq $s3,$t4,sair

	somar:
		jal Soma
		j Loop
	subtrair:
		jal Subtrai
		j Loop
	multiplicar:
		jal Multiplica
		j Loop
	sair:
		li $v0,10
		syscall

Soma:
	add $s4,$s1,$s2
	move $a0,$s4
	li $v0,1
	syscall
	jr $ra
Subtrai:
	sub $s4,$s1,$s2
	move $a0,$s4
	li $v0,1
	syscall	
	jr $ra
Multiplica:
	mul $s4,$s1,$s2
	move $a0,$s4
	li $v0,1
	syscall
	jr $ra
