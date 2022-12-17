.data
vet:.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
perfume:.asciiz "-"
.text	

la $t2,vet	#alocando em $t2 o vetor
li $t1,0 	#indice inicio
li $t6,15	#indice fim
li $t7,17	#indice fim para impares
li $t4,1 	#valor para comparação
li $t5,7	#valor de parada dos pares

#Preenchendo o vetor com as entradas
Loop:
	li $v0, 5 	# Faz a leitura de um inteiro e armazena no registrador $v0
	syscall
	move $s1, $v0 	#Passo o valor lido para o reg $s1
	sw $s1,0($t2)	#Salva o valor lido na posição $t2 do vetor
	addi $t2,$t2,4	#Passo para a proxima posição do vetor
	addi $t1,$t1, 1 #ando com o indice
	beq $t1,$t6,Exit_Loop
	j Loop

Exit_Loop:
	subi $t2,$t2,44 #Retorno para a posicão 5 do vetor
	lw $t3,0($t2)	#Guardo em t3 o valor da quinta posição
	subi $t2,$t2,16 #Retorno para a posicão inicial do vetor
	li $t1,0	#Reinicio o indice
	li $v0, 5 	# Faz a leitura de um inteiro e armazena no registrador $v0
	syscall
	move $s1, $v0 	#Passo o valor lido para o reg $s1
	slt $s2,$s1,$t3 #s2 recebe 1 se o valor inserido for menor que o quinto valor
	beq $s2,$t4, Att_Par #Se for menor eu atualizo os pares
	
	Att_Impar:
		li $t0, 1# Armazena no registrador $t0 o valor 1 para preencher as posições impares
		sw $t0, 0($t2) # Armazena na posição $t2 do vetor o conteúdo do registrador $t0
		addi $t2, $t2, 8 # Incrementa $t2 com 8 (passa para a próximo posição ímpar do vetor)
		addi $t4, $t4, 2# Incrementa 2 ao índice a ser armazenado na posição correspondente do vetor  
		beq $t4, $t7, ExitImpar # testa se o conteudo dos registradores $t2 e $t1 são iguais
		j Att_Impar # Efetua o salto para o label Att_Impar
		
	ExitImpar:
	subi $t2,$t2,64 	# Retorno $t2 para a primeira posição
	li $t1, 0 		#Reinicio o indice
	jal printa_Vet		# chama a função printa_Vet e armazena o endereço de retorno em $ra
	li $v0, 10		# informa que o programa será encerrado
	syscall			# realiza uma chamada de sistema
	
	Att_Par:
		addi $t2, $t2, 4 	# Incrementa $t2 com 4 (passa para a posição par do vetor)
		li $t0, 2		# Armazena no registrador $t0 o valor 2 para preencher as posições pares
		sw $t0, 0($t2)  	# Armazena na posição $t2 do vetor o conteúdo do registrador $t0
		addi $t2, $t2, 4 	# Incrementa $t2 com 4 (passa para a próximo posição par do vetor)
		addi $t1, $t1, 1	# Incrementa o índice a ser armazenado na posição correspondente do vetor  
		beq $t5, $t1, ExitPar 	# testa se o conteudo dos registradores $t5 e $t1 são iguais
		j Att_Par		# Efetua o salto para o label Att_Par
	
	ExitPar:
	subi $t2,$t2,56 	# Retorno $t2 para a primeira posição, com 80 pois nos pares eu nao vou até a ultima posição
	li $t1, 0 
	jal printa_Vet		# chama a função printa_Vet e armazena o endereço de retorno em $ra
	li $v0, 10		# informa que o programa será encerrado
	syscall		

printa_Vet:
	Loop2:
		lw $t0, 0($t2)		# Armazena no registrador $t0 o conteúdo que está na posição $t2
		move $a0, $t0		# move o conteudo do registrador $t0 para o registrador $a0
		li $v0, 1		# informa que será impresso um inteiro
		syscall			# realiza uma chamada de sistema
		
		la $a0, perfume		# hífen
		li $v0,4 		# PRINTAR UMA STRING
		syscall
		
		addi $t2, $t2, 4 	# Incrementa $t2 com 4 (passa para a próximo posição do vetor)
		addi $t1, $t1, 1	# Incrementa o índice a ser armazenado na posição correspondente do vetor  
		bne $t1,$t6,Loop2	# Volto pro loop se nao tiver chegado no fim do vetor
		
	subi $t2, $t2, 60 	# Retorna $t2 para a primeira posição do vetor
	li $t1, 0 		# Move o valor de 0 para t4
	jr $ra			# finaliza função e retorna para o main		
	