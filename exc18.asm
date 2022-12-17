.data
str1:.asciiz "Digite qual numero deseja calcular o fatorial:\n"
.text

la $a0,str1 	#requisitando o valor a ser calculado
li $v0,4	#print
syscall
li $v0,5	#Lendo inteiro
syscall
move $a0,$v0	#salvo o valor lido em $a0

jal fact
move $a0,$v0
li $v0,1
syscall

li $v0,10 	#finalizando
syscall

fact:
addi $sp, $sp, -8 # ajusta pilha para 2 itens 
sw $ra, 4($sp) # salva endereço de retorno 
sw $a0, 0($sp) # salva o argumento n
slti $t0, $a0, 1 # se (n<1) ? $t0=1; se n>=1 ? $t1=0 
beq $t0, $zero, ELSE # se n>= 1, desvia para ELSE 
addi $v0, $zero, 1 # prepara o “retorna 1” 
addi $sp, $sp, 8 # retira dois itens da pilha 
jr $ra # retorna 
ELSE: 
addi $a0,$a0, -1 # decremento a variavel q recebi
jal fact # volto pra fact
lw $a0, 0($sp) # retorna de jal: restaura o arg. n 
lw $ra, 4($sp) # restaura o endereço de retorno 
addi $sp, $sp, 8 # ajusta pilha para remover 2 itens 
mul $v0, $a0, $v0 # calcula n * fact(n-1) 
jr $ra # retorna para o procedimento que chamou
