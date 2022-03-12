;------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;------------------------------------------------------------------------------

CR              EQU     0Ah
RND_MASK        EQU    8016h    ; 1000 0000 0001 0110b
LSB_MASK    	EQU    0001h    ; Mascara para testar o bit menos significativo do Random_Var

FANTASMA  		EQU   	'@'
PONTO   		EQU 	'.'
PAREDE			EQU 	'#'
PACMAN_DIREITA 	EQU 	'<'
PACMAN_ESQUERDA	EQU 	'>'
PACMAN_CIMA  	EQU 	'v'
PACMAN_BAIXO  	EQU 	'^'
VAZIO  			EQU  	' '
FIM_TEXTO1      EQU     'Y'
FIM_HALT		EQU  	'!'
IO_READ         EQU     FFFFh
IO_WRITE        EQU     FFFEh
IO_STATUS       EQU     FFFDh
INITIAL_SP      EQU     FDFFh
CURSOR		    EQU     FFFCh
CURSOR_INIT		EQU		FFFFh
ROW_POSITION	EQU		0d
COL_POSITION	EQU		0d
ROW_SHIFT		EQU		8d
COLUMN_SHIFT	EQU		8d
TEMPO  			EQU 	FFF6h
ATIVA_TEMPO  	EQU  	FFF7h
Ghost1Right   	EQU 	0d
Ghost1Left  	EQU  	1d
Ghost1Up   		EQU  	2d
Ghost1Down  	EQU  	3d

FIM_TEXTO_VIDA	EQU  	'F'
FIM_TEXTO_VENCE	EQU  	'1'
FALSE   	 	EQU 	0d
TRUE  			EQU  	1d

;------------------------------------------------------------------------------
; ZONA II: definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;------------------------------------------------------------------------------

                ORIG    8000h
Random_Var      WORD    A5A5h

RowIndex		WORD	3d
ColumnIndex		WORD	20d

PacManRow  		WORD  	10d
PacManColumn  	WORD	37d

Ghost1Row   	WORD   	16d
Ghost1Column  	WORD	27d

Ghost2Row   	WORD   	8d
Ghost2Column  	WORD	27d

Ghost3Row   	WORD   	8d
Ghost3Column  	WORD	46d

Ghost4Row   	WORD   	16d
Ghost4Column  	WORD	46d

Um  			WORD	1d
Direcao  		WORD  	0d
DirecaoGhost1  	WORD  	1d
DirecaoGhost2  	WORD  	2d
DirecaoGhost3  	WORD  	3d
DirecaoGhost4  	WORD  	0d

ConfColisao  	WORD  	262d
ConfColisaoG1  	WORD  	462d
ConfColisaoG2  	WORD  	182d
ConfColisaoG3  	WORD  	201d
ConfColisaoG4  	WORD  	481d

ContaPonto  	WORD  	0d
QuantPontos		WORD  	278d
VerificaVenceu  WORD  	FALSE	

strVidas  		STR 	'HEALTH <3 / <3 / <3', FIM_TEXTO_VIDA
NumVidas  		WORD  	3d
vidaColumn  	WORD  	20d
vidaRow  		WORD  	1d
strVidaIndex  	WORD  	0d


str1  			STR 	'##################################', FIM_TEXTO1
str2 			STR 	'#..................#.............#', FIM_TEXTO1
str3  			STR 	'#...############...#...###...#####', FIM_TEXTO1
str4  			STR 	'#...############...#...###...#####', FIM_TEXTO1
str5  			STR 	'#...############.......###.......#', FIM_TEXTO1
str6  			STR 	'#................................#', FIM_TEXTO1
str7  			STR 	'#...######...##########..........#', FIM_TEXTO1
str8  			STR 	'#.....#..........................#', FIM_TEXTO1
str9  			STR 	'###...######################...###', FIM_TEXTO1
str10			STR  	'###...######################...###', FIM_TEXTO1
str11  			STR 	'###...######################...###', FIM_TEXTO1
str12  			STR 	'#.....######################.....#', FIM_TEXTO1
str13  			STR 	'#................................#', FIM_TEXTO1
str14  			STR 	'#...#.........######.............#', FIM_TEXTO1
str15  			STR 	'#...#....################...##...#', FIM_TEXTO1
str16  			STR 	'#...#.......................##...#', FIM_TEXTO1
str17  			STR 	'##################################', FIM_HALT

strIndex		WORD	0d

strVence 		STR  	'YOU WON', FIM_TEXTO_VENCE
strVenceIndex 	WORD  	0d
venceRow 		WORD  	10d
venceColumn  	WORD  	5d

strPerde 		STR  	'GAMER OVER', FIM_TEXTO_VENCE
strPerdeIndex 	WORD  	0d
perdeRow 		WORD  	10d
perdeColumn  	WORD  	5d


;------------------------------------------------------------------------------
; ZONA III: definicao de tabela de interrupções
;------------------------------------------------------------------------------
                ORIG    FE00h
INT0            WORD    Direita
INT1  			WORD  	Esquerda
INT2  			WORD  	Cima
INT3  			WORD  	Baixo
				ORIG    FE0Fh
INT15  			WORD    TIMER

                ORIG    0000h
                JMP     Main


;------------------------------------------------------------------------------
; ZONA IV: FUNÇÕES RELACIONADAS A CONTAGEM DE PONTOS
;			 E IMPRESSÃO DO PACMAN/FANTASMA
;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; Função que imprime YOU WON na tela
;------------------------------------------------------------------------------

Venceu:  		PUSH  	R1
				PUSH  	R2

				MOV  	R1, strVence
				MOV  	M[ strVenceIndex ], R1

				MOV  	R2, 1d
				MOV  	M[ venceColumn ], R2

Func1:			MOV  	R1, M[ venceRow ]
				MOV  	R2, M[ venceColumn ]
				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1

				MOV  	R1, M[ strVenceIndex ]
				MOV  	R1, M[ R1 ]

				CMP  	R1, FIM_TEXTO_VENCE
				JMP.Z  	EndV

				MOV  	M[ IO_WRITE ], R1

				INC  	M[ venceColumn ]
				INC  	M[ strVenceIndex ]

				JMP  	Func1

EndV:			POP  	R2
				POP  	R1
				RET

;---------------------------------------------
; Função que imprime GAME OVER na tela 
;---------------------------------------------

Perdeu:  		PUSH  	R1
				PUSH  	R2

				MOV  	R1, strPerde
				MOV  	M[ strPerdeIndex ], R1

				MOV  	R2, 1d
				MOV  	M[ perdeColumn ], R2

Func3:			MOV  	R1, M[ perdeRow ]
				MOV  	R2, M[ perdeColumn ]
				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1

				MOV  	R1, M[ strPerdeIndex ]
				MOV  	R1, M[ R1 ]

				CMP  	R1, FIM_TEXTO_VENCE
				JMP.Z  	EndP

				MOV  	M[ IO_WRITE ], R1

				INC  	M[ perdeColumn ]
				INC  	M[ strPerdeIndex ]

				JMP  	Func3

EndP:			POP  	R2
				POP  	R1
				RET

;----------------------------------------------------------
; Função que imprime as vidas na tela no início da partida
;----------------------------------------------------------

imprimeVidas:  	PUSH  	R1
				PUSH  	R2

				MOV  	R1, strVidas
				MOV  	M[ strVidaIndex ], R1

				MOV  	R2, 20d
				MOV  	M[ vidaColumn ], R2

Func2:			MOV  	R1, M[ vidaRow ]
				MOV  	R2, M[ vidaColumn ]
				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1

				MOV  	R1, M[ strVidaIndex ]
				MOV  	R1, M[ R1 ]

				CMP  	R1, FIM_TEXTO_VIDA
				JMP.Z  	EndIV

				MOV  	M[ IO_WRITE ], R1

				INC  	M[ vidaColumn ]
				INC  	M[ strVidaIndex ]

				JMP  	Func2

EndIV:			POP  	R2
				POP  	R1
				RET

;------------------------------------------------------
; Função que imprime fantasmas na sua posição inicial 
;------------------------------------------------------

imprimeFantasma:PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV R1, M[ Ghost1Row ]
				MOV R2, M[ Ghost1Column ]

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	R3, FANTASMA
				MOV  	M[ IO_WRITE ], R3

				MOV R1, M[ Ghost2Row ]
				MOV R2, M[ Ghost2Column ]

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	R3, FANTASMA
				MOV  	M[ IO_WRITE ], R3

				MOV R1, M[ Ghost3Row ]
				MOV R2, M[ Ghost3Column ]

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	R3, FANTASMA				
				MOV  	M[ IO_WRITE ], R3

				MOV R1, M[ Ghost4Row ]
				MOV R2, M[ Ghost4Column ]

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	R3, FANTASMA				
				MOV  	M[ IO_WRITE ], R3

				POP  	R3
				POP  	R2
				POP  	R1
				RET

;------------------------------------------------------
; Função que imprime o pacman na sua posição inicial 
;------------------------------------------------------

imprimePacMan: 	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV R1, M[ PacManRow ]
				MOV R2, M[ PacManColumn ]

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	R3, PACMAN_DIREITA
				MOV  	M[ IO_WRITE ], R3

				POP  	R3
				POP  	R2
				POP  	R1
				RET

;--------------------------------------------------------
; Função que faz a contagem de pontos que o jogador tem
;--------------------------------------------------------

Contagem:   	PUSH   	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				MOV  	R1, M[ ContaPonto ]
				MOV  	R2, 100d
				DIV  	R1, R2
				MOV   	R3, 1d ; linha
				MOV  	R4, 51d; coluna

				ADD   	R1, 48d
				SHL  	R3, 8
				OR  	R3, R4
				MOV  	M[ CURSOR ], R3
				MOV     M[ IO_WRITE ], R1; imprime na tela

				MOV  	R1, R2
				MOV  	R2, 10d
				DIV  	R1, R2

				ADD   	R1, 48d
				MOV   	R3, 1d ; linha
				MOV  	R4, 52d; coluna
				SHL  	R3, 8
				OR  	R3, R4
				MOV  	M[ CURSOR ], R3
				MOV     M[ IO_WRITE ], R1

				MOV  	R1, R2
				MOV   	R3, 1d ; linha
				MOV  	R4, 53d; coluna

				ADD   	R1, 48d
				SHL  	R3, 8
				OR  	R3, R4
				MOV  	M[ CURSOR ], R3
				MOV     M[ IO_WRITE ], R1
				
				POP  	R4
				POP  	R3
				POP 	R2
				POP  	R1
				RET

;---------------------------------------------------------
; ZONA V: FUNÇÕES RELACIONADAS 
;   		A MOVIMENTAÇÃO E COLISÃO
;---------------------------------------------------------


;--------------------------------------------------
; Função de colisão pertencente ao pacman
;--------------------------------------------------

Colisao:  		PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV  	R1, str1
				MOV   	R2, M[ ConfColisao ]
 				MOV  	R3, M[ Direcao ]

 				CMP  	R3, 1d ; direita
   				JMP.NZ  colisao1   	
   				INC  	R2

   				
colisao1:  		CMP  	R3, 2d
				JMP.NZ  colisao2
   				DEC     R2

colisao2:  		CMP  	R3, 3d
				JMP.NZ  colisao3
   				SUB  	R2, 35d

colisao3: 		CMP  	R3, 4d
				JMP.NZ  colisao4
   				ADD  	R2, 35d


colisao4:  		ADD  	R1, R2
				MOV  	R3, M[ R1 ]
				CMP  	R3, PONTO
				JMP.NZ  CompParede
				INC  	M[ ContaPonto ]
				DEC   	M[ QuantPontos ]
				MOV   	R2, ' '
				MOV     M[ R1 ], R2
				CALL    Contagem
				JMP  	NaoAchou 
				
CompParede:		CMP  	R3, PAREDE
				JMP.NZ  NaoAchou
				MOV   	M[ Direcao ], R0 ; Quando ele acha a parede, a direção vira 0, ou seja, parado.


NaoAchou:   	POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------
; As funções abaixo movimentam fantasmas
;-------------------------------------------

;---------------------------------------------------------
; Função para aleatorizar a movimentação dos fantasmas
;---------------------------------------------------------

; Random: Rotina que gera um valor aleatório - guardado em M[Random_Var]
; Entradas: M[Random_Var]
; Saidas:   M[Random_Var]

Random:	        PUSH    R1

		        MOV     R1, LSB_MASK
		        AND     R1, M[Random_Var] ; R1 = bit menos significativo de M[Random_Var]
		        BR.Z    Rnd_Rotate
		        MOV     R1, RND_MASK
		        XOR     M[Random_Var], R1

Rnd_Rotate:     ROR     M[Random_Var], 1

	            POP     R1
	            RET

;-------------------------------------------------------------------------------
; Função para chamar a função de movimentação correta para primeiro fantasmas
;-------------------------------------------------------------------------------

ComparaDirecao1:PUSH    R1
				PUSH	R2
				PUSH	R3

				MOV  	R1, M[ DirecaoGhost1 ]
				MOV  	R3, Ghost1Right
				CMP  	R1, R3
				CALL.Z  MovDireitaG1
				JMP.Z   EndCompara1

				MOV  	R3, Ghost1Left
				CMP  	R1, R3
				CALL.Z  MovEsquerdaG1
				JMP.Z   EndCompara1


				MOV  	R3, Ghost1Up
				CMP  	R1, R3
				CALL.Z  MovCimaG1
				JMP.Z   EndCompara1


				MOV  	R3, Ghost1Down
				CMP  	R1, R3
				CALL.Z  MovBaixoG1

EndCompara1:	POP  	R3
				POP   	R2
				POP  	R1
				RET
;------------------------------------------------------
; Função de colisão relacionada ao primeiro fantasma
;------------------------------------------------------

PColisaoG:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV  	R1, str1
				MOV   	R2, M[ ConfColisaoG1 ]
 				MOV  	R3, M[ DirecaoGhost1 ]

 				CMP  	R3, 0d ; direita
   				JMP.NZ  Pcolisao1G   	
   				INC  	R2
   				JMP  	Pcolisao4G

   				
Pcolisao1G:  	CMP  	R3, 1d ; esquerda
				JMP.NZ  Pcolisao2G
   				DEC     R2
   				JMP  	Pcolisao4G


Pcolisao2G:  	CMP  	R3, 3d ; cima
				JMP.NZ  Pcolisao3G
   				ADD  	R2, 35d
   				JMP  	Pcolisao4G


Pcolisao3G: 	CMP  	R3, 2d ; baixo
				JMP.NZ  Pcolisao4G
   				SUB  	R2, 35d


Pcolisao4G:  	ADD  	R1, R2
				MOV  	R3, M[ R1 ]
				;MOV     M[ R1 ], R2
				;JMP  	NaoAchouG 
   				;JMP  	CompParede

				
PCompParedeG:	CMP  	R3, PAREDE
				JMP.NZ  PNaoAchouG
				MOV  	R2, 5d
				MOV   	M[ DirecaoGhost1 ], R2


PNaoAchouG:   	POP  	R3
				POP  	R2
				POP  	R1
				RET
;-----------------------------------------------------------
; Função chamada para tirar uma vida da string que printa
;		 a vida na tela
;-----------------------------------------------------------

ApagaVida:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				DEC  	M[ vidaColumn ]
				MOV  	R1, VAZIO
				MOV  	R2, M[ vidaRow ]
				MOV  	R3, M[ vidaColumn ]

				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

				DEC  	M[ vidaColumn ]

				MOV  	R2, M[ vidaRow ]
				MOV  	R3, M[ vidaColumn ]

				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

				MOV  	R4, 3d  	
				SUB  	M[ vidaColumn ], R4

				POP  	R4				
				POP  	R3
				POP  	R2
				POP  	R1
				RET

;----------------------------------------------------------------
; Função chamada quando o primeiro fantasma e um pacman colidem
;----------------------------------------------------------------

PComeu_pacman:  PUSH  	R1
				PUSH 	R2
				PUSH  	R3
				PUSH  	R4

				MOV  	R1, M[ PacManRow ]
				MOV  	R2, M[ PacManColumn ]
				MOV  	R3, M[ Ghost1Row ]
				MOV  	R4, M[ Ghost1Column ]

				CMP  	R1, R3
				JMP.NZ  PEndComeu1
				CMP  	R2, R4
				JMP.NZ  PEndComeu1

PReinicia:		MOV  	R4, PACMAN_DIREITA
				MOV  	R1, 10d
				MOV  	R2, 37d
				MOV  	R3, 262d 
				MOV  	M[ PacManRow ], R1
				MOV  	M[ PacManColumn ], R2

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	M[ IO_WRITE ], R4

				MOV  	M[ ConfColisao ], R3


				DEC  	M[ NumVidas ]
				CALL  	ApagaVida

PEndComeu1:		POP  	R4
				POP  	R3
				POP  	R2
				POP  	R1
				RET

;-----------------------------------------------------------
; Função que movimenta o primeiro fantasma para a esquerda
;-----------------------------------------------------------

MovEsquerdaG1:	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	PComeu_pacman
				CALL    PColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost1 ], R4
				JMP.Z  	RandomEsq1
				DEC  	M[ ConfColisaoG1 ]


				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG1 ]
				ADD  	R4, R2

				INC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4


				;DEC     M[ ConfColisaoG1 ]
				DEC  	M[ Ghost1Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]

				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndEsqG1

RandomEsq1:  	CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost1 ], R1


EndEsqG1:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET
;----------------------------------------------------------
; Função que movimenta o primeiro fantasma para a direita
;----------------------------------------------------------

MovDireitaG1:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	PComeu_pacman
				CALL    PColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost1 ], R4
				JMP.Z  	RandomDir1
				INC  	M[ ConfColisaoG1 ]

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG1 ]
				ADD  	R4, R2

				DEC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4


				;INC   	M[ ConfColisaoG1 ]
				INC  	M[ Ghost1Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndDirG1

RandomDir1:  	CALL 	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost1 ], R1

EndDirG1:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET
;------------------------------------------------------
; Função que movimenta o primeiro fantasma para cima
;------------------------------------------------------

MovCimaG1:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4
				
				CALL  	PComeu_pacman
				CALL  	PColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost1 ], R4
				JMP.Z  	RandomCima1

				MOV     R1, 35d
				SUB     M[ ConfColisaoG1 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG1 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				ADD  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				DEC  	M[ Ghost1Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndCimaG1


RandomCima1:    CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[DirecaoGhost1], R1

EndCimaG1:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET
;------------------------------------------------------
; Função que movimenta o primeiro fantasma para baixo
;------------------------------------------------------

MovBaixoG1:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	PComeu_pacman
				CALL  	PColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost1 ], R4
				JMP.Z  	RandomBaixo1

				MOV     R1, 35d
				ADD     M[ ConfColisaoG1 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG1 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				SUB  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				;MOV     R1, 35d
				;ADD     M[ ConfColisaoG1 ], R1
				INC  	M[ Ghost1Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost1Row ]
				MOV  	R3, M[ Ghost1Column ]
				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndBaixoG1


RandomBaixo1:   CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost1 ], R1

EndBaixoG1:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;---------------------------------------------------------------------
; A partir daqui, as funções possuem o mesmo padrão e mesma estrutura, 
;	e servem para gerenciar a movimentação dos outros 3 fantasmas
;---------------------------------------------------------------------


ComparaDirecao2:PUSH    R1
				PUSH	R2
				PUSH	R3

				MOV  	R1, M[ DirecaoGhost2 ]
				MOV  	R3, Ghost1Right
				CMP  	R1, R3
				CALL.Z  MovDireitaG2
				JMP.Z   EndCompara2

				MOV  	R3, Ghost1Left
				CMP  	R1, R3
				CALL.Z  MovEsquerdaG2
				JMP.Z   EndCompara2


				MOV  	R3, Ghost1Up
				CMP  	R1, R3
				CALL.Z  MovCimaG2
				JMP.Z   EndCompara2


				MOV  	R3, Ghost1Down
				CMP  	R1, R3
				CALL.Z  MovBaixoG2

EndCompara2:	POP  	R3
				POP   	R2
				POP  	R1
				RET
;-------------------------------------------------
; 					Função
;-------------------------------------------------

SColisaoG:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV  	R1, str1
				MOV   	R2, M[ ConfColisaoG2 ]
 				MOV  	R3, M[ DirecaoGhost2 ]

 				CMP  	R3, 0d ; direita
   				JMP.NZ  Scolisao1G
   				INC  	R2
   				JMP  	Scolisao4G


Scolisao1G:  	CMP  	R3, 1d ; esquerda
				JMP.NZ  Scolisao2G
   				DEC     R2
   				JMP  	Scolisao4G


Scolisao2G:  	CMP  	R3, 3d ; cima
				JMP.NZ  Scolisao3G
   				ADD  	R2, 35d
   				JMP  	Scolisao4G


Scolisao3G: 	CMP  	R3, 2d ; baixo
				JMP.NZ  Scolisao4G
   				SUB  	R2, 35d


Scolisao4G:  	ADD  	R1, R2
				MOV  	R3, M[ R1 ]
				;MOV     M[ R1 ], R2
				;JMP  	NaoAchouG
   				;JMP  	CompParede


SCompParedeG:	CMP  	R3, PAREDE
				JMP.NZ  SNaoAchouG
				MOV  	R2, 5d
				MOV   	M[ DirecaoGhost2 ], R2


SNaoAchouG:   	POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------

SComeu_pacman:  PUSH  	R1
				PUSH 	R2
				PUSH  	R3
				PUSH  	R4

				MOV  	R1, M[ PacManRow ]
				MOV  	R2, M[ PacManColumn ]
				MOV  	R3, M[ Ghost2Row ]
				MOV  	R4, M[ Ghost2Column ]

				CMP  	R1, R3
				JMP.NZ  SEndComeu1
				CMP  	R2, R4
				JMP.NZ  SEndComeu1

SReinicia:		MOV  	R4, PACMAN_DIREITA
				MOV  	R1, 10d
				MOV  	R2, 37d
				MOV  	R3, 262d
				MOV  	M[ PacManRow ], R1
				MOV  	M[ PacManColumn ], R2

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	M[ IO_WRITE ], R4

				MOV  	M[ ConfColisao ], R3


				DEC  	M[ NumVidas ]
				CALL  	ApagaVida

SEndComeu1:		POP  	R4
				POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovEsquerdaG2:	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	SComeu_pacman
				CALL    SColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost2 ], R4
				JMP.Z  	RandomEsq2

				DEC  	M[ ConfColisaoG2 ]


				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG2 ]
				ADD  	R4, R2

				INC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4


				;DEC     M[ ConfColisaoG2 ]
				DEC  	M[ Ghost2Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]

				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndEsqG2

RandomEsq2:  	CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost2 ], R1


EndEsqG2:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovDireitaG2:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	SComeu_pacman
				CALL    SColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost2 ], R4
				JMP.Z  	RandomDir2

				INC  	M[ ConfColisaoG2 ]

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG2 ]
				ADD  	R4, R2

				DEC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				;INC   	M[ ConfColisaoG2 ]
				INC  	M[ Ghost2Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndDirG2

RandomDir2:  	CALL 	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost2 ], R1

EndDirG2:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovCimaG2:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	SComeu_pacman
				CALL  	SColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost2 ], R4
				JMP.Z  	RandomCima2

				MOV     R1, 35d
				SUB     M[ ConfColisaoG2 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG2 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				ADD  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				DEC  	M[ Ghost2Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndCimaG2


RandomCima2:    CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[DirecaoGhost2], R1

EndCimaG2:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------

MovBaixoG2:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	SComeu_pacman
				CALL  	SColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost2 ], R4
				JMP.Z  	RandomBaixo2

				MOV     R1, 35d
				ADD     M[ ConfColisaoG2 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG2 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				SUB  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				INC  	M[ Ghost2Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost2Row ]
				MOV  	R3, M[ Ghost2Column ]
				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndBaixoG2


RandomBaixo2:   CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost2 ], R1

EndBaixoG2:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


ComparaDirecao3:PUSH    R1
				PUSH	R2
				PUSH	R3

				MOV  	R1, M[ DirecaoGhost3 ]
				MOV  	R3, Ghost1Right
				CMP  	R1, R3
				CALL.Z  MovDireitaG3
				JMP.Z   EndCompara3

				MOV  	R3, Ghost1Left
				CMP  	R1, R3
				CALL.Z  MovEsquerdaG3
				JMP.Z   EndCompara3


				MOV  	R3, Ghost1Up
				CMP  	R1, R3
				CALL.Z  MovCimaG3
				JMP.Z   EndCompara3


				MOV  	R3, Ghost1Down
				CMP  	R1, R3
				CALL.Z  MovBaixoG3

EndCompara3:	POP  	R3
				POP   	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------

TColisaoG:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV  	R1, str1
				MOV   	R2, M[ ConfColisaoG3 ]
 				MOV  	R3, M[ DirecaoGhost3 ]

 				CMP  	R3, 0d ; direita
   				JMP.NZ  Tcolisao1G
   				INC  	R2
   				JMP  	Tcolisao4G


Tcolisao1G:  	CMP  	R3, 1d ; esquerda
				JMP.NZ  Tcolisao2G
   				DEC     R2
   				JMP  	Tcolisao4G


Tcolisao2G:  	CMP  	R3, 3d ; cima
				JMP.NZ  Tcolisao3G
   				ADD  	R2, 35d
   				JMP  	Tcolisao4G


Tcolisao3G: 	CMP  	R3, 2d ; baixo
				JMP.NZ  Tcolisao4G
   				SUB  	R2, 35d


Tcolisao4G:  	ADD  	R1, R2
				MOV  	R3, M[ R1 ]
				;MOV     M[ R1 ], R2
				;JMP  	NaoAchouG
   				;JMP  	CompParede


TCompParedeG:	CMP  	R3, PAREDE
				JMP.NZ  TNaoAchouG
				MOV  	R2, 5d
				MOV   	M[ DirecaoGhost3 ], R2


TNaoAchouG:   	POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


TComeu_pacman:  PUSH  	R1
				PUSH 	R2
				PUSH  	R3
				PUSH  	R4

				MOV  	R1, M[ PacManRow ]
				MOV  	R2, M[ PacManColumn ]
				MOV  	R3, M[ Ghost3Row ]
				MOV  	R4, M[ Ghost3Column ]

				CMP  	R1, R3
				JMP.NZ  TEndComeu1
				CMP  	R2, R4
				JMP.NZ  TEndComeu1

TReinicia:		MOV  	R4, PACMAN_DIREITA
				MOV  	R1, 10d
				MOV  	R2, 37d
				MOV  	R3, 262d
				MOV  	M[ PacManRow ], R1
				MOV  	M[ PacManColumn ], R2

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	M[ IO_WRITE ], R4

				MOV  	M[ ConfColisao ], R3


				DEC  	M[ NumVidas ]
				CALL  	ApagaVida

TEndComeu1:		POP  	R4
				POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------

MovEsquerdaG3:	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	TComeu_pacman
				CALL    TColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost3 ], R4
				JMP.Z  	RandomEsq3

				DEC  	M[ ConfColisaoG3 ]


				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG3 ]
				ADD  	R4, R2

				INC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4


				;DEC     M[ ConfColisaoG3 ]
				DEC  	M[ Ghost3Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]

				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndEsqG3

RandomEsq3:  	CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost3 ], R1


EndEsqG3:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET
;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovDireitaG3:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	TComeu_pacman
				CALL    TColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost3 ], R4
				JMP.Z  	RandomDir3

				INC  	M[ ConfColisaoG3 ]

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG3 ]
				ADD  	R4, R2

				DEC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				INC  	M[ Ghost3Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndDirG3

RandomDir3:  	CALL 	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost3 ], R1

EndDirG3:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovCimaG3:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	TComeu_pacman
				CALL  	TColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost3 ], R4
				JMP.Z  	RandomCima3

				MOV     R1, 35d
				SUB     M[ ConfColisaoG3 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG3 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				ADD  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				DEC  	M[ Ghost3Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndCimaG3


RandomCima3:    CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[DirecaoGhost3], R1

EndCimaG3:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovBaixoG3:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	TComeu_pacman
				CALL  	TColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost3 ], R4
				JMP.Z  	RandomBaixo3

				MOV     R1, 35d
				ADD     M[ ConfColisaoG3 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG3 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				SUB  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				INC  	M[ Ghost3Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost3Row ]
				MOV  	R3, M[ Ghost3Column ]
				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndBaixoG3


RandomBaixo3:   CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost3 ], R1

EndBaixoG3:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


ComparaDirecao4:PUSH    R1
				PUSH	R2
				PUSH	R3

				MOV  	R1, M[ DirecaoGhost4 ]
				MOV  	R3, Ghost1Right
				CMP  	R1, R3
				CALL.Z  MovDireitaG4
				JMP.Z   EndCompara4

				MOV  	R3, Ghost1Left
				CMP  	R1, R3
				CALL.Z  MovEsquerdaG4
				JMP.Z   EndCompara4


				MOV  	R3, Ghost1Up
				CMP  	R1, R3
				CALL.Z  MovCimaG4
				JMP.Z   EndCompara4


				MOV  	R3, Ghost1Down
				CMP  	R1, R3
				CALL.Z  MovBaixoG4

EndCompara4:	POP  	R3
				POP   	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------

QColisaoG:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				MOV  	R1, str1
				MOV   	R2, M[ ConfColisaoG4 ]
 				MOV  	R3, M[ DirecaoGhost4 ]

 				CMP  	R3, 0d ; direita
   				JMP.NZ  Qcolisao1G
   				INC  	R2
   				JMP  	Qcolisao4G


Qcolisao1G:  	CMP  	R3, 1d ; esquerda
				JMP.NZ  Qcolisao2G
   				DEC     R2
   				JMP  	Qcolisao4G


Qcolisao2G:  	CMP  	R3, 3d ; cima
				JMP.NZ  Qcolisao3G
   				ADD  	R2, 35d
   				JMP  	Qcolisao4G


Qcolisao3G: 	CMP  	R3, 2d ; baixo
				JMP.NZ  Qcolisao4G
   				SUB  	R2, 35d


Qcolisao4G:  	ADD  	R1, R2
				MOV  	R3, M[ R1 ]
				;MOV     M[ R1 ], R2
				;JMP  	NaoAchouG
   				;JMP  	CompParede


QCompParedeG:	CMP  	R3, PAREDE
				JMP.NZ  QNaoAchouG
				MOV  	R2, 5d
				MOV   	M[ DirecaoGhost4 ], R2


QNaoAchouG:   	POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


QComeu_pacman:  PUSH  	R1
				PUSH 	R2
				PUSH  	R3
				PUSH  	R4

				MOV  	R1, M[ PacManRow ]
				MOV  	R2, M[ PacManColumn ]
				MOV  	R3, M[ Ghost4Row ]
				MOV  	R4, M[ Ghost4Column ]

				CMP  	R1, R3
				JMP.NZ  QEndComeu1
				CMP  	R2, R4
				JMP.NZ  QEndComeu1

QReinicia:		MOV  	R4, PACMAN_DIREITA
				MOV  	R1, 10d
				MOV  	R2, 37d
				MOV  	R3, 262d
				MOV  	M[ PacManRow ], R1
				MOV  	M[ PacManColumn ], R2

				SHL  	R1, 8
				OR  	R1, R2
				MOV  	M[ CURSOR ], R1
				MOV  	M[ IO_WRITE ], R4

				MOV  	M[ ConfColisao ], R3


				DEC  	M[ NumVidas ]
				CALL  	ApagaVida

QEndComeu1:		POP  	R4
				POP  	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------

MovEsquerdaG4:	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	QComeu_pacman
				CALL    QColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost4 ], R4
				JMP.Z  	RandomEsq4

				DEC  	M[ ConfColisaoG4 ]


				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG4 ]
				ADD  	R4, R2

				INC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4


				;DEC     M[ ConfColisaoG4 ]
				DEC  	M[ Ghost4Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]

				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndEsqG4

RandomEsq4:  	CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost4 ], R1


EndEsqG4:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovDireitaG4:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	QComeu_pacman
				CALL    QColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost4 ], R4
				JMP.Z  	RandomDir4

				INC  	M[ ConfColisaoG4 ]

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG4 ]
				ADD  	R4, R2

				DEC  	R4
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				INC  	M[ Ghost4Column ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndDirG4

RandomDir4:  	CALL 	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost4 ], R1

EndDirG4:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovCimaG4:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	QComeu_pacman
				CALL  	QColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost4 ], R4
				JMP.Z  	RandomCima4

				MOV     R1, 35d
				SUB     M[ ConfColisaoG4 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG4 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				ADD  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				DEC  	M[ Ghost4Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndCimaG4


RandomCima4:    CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[DirecaoGhost4], R1

EndCimaG4:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;-------------------------------------------------
; 					Função
;-------------------------------------------------


MovBaixoG4:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3
				PUSH  	R4

				CALL  	QComeu_pacman
				CALL  	QColisaoG
				MOV  	R4, 5d
				CMP  	M[ DirecaoGhost4 ], R4
				JMP.Z  	RandomBaixo4

				MOV     R1, 35d
				ADD     M[ ConfColisaoG4 ], R1

				MOV  	R2, str1
				MOV   	R4, M[ ConfColisaoG4 ]
				ADD  	R4, R2
				MOV  	R1, 35d

				SUB  	R4, R1
				MOV  	R4, M[ R4 ]

				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8
				OR  	R2, R3
				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R4

				INC  	M[ Ghost4Row ]

				MOV  	R1, FANTASMA
				MOV  	R2, M[ Ghost4Row ]
				MOV  	R3, M[ Ghost4Column ]
				SHL  	R2, 8d
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1
				JMP  	EndBaixoG4


RandomBaixo4:   CALL  	Random
				MOV  	R1, 4d
				MOV  	R2, M[Random_Var]
				DIV   	R2, R1
				MOV  	M[ DirecaoGhost4 ], R1

EndBaixoG4:		POP  	R4
				POP 	R3
				POP  	R2
				POP  	R1
				RET

;------------------------------------------------------
; 
; ZONA VI: FUNÇÕES DE TIMER E MOVIMENTAÇÃO DO PACMAN
;
;------------------------------------------------------

Direita:  		PUSH  	R1

				MOV  	R1, 1d
				MOV  	M[ Direcao ], R1

				POP   	R1
				RTI

Esquerda:  		PUSH  	R1

				MOV  	R1, 2d
				MOV  	M[ Direcao ], R1

				POP   	R1
				RTI

Cima: 			PUSH  	R1

				MOV  	R1, 3d
				MOV  	M[ Direcao ], R1

				POP   	R1
				RTI

Baixo:   		PUSH  	R1

				MOV  	R1, 4d
				MOV  	M[ Direcao ], R1

				POP   	R1
				RTI
;---------------------------------------------
; Função de TIMER 
;---------------------------------------------

TIMER:  		PUSH    R1
				PUSH  	R2
				PUSH  	R3

				MOV     R2, M[ Direcao ]

				CMP     R2, 1d
				CALL.Z  MovDireita

				CMP  	R2, 2d
				CALL.Z  MovEsquerda

				CMP  	R2, 3d
				CALL.Z  MovCima

				CMP  	R2, 4d
				CALL.z  MovBaixo

				CALL  	ComparaDirecao1
				CALL  	ComparaDirecao2
				CALL  	ComparaDirecao3
				CALL  	ComparaDirecao4

				MOV  	R3, M[ QuantPontos ]
				CMP  	R3 , R0
				CALL.Z  Venceu	
				JMP.Z 	EndTimer

				MOV  	R2, M[ NumVidas ]
				CMP  	R2, R0
				CALL.Z 	Perdeu
				JMP.Z  	EndTimer

				MOV  	R1, 3d
				MOV  	M[ TEMPO ], R1
				MOV  	R1, 1d
				MOV  	M[ ATIVA_TEMPO ], R1 ; ativa a interrupção

EndTimer:		POP  	R3
				POP  	R2
				POP  	R1
				RTI	
;------------------------------------------------
; Função para movimentar o pacman pra esquerda
;------------------------------------------------

MovEsquerda:	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				CALL  	PComeu_pacman
				CALL  	SComeu_pacman
				CALL  	TComeu_pacman
				CALL  	QComeu_pacman
				CALL    Colisao

				CMP  	M[ Direcao ], R0
				JMP.Z  	EndEsq
				DEC     M[ ConfColisao ]

				MOV  	R1, VAZIO
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

				DEC  	M[ PacManColumn ]

				MOV  	R1, PACMAN_ESQUERDA
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]

				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

EndEsq:			POP 	R3
				POP  	R2
				POP  	R1
				RET
;-----------------------------------------------
; Função para movimentar o pacman pra esquerda
;-----------------------------------------------

MovDireita:  	PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				CALL  	PComeu_pacman
				CALL  	SComeu_pacman
				CALL  	TComeu_pacman
				CALL  	QComeu_pacman

				CALL    Colisao
				CMP  	M[ Direcao ], R0
				JMP.Z  	EndDir
				INC   	M[ ConfColisao ]

				MOV  	R1, VAZIO
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

				INC  	M[ PacManColumn ]

				MOV  	R1, PACMAN_DIREITA
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

EndDir:			POP 	R3
				POP  	R2
				POP  	R1
				RET
;---------------------------------------------
; Função para movimentar o pacman pra cima
;---------------------------------------------

MovCima:  		PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				CALL  	PComeu_pacman
				CALL  	SComeu_pacman
				CALL  	TComeu_pacman
				CALL  	QComeu_pacman
				
				CALL  	Colisao
				CMP  	M[ Direcao ], R0
				JMP.Z  	EndCima
				MOV     R1, 35d
				SUB     M[ ConfColisao ], R1

				MOV  	R1, VAZIO
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

				DEC  	M[ PacManRow ]

				MOV  	R1, PACMAN_CIMA
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

EndCima:		POP 	R3
				POP  	R2
				POP  	R1
				RET

;---------------------------------------------
; Função para movimentar o pacman pra baixo
;---------------------------------------------

MovBaixo: 		PUSH  	R1
				PUSH  	R2
				PUSH  	R3

				CALL  	PComeu_pacman
				CALL  	SComeu_pacman
				CALL  	TComeu_pacman
				CALL  	QComeu_pacman
				

				CALL  	Colisao
				CMP  	M[ Direcao ], R0
				JMP.Z  	EndBaixo
				MOV  	R1, 35d
				ADD  	M[ ConfColisao ], R1

				; Substitui a posição por um espaço vazio

				MOV  	R1, VAZIO
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

				INC  	M[ PacManRow ]

				; Coloca o Pacman na próxima posição

				MOV  	R1, PACMAN_BAIXO
				MOV  	R2, M[ PacManRow ]
				MOV  	R3, M[ PacManColumn ]
				SHL  	R2, 8
				OR  	R2, R3

				MOV  	M[ CURSOR ], R2
				MOV  	M[ IO_WRITE ], R1

EndBaixo:		POP 	R3
				POP  	R2
				POP  	R1
				RET
	
;-----------------------------------------------
;
;  ZONA VII: Main e função de imprimir o mapa
;	
;-----------------------------------------------



PrintMapa:  	PUSH  	R1
				PUSH	R2
				PUSH	R3

				MOV   	R1, str1
				MOV  	M[ strIndex ], R1

LoopPrint:  	MOV  	R1, M[ RowIndex ]
				SHL		R1, 8
				MOV  	R2, M[ ColumnIndex ]
				OR		R1, R2
				MOV		M[ CURSOR ], R1

				MOV   	R3, M[ strIndex ]
				MOV  	R3, M[ R3 ]
				CMP  	R3, FIM_TEXTO1
				JMP.Z  	Quebra_linha
				CMP  	R3, FIM_HALT
				JMP.Z 	EndPrint

				MOV  	M[ IO_WRITE ], R3

				INC  	M[ ColumnIndex ]
				INC   	M[ strIndex ]

				JMP  	LoopPrint

Quebra_linha:  	INC  	M[ RowIndex ]
				MOV   	R1, 20d
				MOV  	M[ ColumnIndex ], R1
				INC   	M[ strIndex ]
				JMP  	LoopPrint

EndPrint:		POP  	R3
				POP  	R2
				POP  	R1
				RET

Main:			ENI
				MOV		R1, INITIAL_SP
				MOV		SP, R1		 		; We need to initialize the stack
				MOV		R1, CURSOR_INIT		; We need to initialize the cursor 
				MOV		M[ CURSOR ], R1		; with value CURSOR_INIT

				CALL  	imprimeVidas
				CALL	PrintMapa
				CALL  	imprimeFantasma
				CALL  	imprimePacMan


FIM:	MOV  	R1, 5d
		MOV  	M[ TEMPO ], R1
		MOV  	R1, 1d
		MOV  	M[ ATIVA_TEMPO ], R1 ; ativa a interrupção

Cycle: 			BR		Cycle	
Halt:           BR		Halt