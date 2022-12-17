.data
msg1: .asciiz "Digite um numero de 1 a 15: " #Mensagem para o usuário
msg2: .asciiz " " #Mensagem para o usuário
vet: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 # Vetor de 15 posicoes inicializando com numeors de 1 a 15

.text
la $t2, vet # Endereco do vetor
li $t3, 0 # Contador par iniciado em 0
la $a0, msg1 # Imprimindo String
li $v0, 4
syscall

li $v0, 5 # Le um numero informado pelo usuario
syscall
move $t1, $v0 # Pega o valor de entrada do usuario, e armazena em $t1

imprimeVetor:
beq $t3, $t1, exitLoop # Compara o contador e verifica se ele e igual a $t1, se for sai do loop e finaliza o programa
lw $a0, 0($t2) # Posicao base do vetor
li $v0, 1 # Imprime o inteiro armazenado no vetor
syscall
la $a0, msg2 # Imprimindo String
li $v0, 4
syscall
addi $t2, $t2, 4 # Incrementa de 1 em 1 a posicao do nosso vetor
addi $t3, $t3, 1 # Incrementa de 1 em 1 o nosso contador
j imprimeVetor # Percorre todo o vetor ate o contador $t3 chegar em $t1

exitLoop: # Saindo do programa
li $v0, 10 # Codigo de chamada do sistema para saida
syscall
