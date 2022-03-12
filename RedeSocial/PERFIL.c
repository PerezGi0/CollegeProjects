#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "PERFIL.h"

struct Perfil2 *cab;//lista duplamente encadeada.
struct Perfil2 *ult;
struct Grupo *c;//cabeça dos grupos

void lista(){
	c = malloc(sizeof(grupo));//lista encadeada de grupos
	c->prox = NULL;
	cab = malloc(sizeof(perfil2));//lista duplamente encadeada perfil.
	ult = malloc(sizeof(perfil2));
	ult->prox = NULL;
	cab->ant = NULL;
	cab->prox = ult;
	ult->ant = cab;
}

perfil2 * cria_perfil(perfil1 cria){//pega a variável de tipo perfil1 e retorna um nó tipo perfil2
	perfil2 * novo = malloc(sizeof(perfil2));
	novo->id_user = cria;
	novo->mural_user = NULL;
	novo->lista_amgs = NULL;
	novo->entrada_user = NULL;
	return novo;
}

perfil2 *busca(char b[20]){//opção de buscar perfil pelo nome de usuário
	perfil2 *pont = cab;
	perfil2 *p = cab->prox;
	if((p->ant == cab) && p == ult){//lista vazia
		return cab;
	}
	while(p != NULL){
		if(strcmp(p->id_user.user, b) == 0){//achou
			return pont;
		}
		pont = p;
		p = p->prox;
	}
	return NULL;//nao achou
}

void inserir_perfil(perfil2 *insere){//insere o elemento
	perfil2 *p = malloc(sizeof(perfil2));
	perfil2 *pont = busca(insere->id_user.user);
	if((pont == NULL) || pont == cab){
		p = insere;
		//Atualização de ponteiros.
		p->prox = cab->prox;
		p->ant = cab;
		cab->prox = p;
	}
	else{
		puts("Perfil já existente.");
	}
}

void edita(perfil2 *u){
	char e[500];
	int op;
	puts("Digite 1 para alterar o nome.");
	puts("Digite 2 para alterar a ocupação.");
	puts("Digite 3 para alterar o endereço.");
	puts("Digite 4 para alterar a biografia.");
	puts("");
	scanf("%d", &op);

	switch(op){
		case 1://nome
			printf("Digite o novo nome: ");
			scanf(" %[^\n]", e);
			strcpy(u->id_user.nome, e);
			break;
		case 2://ocup
			printf("Digite a nova ocupação: ");
			scanf(" %[^\n]", e);
			strcpy(u->id_user.ocup, e);
			//printf("%s\n", p->id_user.ocup);
			break;
		case 3://endereço
			printf("Digite o novo endereço: ");
			scanf(" %[^\n]", e);
			strcpy(u->id_user.ende, e);
			break;
		case 4://biografia
			printf("Digite a nova biografia: ");
			scanf(" %[^\n]", e);
			strcpy(u->id_user.biografia, e);
			break;
		}
		puts("");
}

void troca_senha(perfil2 *tc){
	while(1 == 1){
		char sn[20], sa[20];
		printf("Para redefinir sua senha, digite a senha anterior: ");
		scanf(" %[^\n]", sa);
		puts("");
		if(strcmp(sa, tc->id_user.senha) == 0){
			printf("Digite a nova senha: ");
			scanf(" %[^\n]", sn);
			strcpy(tc->id_user.senha, sn);
			puts("------Senha alterada com sucesso.------");
			puts("");
			break;
		}
		else{
			puts("Senha incorreta. Tente novamente.");
			puts("");
		}
	}
}


void add_post(perfil2 *ap){
	mural *p = malloc(sizeof(mural));
	puts("No que você está pensando?");
	scanf(" %[^\n]", p->postagem);
	puts("");

	if(ap->mural_user == NULL){//mural vazio
		ap->mural_user = p;
		p->proximo = NULL;
	}
	else{
		p->proximo = ap->mural_user;
		ap->mural_user = p;
	}
	puts("Postagem publicada ao seu mural!");
	puts("");
}


amgs *busca_amg(perfil2 *ba, char b[20]){//busca ordenada
	amgs * p = ba->lista_amgs;
	int ret;

	while(p->pro != NULL){
		ret = strcmp(p->pro->amg_user, b);

		if(ret > 0){
			return p;
		}
		if(ret == 0){//se já estiver na lista
			return NULL;
		}

		p = p->pro;
	}
	return p;
}

void add_amg(perfil2 *aa){
	amgs *p = malloc(sizeof(amgs));
	amgs *aux;
	printf("Digite o nome de usuário que deseja adicionar como amigo(a): ");
	scanf("%s", p->amg_user);
	perfil2 *busc = busca(p->amg_user);
	puts("");
	if(busc == NULL){
		puts("Usuário inexistente. Tente novamente.");
		return;
	}

	if(aa->lista_amgs == NULL){// QUANDO LISTA VAZIA
		aa->lista_amgs = p;
		aa->lista_amgs->pro = NULL;
		printf("Agora você é amigo(a) de %s.\n", p->amg_user);
		puts("");
		return;
	}
	
	else if(strcmp(aa->lista_amgs->amg_user, p->amg_user) > 0){//QUANDO CABEÇA FOR MAIOR QUE OQ EU QUERO INSERIR
		aux = aa->lista_amgs;
		aa->lista_amgs = p;
		aa->lista_amgs->pro = aux;
		printf("Agora você é amigo(a) de %s.\n", p->amg_user);
		puts("");
		return;
	}
	
	else if(strcmp(aa->lista_amgs->amg_user, p->amg_user) == 0){//SE O PRIMEIRO FOR IGUAL AO QUE EU TO PROCURANDO
		printf("Você já possui %s como amigo(a).\n", p->amg_user);
		puts("");
		return;
	}

	amgs *aux2 = busca_amg(aa, p->amg_user);
	if(aux2 == NULL){//já ta na lista
		printf("Você já possui %s como amigo(a).\n", p->amg_user);
		puts("");
		return;
	}
	p->pro = aux2->pro;
	aux2->pro = p;
	printf("Agora você é amigo(a) de %s.\n", p->amg_user);
	puts("");
}

void envia_msg(perfil2 *em){
	char b[20];
	msg *p = malloc(sizeof(msg));// novo nó

	printf("Digite o usuário que deseja enviar uma mensagem: ");
	scanf(" %[^\n]", b);
	perfil2 *rm = busca(b);
	if(rm == NULL){
		puts("Usuário não encontrado.");
		puts("");
		return;
	}
	rm = rm->prox;
	if(rm == NULL){
		rm = rm->ant;
	}
	printf("Digite a mensagem: ");
	scanf(" %[^\n]", p->caixa);
	puts("");
	strcpy(p->remetente, em->id_user.user);

	if(rm->entrada_user == NULL){//SE ENTRADA VAZIA
		rm->entrada_user = p;
		rm->entrada_user->next = NULL;
		printf("Mensagem enviada para %s.\n", rm->id_user.user);
		puts("");
	}
	else{
		p->next = rm->entrada_user;
		rm->entrada_user = p;
		printf("Mensagem enviada para %s.\n", rm->id_user.user);
		puts("");
	}
}

void print_mural(char b[20]){
	perfil2 *p = busca(b);

	if(p != NULL){
		p = p->prox;
	}
	printf("Postagens de %s:\n", p->id_user.user);
	puts("");

	mural *aux = p->mural_user;

	while(aux != NULL){
		printf("%s\n", aux->postagem);
		puts("");
		aux = aux->proximo;
	}
}

void print_lista(char b[20]){
	perfil2 *p = busca(b);
	if(p != NULL){
		p = p->prox;
	}

	printf("Lista de amigos de %s:\n", b);
	amgs *aux = p->lista_amgs;

	while(aux != NULL){
		printf("%s\n", aux->amg_user);
		puts("");
		aux = aux->pro;
	}
	puts("");
}

void limpa_caixa(msg *lc){
	if(lc == NULL){
		return;
	}
	limpa_caixa(lc->next);
	free(lc);
}

void print_caixa(perfil2 *pc){
	puts("Sua caixa de entrada:");
	msg *aux = pc->entrada_user;
	msg *limpa = aux;

	while(aux != NULL){
		printf("Mensagem de %s: ", aux->remetente);
		printf("%s\n", aux->caixa);
		puts("");
		aux = aux->next;
	}

	limpa_caixa(limpa);
	pc->entrada_user = NULL;
}

void imprimir(perfil2 *i){
	printf("Perfil de %s:\n", i->id_user.user);
	printf("Nome de usuário: %s\n", i->id_user.user);
	printf("Nome: %s\n", i->id_user.nome);
	printf("Ocupação: %s\n", i->id_user.ocup);
	printf("Endereço: %s\n", i->id_user.ende);
	printf("Biografia: %s\n", i->id_user.biografia);
	puts("");
}

//-------GRUPO-------

grupo * cria_grupo(char b[20]){//cria uma posição nova
	grupo * novog = malloc(sizeof(perfil2));
	printf("Nome do grupo: ");
	scanf(" %[^\n]", novog->nomeg);
	printf("Descrição: ");
	scanf(" %[^\n]", novog->desc);
	puts("");
	strcpy(novog->lider, b);
	//strcpy(novog->lista_m->u, b);
	novog->mural_grupo = NULL;
	puts("Grupo criado com sucesso.");
	puts("");
	return novog;
}

grupo *acha(char b[20]){
	grupo *pont = c->prox;
	int comp;

	while(pont != NULL){
		comp = strcmp(pont->nomeg, b);
		if(comp == 0){
			//puts("1");
			return pont;
		}
		pont = pont->prox;
	}
	//puts("2");
	return NULL;
}

grupo *busca_grupo(char b[20]){//busca o grupo pelo nome ordenada
	grupo * pont = c;
	grupo *p = pont->prox;
	int comp;

	while(p != NULL){
		comp = strcmp(p->nomeg, b);
		if(comp > 0){
			break;
		}
		if(comp == 0){
			return NULL;
		}
		pont = p;
		p = p->prox;
	}
	return pont;
}

void insere_grupo(grupo *aa){
	grupo *p = malloc(sizeof(grupo));
	grupo *aux = busca_grupo(aa->nomeg);
	grupo *aux2 = malloc(sizeof(grupo));
	if(c->prox == NULL){//QUANDO LISTA VAZIA
		p = aa;
		c->prox = p;
		p->prox = NULL;
		//puts("1");
		return;
	}

	if(aux == NULL){//já ta na lista
		printf("Já existe um grupo chamado '%s' .\n", aa->nomeg);
		puts("");
		return;
	}
	p = aa;
	p->prox = aux->prox;
	aux->prox = p;
}

membro *busca_membro(grupo *bu, char b[20]){//busca usuario na lista de membros
	membro *pont = bu->lista_m;
	//membro *p = pont->prox;
	if(strcmp(bu->lider, b) == 0){
		return pont;
	}

	if(pont == NULL){//lista vazia
		return NULL;
	}
	while(pont != NULL){
		if(strcmp(pont->u, b) == 0){//achou
			return pont;
		}
		pont = pont->prox;
	}
	return NULL;//NAO ACHOU
}

void add_membro(grupo *am, char b[20]){
	membro *p = malloc(sizeof(membro));
	strcpy(p->u, b);

	if(am->lista_m == NULL){
		am->lista_m = p;
		p->prox = NULL;
	}
	else{
		p->prox = am->lista_m;
		am->lista_m = p;
	}
	printf("Agora você faz parte do grupo %s.\n", am->nomeg);
	puts("");
}

void add_post_grupo(grupo *apg, char b[20]){
	//int op;
	membro *aux = busca_membro(apg, b);
	if(aux == NULL){
		puts("Você não tem permissão pra postar nesse grupo pois você não faz parte dele.");
		puts("");
		return;
	}
	muralg *p = malloc(sizeof(muralg));
	strcpy(p->postou, b);
	printf("Compartilhe algo com seus amigos de '%s':\n", apg->nomeg);
	scanf(" %[^\n]", p->post);
	puts("");

	if(apg->mural_grupo == NULL){//mural vazio
		apg->mural_grupo = p;
		p->prox = NULL;
	}
	else{
		p->prox = apg->mural_grupo;
		apg->mural_grupo = p;
	}
	puts("Postagem publicada ao mural do grupo!");
	puts("");
}

void print_mural_grupo(grupo *m){
	printf("---------MURAL DE %s-----------\n", m->nomeg);
	puts("");

	muralg *aux = m->mural_grupo;

	while(aux != NULL){
		printf("Postagem feita por %s:\n", aux->postou);
		printf("%s", aux->post);
		puts("");
		aux = aux->prox;
	}
	puts("");
	puts("");
}

int print_grupo(){
	//grupo *aux = c;
	grupo *p = c->prox;
	while(p != NULL){
		printf("(GRUPO '%s')\n", p->nomeg);
		printf("Lider: %s.\n", p->lider);
		printf("Descrição: %s\n", p->desc);
		print_mural_grupo(p);
		puts("");
		p = p->prox;
	}
}

void limpa_amgs(amgs *la){
	//perfil2 *aux = la;
	amgs *aux = la;//->lista_amgs;
	if(aux == NULL){
		return;
	}
	limpa_amgs(aux->pro);
	free(aux);
}

void limpa_mural(mural *lm){
	//perfil2 *aux = lm;
	mural *aux = lm;//->mural_user;
	if(aux == NULL){
		return;
	}
	limpa_mural(aux->proximo);
	free(aux);
}

void limpa_amgs_mural(){
	perfil2 *aux = cab;
	while(aux != ult){
		limpa_amgs(aux->lista_amgs);
		limpa_mural(aux->mural_user);
		if(aux->entrada_user != NULL){
			limpa_caixa(aux->entrada_user);
		}
		aux = aux->prox;
	}
}

void limpa_tudo(){
	perfil2 *aux = cab;
	if(aux == NULL){
		return;
	}
	limpa_tudo(aux->prox);
	free(aux);
}

void limpa_amgs_grupo(grupo *lag){
	grupo *aux = lag;
	membro *aux2 = lag->lista_m;
	if(aux2 == NULL){
		return;
	}
	limpa_amgs_grupo(aux->prox);
	free(aux2);
}

void limpa_mural_grupo(grupo *lmg){
	grupo *aux = lmg;
	muralg *aux2 = lmg->mural_grupo;
	if(aux2 == NULL){
		return;
	}
	limpa_mural_grupo(aux->prox);
	free(aux2);
}

void limpa_amgs_mural_grupo(){
	grupo *aux = c;
	while(aux != NULL){
		limpa_amgs_grupo(aux);
		limpa_mural_grupo(aux);
		aux = aux->prox;
	}
}

void limpa_tudo_grupo(){
	grupo *aux = c;
	if(aux == NULL){
		return;
	}
	limpa_tudo_grupo(aux->prox);
	free(aux);
}