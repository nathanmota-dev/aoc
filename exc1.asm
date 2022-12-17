.data
msg1: .asciiz "Escolha sua opcao\n0- Para preencher o vetor intercalado com 0 e 1.\n1- Preencher o vetor com o numero 6.\nDigite sua opcao: " # Mensagem para o usuario
msg2: .asciiz "\nImprimindo o vetor:\n" # Mensagem para o usuario
msg3: .asciiz "\nOpcao digitada 0\n" # Mensagem para o usuario
msg4: .asciiz "\nOpcao digitada 1\n" # Mensagem para o usuario
msg5: .asciiz "\n-------------------------------------------------------------------------------------------\n" # Mensagem para o usuario
msg6: .asciiz " " # Mensagem para o usuario
vet: .word 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 # Vetor de 20 posicoes inicializado em 5

.text

li $t0, 0 # Armazenando o valor 0 em $t0 para aloca no vetor, vai servir como contador tambem para impressao do vetor final
li $t6, 1 # Armazenando o valor 1 em $t6 para alocar no vetor
li $t7, 6 # Armazenando o valor 6 em $t7 para alocar no vetor
li $s1, 20 # Armazena no registrador $t1 o indice 21
la $a3, vet # Endereco do vetor
move $t2,$a3
li $t3, 0 # Contador par inicializado em 0
li $t4, 0 # Contador impar inicializado em 0
li $t5, 10 # Contador inicializado em 9, pois na opcao digita 1 preenhe as 10 ultimas posicoes
la $a0, msg1 # Imprimindo a msg1
li $v0, 4
syscall

li $v0, 5 # Le um numero informado pelo usuario
syscall
move $t1, $v0 # Pega o valor de entrada do usuario, e armazena em $t1

la $a0, msg2 # Imprimindo a msg2
li $v0, 4
syscall

imprimeVetorAntes:
beq $t3, $s1, saiPrimeiraImpressao # Compara o contador e verifica se ele e igual a 19, se for sai do loop e finaliza o programa
la $t2, vet # Endereco do vetor
lw $a0, 0($t2) # Posicao base do vetor
li $v0, 1 # Imprime o inteiro armazenado no vetor
syscall
la $a0, msg6 # Imprimindo a msg6
li $v0, 4
syscall
addi $t2, $t2, 4 # Incrementa de 1 em 1 a posicao no vetor
addi $t3, $t3, 1 # Incrementa de 1 em 1 o nosso contador
j imprimeVetorAntes # Percorre todo o vetor ate o contador $t3 chegar em 19

saiPrimeiraImpressao: # Saindo do programa
la $a0, msg5 # Imprimindo a msg5
li $v0, 4
syscall

beqz  $t1, igualZero # Verifica se o numero de entrada foi a igual a zero

beq $t1, 1, igualUm # Verifica se o numero lido pelo usuario foi igual a 1

igualUm:
la $a0, msg4 # Imprimindo a msg4
li $v0, 4
syscall
j preencherDezUltiPosVetor # Se for igual a 1 pula para o loop preencher as ultimas dez posicoes

igualZero: # Se for igual a 0 entra nessa condicao onde iremos alterar os valores do vetor para 0 e 1 intercaladamente
la $a0, msg3 # Imprimindo a msg3
li $v0, 4
syscall
j par # Se for igual a 0 pula para o loop posicao par

li $t3, 0 # Contador par inicializado em 0

par:
sw $t0, 0($t2) # Definindo os valores do vetores em 0, em todas as posicoes
beq $t3, 76 impar_mao
addi $t2, $t2, 4
addi $t3, $t3, 1
j par

impar_mao:
sw $t6, 0($t2)
sw $t6, 8($t2)
sw $t6, 16($t2)
sw $t6, 24($t2)
sw $t6, 32($t2)
sw $t6, 40($t2)
sw $t6, 48($t2)
sw $t6, 56($t2)
sw $t6, 64($t2)
sw $t6, 72($t2)
j imprimeVetor

la $a0, msg2 # Imprimindo a msg2
li $v0, 4
syscall

exit: # Saindo do programa
li $v0, 10 # Codigo de chamada do sistema para saida
syscall

preencherDezUltiPosVetor: # Loop que vai preencher minhas 10 ultimas posicoes do vetor
sw $t7, 76($t2) # Vetor inicializado na posicao 10, onde iremos alterar os valores ate o final do vetor
beq $t5, 19, imprimeVetor # Verifica se o contador $t5 e menor que 19, tamanho total do vetor, caso seja igual a 19, tamanho max entra no outro loop de impressao do vetor
addi $t2, $t2, 4 # Incrementa de 1 em 1 apos do nosso vetor
addi $t5, $t5, 1 # Incrementa de 1 em 1 o nosso contador
j preencherDezUltiPosVetor # Vai entra no laco ate meu contador $t5 for igual a 19

la $a0, msg2 # Imprimindo a msg2
li $v0, 4
syscall

imprimeVetor:
lw $a0, 0($t2) # Posicao base do vetor
li $v0, 1 # Imprime o inteiro armazenado no vetor
syscall
la $a0, msg6 # Imprimingo a msg6
li $v0, 4
syscall
beq $t0, 19, exitLoop # Compara o contador e verifica se ele e igual a 19, se for sai do loop e finaliza o programa
addi $t2, $t2, 4 # Incrementa de 1 em 1 a posicao do nosso vetor
addi $t0, $t0, 1 # Incrementa de 1 em 1 o nosso contador
j imprimeVetor # Percorre todo o vetor ate o contador $t3 chegar em 19

exitLoop: # Saindo do programa
li $v0, 10 # Codigo de chamada do sitema para saida
syscall
