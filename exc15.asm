.data
vet:.word
string: .asciiz "-"

.text

la $t2,vet	#carregando o vetor em t2
li $t0, 1 	#indicador para o inicio
li $t1, 11	#indicador para o fim do vetor
li $t3, 0
li $t4, 4	#multiplicador para passar pra posi��o certa

#preenchendo vetor com os valores dos indices
Loop:
	sw $t0, 0($t2)		#coloco o valor de t0 na posi��o t2 do vetor
	addi $t2, $t2, 4	#passando para a proxima posi��o do vetor
	addi $t0, $t0, 1	#andando com o indice
	beq $t0, $t1, Exit_Loop #sair do loop se ja tiver chegado na ultima posi��o
	j Loop			#Sen�o, volta pro come�o

Exit_Loop:
	subi $t2,$t2,40 	#Retorno a posi��o inicial do vetor
	li $v0, 5 		# Faz a leitura de um inteiro e armazena no registrador $v0
	syscall
	move $s3, $v0 		#Passo o valor lido para o reg $s3
	move $t0,$v0 		#salvo o valor inserido em t0 para mostrar a partir dele
	mul $s3, $s3,$t4 	#Multiplico o valor inserido por 4 para avan�ar o vetor a posi��o que a pessoa inseriu
	add $t2,$t2,$s3 	#Adiciono a t2
	subi $t2,$t2,4		#Subtraio uma posi��o,pois o user vai inserir ignorando o zero
	
	
	Mostra:
		lw $t4, 0($t2)	#carrego na t1 o valor na posi��o t2 do vetor
		move $a0, $t4	# move o conteudo do registrador $t0 para o registrador $a0
		li $v0, 1	# informa que ser� impresso um inteiro
		syscall
		la $a0,string	#espa�o
		li $v0, 4	#printar String
		syscall 
		addi $t2,$t2,4 	#vai pra frente
		addi $t0, $t0, 1#Adiciono 1 no indice
		beq $t0,$t1,Exit_Mostra
		j Mostra

	Exit_Mostra:
		li $v0, 10		# informa que o programa ser� encerrado
		syscall			# realiza uma chamada de sistema
	
	
	
