#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "PERFIL.h"

perfil1 a1 = (const perfil1){
	.nome = "Maria",
	.ocup = "Gerente de supermercado",
	.ende = "Rua dos alfeneiros n 11",
	.biografia = "Mãe Coruja",
	.user = "maria2000",
	.senha = "1234"
};
perfil1 a2 = (const perfil1){
	.nome = "joao",
	.ocup = "Zelador",
	.ende = "Rua do Imperador",
	.biografia = "pai de menina",
	.user = "joaoantonio",
	.senha = "valentina"
};
perfil1 a3 = (const perfil1){
	.nome = "Giovanna",
	.ocup = "Estudante",
	.ende = "Rua abc n 123",
	.biografia = "Artista nas horas que sobram.",
	.user = "perezgio",
	.senha = "gio1"
};
perfil1 a4 = (const perfil1){
	.nome = "Maria Clara",
	.ocup = "estudante",
	.ende = "rua joao almeida 123",
	.biografia = "futura médica | 16y | aquário",
	.user = "mari_clara",
	.senha = "floquinho"
};
perfil1 a5 = (const perfil1){
	.nome = "Rose",
	.ocup = "boleira",
	.ende = "avenida lacerda 123",
	.biografia = "encomendas pelo chat",
	.user = "rose_bolos",
	.senha = "tiramissu"
};
perfil1 a6 = (const perfil1){
	.nome = "Ana",
	.ocup = "Piloto de avião",
	.ende = "Av paulista",
	.biografia = "namastê",
	.user = "Ana_cruz",
	.senha = "ana_c20"
};

int r2;

char login[20], passe1[20], passe2[20];//user e senha para logar/criar conta
//perfil2 *log;
int r3, r4, r5, r6, r7, r8;
char nome_busca[20], grupo_buscado[50];
grupo *procura_grupo, *novo_grupo;
perfil2 *procura;

int menu(){
	int r;
	puts("Digite 1 para perfil.");
	puts("(Meu perfil, editar perfil, pesquisar um perfil.)");
	puts("");
	puts("Digite 2 para mural.");
	puts("(Meu mural, fazer postagem, pesquisar um mural.)");
	puts("");
	puts("Digite 3 para lista de amigos.");
	puts("(Minha lista de amigos, adicionar amigo, pesquisa lista de amigos.)");
	puts("");
	puts("Digite 4 para mensagens.");
	puts("(Enviar mensagem, minha caixa de entradas.)");
	puts("");
	puts("Digite 5 para ir até a aba grupos.");
	puts("Digite 6 para troca de senha.");
	//puts("");
	puts("Digite 0 para deslogar.");
	puts("");
	scanf("%d", &r);
	puts("");
	return r;

}

void loop_perfil(perfil2 *log){
	while(1==1){
		puts("-------ABA PERFIL-------");
		puts("");
		imprimir(log);
		puts("");
		puts("Digite 1 para editar o seu perfil.");
		puts("Digite 2 para pesquisar um perfil de outro usuário.");
		puts("Digite 0 para voltar ao menu.");
		puts("");
		scanf("%d", &r3);
		puts("");
		if(r3 == 0){
			break;
		}
		else if(r3 == 1){//edita o perfil
			edita(log);
		}
		else if(r3 == 2){
			printf("Digite o nome de usuário que deseja ver o perfil: ");
			scanf("%s", nome_busca);
			puts("");
			procura = busca(nome_busca);
			procura = procura->prox;
			if(procura == NULL){
				procura = procura->ant;
			}

			if(procura == NULL){
				puts("Usuário não encontrado.");
			}
			else{
				imprimir(procura);
			}
		}
	}
}

void loop_mural(perfil2 *log){
	while(1 == 1){
		puts("-------ABA MURAL-------");
		puts("Digite 1 para fazer uma postagem no seu mural.");
		puts("Digite 2 para vizualizar o seu mural.");
		puts("Digite 3 para pesquisar o mural de um usuário.");
		puts("Digite 0 para voltar ao menu.");
		puts("");
		scanf("%d", &r4);
		puts("");
		if(r4 == 0){
			break;
		}
		else if(r4 == 1){
			add_post(log);
		}
		else if(r4 == 2){
			print_mural(log->id_user.user);
		}
		else if(r4 == 3){
			printf("Digite o nome de usuário o qual deseja ver o mural: ");
			scanf("%s", nome_busca);
			puts("");
			procura = busca(nome_busca);
			procura = procura->prox;
			if(procura == NULL){
				procura = procura->ant;
			}

			if(procura == NULL){
				puts("Usuário não encontrado.");
			}
			else{
				print_mural(procura->id_user.user);
			}
		}
	}
}

void loop_amgs(perfil2 *log){
	while(1==1){
		puts("-------ABA AMIGOS-------");
		puts("Digite 1 para adicionar um amigo.");
		puts("Digite 2 para ver sua lista de amigos.");
		puts("Digite 3 para ver a lista de amigos de outro usuário.");
		puts("Digite 0 para voltar ao menu.");
		puts("");
		scanf("%d", &r5);
		puts("");

		if(r5 == 0){
			break;
		}

		else if(r5 == 1){
			add_amg(log);
		}
		else if(r5 == 2){
			print_lista(log->id_user.user);
		}
		else if(r5 == 3){
			printf("Digite o nome de usuário o qual deseja ver a lista de amigos: ");
			scanf("%s", nome_busca);
			puts("");
			procura = busca(nome_busca);
			procura = procura->prox;
			if(procura == NULL){
				procura = procura->ant;
			}

			if(procura == NULL){
				puts("Usuário não encontrado.");
			}
			else{
				print_lista(procura->id_user.user);
			}
		}

	}
}

void loop_msg(perfil2 *log){
	while(1==1){
		//fflush(stdin);
		puts("-------ABA MENSAGENS-------");
		puts("");
		print_caixa(log);
		puts("");
		puts("Digite 1 para enviar uma mensagem.");
		//puts("Digite 2 para ver sua caixa de entrada.");
		puts("Digite 0 para voltar ao menu.");
		puts("");
		scanf("%d", &r6);
		puts("");

		if(r6 == 0){
			break;
		}
		else if(r6 == 1){
			envia_msg(log);
		}
		//else if(r6 == 2){
		//	print_caixa(log);
		//}
	}
}

void loop_grupos(perfil2 *log){
	while(1==1){
		puts("-------ABA GRUPOS-------");
		puts("Digite 1 para ver a lista de grupos disponíveis.");
		puts("Digite 2 para fazer uma postagem em um de seus grupos.");
		puts("Digite 3 para criar um grupo.");
		puts("Digite 0 para voltar ao menu.");
		puts("");
		scanf("%d", &r7);
		puts("");
		if(r7 == 0){
			break;
		}
		else if(r7 == 1){
			int a = print_grupo();
			//printf("%d\n", a);
			//if(a != 1){
			printf("Para entrar em um dos grupos acima, digite 1\n");
			printf("Caso não deseje entrar e nenhum grupo, digite 0\n");
			scanf("%d", &r8);
			if(r8 == 1){
				printf("Digite o nome do grupo: ");
				scanf(" %[^\n]", grupo_buscado);
				procura_grupo = acha(grupo_buscado);
				if(procura_grupo == NULL){
					puts("Grupo inexistente. Tente novamente.");
				}
				else{
					add_membro(procura_grupo, log->id_user.user);
				}
			}
			//}
		}
		else if(r7 == 2){
			printf("Em qual grupo deseja postar algo no mural: ");
			scanf(" %[^\n]", grupo_buscado);
			procura_grupo = acha(grupo_buscado);
			if(procura_grupo == NULL){
				puts("Grupo inexistente. Tente novamente.");
			}
			else{
				add_post_grupo(procura_grupo, log->id_user.user);
			}

		}
		else if(r7 == 3){
			novo_grupo = cria_grupo(log->id_user.user);
			insere_grupo(novo_grupo);
		}
	}
}

void cria_conta(){
	perfil2 *conta;
	perfil1 conta_antiga;
	while(1){
		printf("Defina um nome de usuário com até 15 caracteres: ");
		scanf("%s", login);
		printf("Defina uma senha com até 15 caracteres: ");
		scanf("%s", passe1);
		printf("Digite novamente a senha: ");
		scanf("%s", passe2);
		puts("");
		if(strcmp(passe1, passe2) == 0){//cria o perfil novo aqui
			strcpy(conta_antiga.user, login);
			strcpy(conta_antiga.senha, passe1);
			strcpy(conta_antiga.ocup, "Nao preenchido.");
			strcpy(conta_antiga.biografia, "Nao preenchido.");
			strcpy(conta_antiga.ende, "Nao preenchido.");
			strcpy(conta_antiga.nome, "Nao preenchido.");

			conta = cria_perfil(conta_antiga);
			inserir_perfil(conta);
			puts("Conta criada. Efetue login para começar.");
			puts("");
			break;
		}
		else{
			puts("Senhas digitadas diferentes. Tente novamente.");
			puts("");
		}
	}
}


int main(){

	lista();
	perfil2 *b1 = cria_perfil(a1);
	perfil2 *b2 = cria_perfil(a2);
	perfil2 *b3 = cria_perfil(a3);
	perfil2 *b4 = cria_perfil(a4);
	perfil2 *b5 = cria_perfil(a5);
	perfil2 *b6 = cria_perfil(a6);
	//perfil2 *b7 = cria_perfil(a7);
	inserir_perfil(b1);
	inserir_perfil(b2);
	inserir_perfil(b3);
	inserir_perfil(b4);
	inserir_perfil(b5);
	inserir_perfil(b6);
	//inserir_perfil(b7);

	int r1;// r2;
	perfil2 *log;
	//char login[20], passe1[20], passe2[20];
	while(1 == 1){//LOOP INICIAL
		puts("-------BEM-VINDO-------");
		puts("Digite 1 para logar na sua conta.");
		puts("Digite 2 para se cadastrar.");
		puts("Digite 0 para sair.");
		puts("");
		scanf("%d", &r1);
		puts("");
		if(r1 == 0){
			puts("---Obrigada por usar!---");
			break;
		}

		else if(r1 == 1){//Loga na conta já existente.
			while(1 == 1){//LOOP DO LOGIN
				printf("Nome de usuário: ");
				scanf("%s", login);
				printf("Senha: ");
				scanf("%s", passe1);
				puts("");
				log = busca(login);//PERFIL DO USUÁRIO LOGADO NESSA MERDA

				if(log == NULL){//se a lista está vazia ou a conta não existe
					puts("De acordo com os nossos registros, sua conta ainda não foi cadastrada.");
					puts("Registre-se já :)");
					puts("");
					break;
				}

				log = log->prox;
				if(log == NULL){
					log = log->ant;
				}

				if(strcmp(log->id_user.senha, passe1) == 0){//PAREI AQUI KCT
					printf("----Bem vindo de volta, %s!----\n", log->id_user.user);
					puts("");
					while(1 == 1){//MENU
						r2 = menu();

						if(r2 == 0){
							break;
						}

						switch(r2){
							case 1://PERFIL
								loop_perfil(log);
								break;
							case 2://MURAL
								loop_mural(log);
								break;
							case 3://AMIGOS
								loop_amgs(log);
								break;
							case 4://MENSAGENS
								loop_msg(log);
								break;
							case 5://TROCA DE SENHA
								loop_grupos(log);
								break;
							case 6:
								troca_senha(log);
								break;

						}
					}

				}
				
				else{//digitou a senha errado
					puts("Senha inválida. Tente novamente.");
					puts("");
				}

				if(r2 == 0){
					break;
				}
			}
		}
		else if(r1 == 2){//cria conta;
			cria_conta();
		}
	}
	//limpa_amgs_mural_grupo();
	//limpa_tudo_grupo();
	//limpa_amgs_mural();
	//limpa_tudo();
	return 0;
}
