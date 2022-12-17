.data
vet:.word 
print: .asciiz "Informe o numero inteiro : "
mensagem: .asciiz "\n"
perfume: .asciiz " - "
.text

la $t2, vet#Armzaena o registrador $t2 o endereço do vetor vet	
li $t0, 0 # Armazena no registrador $t0 o valor 0 que preencherá o vetor e verificará a opção
li $t1, 21 # Armazena no registrador $t1 o valor 21, última posição do vetor
li $t5,10 #quanto preciso andar no vetor pra preencher campos pares
li $t6,11 #quanto preciso andar no vetor pra preencher campos impares
li $t4, 0 # Armazena no registrador $t4 o valor 0, índice	
	
Zerar:
	sw $t0, 0($t2) # Armazena na posição 0 do vetor o conteúdo do registrador $t0
	addi $t4, $t4, 1# Incrementa o índice a ser armazenado na posição correspondente do vetor  
	addi $t2, $t2, 4 # Incrementa $t2 com 4 (passa para a próxima posição do vetor)
	beq $t4, $t1, ExitZerar # testa se o conteudo dos registradores $t2 e $t1 são iguais
	j Zerar # Efetua o salto para o label Zerar
		
ExitZerar:
	la $a0,print # CARREGA O ENDEREÇO DA STRING
	li $v0,4 # PRINTAR UMA STRING
	syscall
	li $v0, 5 # Faz a leitura de um inteiro e armazena no registrador $v0
	syscall
	move $s1, $v0 #Passo o valor lido para o reg $s1		
	subi $t2,$t2,84 # Retorno $t2 para a primeira posição
	move $t4, $t0 # Move o valor de t0 para t4
	jal printa_Vet	# chama a função printa_Vet e armazena o endereço de retorno em $ra
	bne $t4, $s1, Impares #Se o valor lido for diferente de 0 vou preencher as posições ímpares
		
Pares:
	addi $t2, $t2, 4 # Incrementa $t2 com 4 (passa para a posição par do vetor)
	li $t0, 2# Armazena no registrador $t0 o valor 2 para preencher as posições pares
	sw $t0, 0($t2) # Armazena na posição $t2 do vetor o conteúdo do registrador $t0
	addi $t2, $t2, 4 # Incrementa $t2 com 4 (passa para a próximo posição par do vetor)
	addi $t4, $t4, 1# Incrementa o índice a ser armazenado na posição correspondente do vetor  
	beq $t5, $t4, ExitPar # testa se o conteudo dos registradores $t2 e $t1 são iguais
	j Pares # Efetua o salto para o label Pares
		
Impares:
	li $t0, 1# Armazena no registrador $t0 o valor 1 para preencher as posições impares
	sw $t0, 0($t2) # Armazena na posição $t2 do vetor o conteúdo do registrador $t0
	addi $t2, $t2, 8 # Incrementa $t2 com 8 (passa para a próximo posição ímpar do vetor)
	addi $t4, $t4, 1# Incrementa o índice a ser armazenado na posição correspondente do vetor  
	beq $t6, $t4, ExitImpar # testa se o conteudo dos registradores $t2 e $t1 são iguais
	j Impares # Efetua o salto para o label Impares
ExitPar:
	subi $t2,$t2,80 # Retorno $t2 para a primeira posição, com 80 pois nos pares eu nao vou até a ultima posição
	li $t4, 0 
	jal printa_Vet		# chama a função printa_Vet e armazena o endereço de retorno em $ra
	li $v0, 10		# informa que o programa será encerrado
	syscall			
ExitImpar:
	subi $t2,$t2,88 	# Retorno $t2 para a primeira posição
	li $t4, 0 
	jal printa_Vet		# chama a função printa_Vet e armazena o endereço de retorno em $ra
	li $v0, 10		# informa que o programa será encerrado
	syscall			# realiza uma chamada de sistema
		
printa_Vet:
	Loop:
		lw $t0, 0($t2)		# Armazena no registrador $t0 o conteúdo que está na posição $t2
		move $a0, $t0		# move o conteudo do registrador $t0 para o registrador $a0
		li $v0, 1		# informa que será impresso um inteiro
		syscall			# realiza uma chamada de sistema
		
		la $a0, perfume		# hífen
		li $v0,4 		# PRINTAR UMA STRING
		syscall
		
		addi $t2, $t2, 4 	# Incrementa $t2 com 4 (passa para a próximo posição do vetor)
		addi $t4, $t4, 1	# Incrementa o índice a ser armazenado na posição correspondente do vetor  
		bne $t4,$t1,Loop	# Volto pro loop se nao tiver chegado no fim do vetor
		
	subi $t2, $t2, 84 	# Retorna $t2 para a primeira posição do vetor
	li $t4, 0 		# Move o valor de 0 para t4
	jr $ra			# finaliza função e retorna para o main