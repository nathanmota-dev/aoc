.data
	meuArray:
		.alig 2
		.space 40 # aloca 10 espaços do array
		
	lerValor: .asciiz "Insira um valor entre 1 e 10"
		
		
.text
	# INICIALIZAÇÃO DE VARIAVEIS
	move $t0, $zero #indice do array
	li $t3, 1 # insere 1 
	
	
	li $t2, 40 # insere 40 em t2
	
	inicializaArray:
		beq $t0, $t2, saiPercorreArray # enquanto nao for igual ao tamanho do vetor, loop
		sw $t1, meuArray($t0) # adiciona valores de 1 a 10 para o vetor
		addi $t0, $t0, 4 # incrementa o vetor
		addi $t1, $t1, 1 # incrementa os valores de 1 a 10
		j inicializaArray
		
	saiPercorreArray:
		li $v0, 4 #valor para impressao(string) do syscall
		la $a0, lerValor #le o endereço da frase para $a0
		syscall # chama a impressao com o valor de $a0
	
		li $v0, 5 # ler inteiros do syscall
		syscall
		
		mul $t8, $v0, 4 # transforma o valor inserido para posição de memoria(4 em 4)
		
		move $t0, $t8 # carrega a posicao que o usuario inseriu para $t0
		print:
			bge $t0, $t2, saiDoPrint # enquanto o valor inserido de posicao do vetor nao for maior que o final
			li $v0, 1 # valor para impressão(inteiro) do syscall
			lw $a0, meuArray($t0) # carrega o vetor para imprimir
			syscall
			
			addi $t0, $t0, 4 # incrementa o vetor
			j print
			
		saiDoPrint:
			move $t0, $t2 #passa 40 para t0
			sub $t0, $t0, 4 #tira uma posicao para ele nao começar do 11
			print2:
				blt $t0, $zero, saiDoPrint2 # enquando nao for menor q 0, loop
				li $v0, 1 # valor para impressão(inteiro) do syscall
				lw $a0, meuArray($t0) # carrega valor do vetor para $a0 para impressao
				syscall
			
				subi $t0, $t0, 4 #subtrai uma posicao até chegar a 0
				j print2
		
		saiDoPrint2: #fim do programa
