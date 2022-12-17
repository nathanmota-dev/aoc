.data
msg1: .asciiz "\nEntre com valores inteiros em seguida a inserção digite (-1 para parar a entrada de dados): \n" #Mensagem para o usuario
msg2: .asciiz "," #Mensagem para o usuario
msg3: .asciiz "Bubble Sort" #Mensagem para o usuario
msg4: .asciiz "#########pass#########" #Mensagem para o usuario
msg5: .asciiz "\n" #Mensagem para o usuario
msg6: .asciiz "\nA lista de números foi ordenada\n" #Mensagem para o usuario
.text 				
		
.globl main
main:
	move $s0,$gp			#Obtem o ponto inicial para salvar o array
	addi $t0,$t0,1			# $t0 = 1
	add $t1,$zero,$zero		# $t1 = 0
	add $t2,$zero,$zero		# $t2 = 0
	add $t3,$zero,$zero		# $t3 = 0
	add $t6,$zero,$zero        	# $t6 = 0
	add $t4,$zero,$zero        	# $t4 = 0
	sub $t7,$zero,1			# Encerra        
	li $v0,4		# Chama para imprimir a String
	la $a0,msg1		# Chama a msg1
	syscall			
	add $s1,$s0,$zero	# Copia o ponteiro para o array  em $s1
entervalues:
	li $v0,5		# Obtem o valor em v0 
	syscall		# 
	beq $v0,$t7,bubblesort # Se $v0 = $t7 vai para o bubblesort
	sb $v0,0($s1)	# Coloca o valor na posição apontada por $s1
	addi $s1,$s1,1		# Mova o ponteiro $s1 para 1
	add $t5,$s1,$zero # $t5 armazena o valor final
	j entervalues
bubblesort:
	add $t4,$s0,$zero	# $t4 = $s0 + 0
	addi $t6,$t6,1		# $t6 = $t6 + 1 
	sub $s1,$s1,$t0		# $s1 = $s1 -  $t0
	beq $s1,$s0,ending  	# Se $s1 = $s0 vai para o ending
	add $s2,$s0,$zero	# $s2 = $s0 + 0
loopinterno:
	lb $t1,0($s2)		# Carrega o primeiro elemento
	lb $t2,1($s2)		# Carrega o segundo elemento
	slt $t3,$t2,$t1		# $t3 = 1 se $t2 < $t1
	beq $t3,$zero,proximo	# Se $t3 = 0, vai pro proximo
	sb $t2,0($s2)		#  Coloca o valor na posição apontada por $s2
	sb $t1,1($s2)		# Coloca o valor na posição apotada por $s2
proximo:
	addi $s2,$s2,1		# $s2 = 1
	bne $s2,$s1,loopinterno # Se $s2 != $s1 vai pro loopinterno
	li $v0,4		# Chama para imprimir a String
	la $a0,msg5		# Chama a msg5
	syscall		
	li $v0,4		# Chama para imprimir a String
	la $a0,msg4		# Chama a msg4
	syscall		
	li $v0,4		# Chama para imprimir a String
	la $a0,msg5		# Chama a msg5
	syscall		
imprime:
	li $v0,1		# Chamada de sistema para printar um inteiro
	lb $a0,0($t4)		# Carrega o primeiro elemento
	syscall
	li $v0,4		# Chama para imprimir a String
	la $a0,msg2		# Chama a msg2
	syscall		
	addi $t4,$t4,1		# $t4 = 1
	bne $t4,$t5,imprime	# Se $t4 != $t5 vai para o imprime
jal bubblesort			
ending:
	li $v0,4		# Chama para imprimir a String
	la $a0,msg6		# Chama a msg6
	syscall		
	li $v0,5		
	syscall	 
