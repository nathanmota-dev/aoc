.data
vet:.word
string: .ascii "-"

.text

la $t2,vet	#carregando o vetor em t2
li $t0, 1 	#indicador para o inicio
li $t1, 16	#indicador para o fim do vetor
li $t3, 0
li $t4, 4	#multiplicador para passar pra posi��o certa
li $t5,15	#fim do vetor, ignorando  o 0

#preenchendo vetor com os valores dos indices
Loop:
	sw $t0, 0($t2)		#coloco o valor de t0 na posi��o t2 do vetor
	addi $t2, $t2, 4	#passando para a proxima posi��o do vetor
	addi $t0, $t0, 1	#andando com o indice
	beq $t0, $t1, Exit_Loop #sair do loop se ja tiver chegado na ultima posi��o
	j Loop			#Sen�o, volta pro come�o

Exit_Loop:
	li $v0, 5 		# Faz a leitura de um inteiro e armazena no registrador $v0
	syscall
	move $s3, $v0 		#Passo o valor lido para o reg $s3
	sub $t5, $t5, $s3	#Subtraio do tamanho total do vetor a posi��o inserida
	mul $s1, $t5,$t4 	#Multiplico o valor inserido por 4 para retroceder o vetor a posi��o que a pessoa inseriu
	sub $t2,$t2,$s1 	#Subtraio do t2
	subi $t2,$t2,4 		#Retorno a posi��o requisitada
	
	Mostra:
		lw $t4, 0($t2)	#carrego na t1 o valor na posi��o t2 do vetor
		move $a0, $t4	# move o conteudo do registrador $t0 para o registrador $a0
		li $v0, 1	# informa que ser� impresso um inteiro
		syscall
		la $a0,string	#espa�o
		li $v0, 4	#printar String
		syscall 
		subi $t2,$t2,4 	#Retorno uma posi��o para tr�s
		subi $s3, $s3, 1#Subtraio 1 do indice, ja que ta indo de frente pra tr�s
		beq $s3,$t3,Exit_Mostra
		j Mostra

	Exit_Mostra:
		li $v0, 10		# informa que o programa ser� encerrado
		syscall			# realiza uma chamada de sistema
	
	
	
