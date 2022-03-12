/**
* @file PERFIL.h
* @brief Cabeçalho com as structs e funções usadas no desenvolvimento da rede social
*/
#ifndef PERFIL_H
#define PERFIL_H

///Struct feita para guardar os atributos relacionado ao perfil
typedef struct Perfil1{
	char nome[100];
	char ocup[100];
	char ende[200];
	char biografia[500];
	char user[20];
	char senha[20];
} perfil1;

///Struct usada para representar os nós da lista encadeada que foi usada pra desenvolver o mural de cada conta
typedef struct Mural{
	char postagem[500];
	struct Mural *proximo;
} mural;

///Struct usada para representar os nós da lista encadeada que foi usada para desenvolver a lista de amigos de cada conta
typedef struct Amgs{
	char amg_user[20];//user do amg da lista.
	struct Amgs *pro;//próximo amg da lista.
} amgs;

///Struct usada para representar os nós da lista encadeada que foi usada para desenvolver a caixa de entrada de cada conta
typedef struct Msg{
	char remetente[20];
	char caixa[200];
	struct Msg *next;
} msg;

///Struct feita para criar o nós da lista duplamente encadeada que representa a conta de um usuário. Guardar os ponteiros que inicializam as listas encadeadas (mural, caixa de entra e lista de amigos), a struct referente aos atributos e os ponteiros para anterior e próximo.
typedef struct Perfil2{
	struct Msg *entrada_user;
	struct Amgs *lista_amgs;
	struct Mural *mural_user;
	struct Perfil1 id_user;
	struct Perfil2 *prox;
	struct Perfil2 *ant;
} perfil2;

//GRUPOS:
///Struct usada para representar os nós da lista encadeada usada para desenvolver a lista de membros de um grupo
typedef struct Membro{
	char u[20];
	struct Membro *prox;
} membro;

///Struct usada para representar os nós da lista encadeada usada para desenvolver o mural de um grupo
typedef struct Muralg{
	char postou[20];
	char post[500];
	struct Muralg *prox;
} muralg;

///Struct feita para criar os nós da lista encadeada que representa um grupo. Guarda os ponteiros que inicializam as listas encadeadas (lista de membros e mural do grupo), os atributos do grupo, e o ponteiro para o próximo nó
typedef struct Grupo{
	struct Membro *lista_m;
	struct Muralg *mural_grupo;
	char nomeg[50];
	char lider[20];
	char desc[500];
	struct Grupo *prox;
	//struct Grupo *ant;
} grupo;

//FUNÇÕES

///listagem das funções relacionadas ao perfil:
/**
* @brief função que inicializa a lista duplamente encadeada, aloca o cabeça, o último, e seta eles. Também inicializa a lista encadeada referente aos grupos.
*/
void lista();

/**
* @ brief função que tranforma os atributos da struct perfil1 em um nó perfil2.
* @param cria recebe uma struct perfil1
* @return um nó perfil2
*/
perfil2 * cria_perfil(perfil1 cria);

/**
* @brief função de busca pelo user. Mesma ideia de uma busca em lista duplamente encadeada.
* @param b recebe um char com o nome de usuário
* @return se achou ou não
*/
perfil2 *busca(char b[20]);

/**
* @brief função de inserção de um nó na lista duplamente encadeada de perfis.
* @param insere recebe o nó a ser inserido
*/
void inserir_perfil(perfil2 *insere);

/**
* @brief função que edita os atributos de um perfil
* @param u recebe o nó a ser editado
*/
void edita(perfil2 *u);

/**
* @brief função que tem a mesma ideia da edita(), porém altera a senha, pedindo uma confirmação da senha anterior
* @param tc recebe a conta que fará a alteração da senha
*/
void troca_senha(perfil2 *tc);

/**
* @brief imprime os atributos de um nó específico
* @param i recebe o perfil que será impresso
*/
void imprimir(perfil2 *i);

///funções relacionadas à postagem:
/**
* @brief função que adiciona uma postagem no mural. Mesma ideia de uma inserção em lista encadeada simples.
* @param ap recebe a conta que quer adicionar postagem no mural
*/
void add_post(perfil2 *ap);

/**
* @brief função que imprime as postagens do mural de um usuário.
* @param b recebe o nome de usuário que o mural será impresso
*/
void print_mural(char b[20]);

///funções relacionadas à lista de amigos:
/**
* @brief busca um usuário. Mesma ideia usada em uma busca de lista encadeada ordenada.
* @param ba recebe a conta que está logada no momento
* @param b recebe o user do usuário procurado
* @return se achou ou não.
*/
amgs *busca_amg(perfil2 *ba, char b[20]);

/**
* @brief insere o usuário solicitado na lista de amigos de um usuário. Mesma ideia de uma inserção em lista encadeada ordenada.
* @param aa recebe a conta que vai adicionar um amigo na lista
*/
void add_amg(perfil2 *aa);

/**
* @brief imprime a lista de amigos de um usuário.
* @param b recebe o user do usuário que terá a lista de amigos impressa
*/
void print_lista(char b[20]);

///funções relacionadas à caixa de entrada:
/**
* @brief insere uma mensagem na caixa de entrada do usuário solicitado. Mesma ideia de inserção em lista encadeada simples.
* @param em recebe a conta do usuário que quer anviar uma mensagem
*/
void envia_msg(perfil2 *em);

/**
* @brief limpa a memória de cada nó da lista da caixa de entrada
* @param lc recebe a struct que representa a caixa de entrada
*/
void limpa_caixa(msg *lc);

/**
* @brief imprime a caixa de entrada solicitada
* @param pc recebe o perfil que terá a caixa de entrada impressa
*/
void print_caixa(perfil2 *pc);

///Tentei implementar funções para limpar a memória ao final do código mas não consegui
void limpa_amgs(amgs *la);
void limpa_mural(mural *lm);
void limpa_amgs_mural();
void limpa_tudo();

///funções relacionadas à grupo:
/**
* @brief transforma as informações fornecidas pelo usuário que está criando o grupo em um nó
* @param b recebe o nome de usuário de quem quer criar um grupo
* @return retorna um nó de tipo grupo para ser inserido na lista
*/
grupo * cria_grupo(char b[20]);

/**
* @brief busca um grupo peno nome dele. Mesma ideia de uma busca em lista encadeada.
* @param b recebe o nome do grupo sendo buscado
* @return retorna se achou ou não
*/
grupo *busca_grupo(char b[20]);

/**
* @brief insere um grupo na lista encadeada de grupos.
* @param aa recebe o grupo a ser inserido
*/
void insere_grupo(grupo *aa);

/**
* @brief verifica se um usuário é membro de um grupo
* @param bu recebe o grupo em questão
* @param b recebe user do membro
* @return retorna se ele é ou não membro do grupo
*/
membro *busca_membro(grupo *bu, char b[20]);

/**
* @brief adiciona um usuário como membro de um grupo
* @param am recebe o grupo em questão
* @param b recebe o user do usuário a ser adicionado
*/
void add_membro(grupo *am, char b[20]);

/**
* @brief adiciona postagem no mural de um grupo
* @param apg recebe o grupo em questão
* @param b recebe a postagem
*/
void add_post_grupo(grupo *apg, char b[20]);

/**
* @brief imprime o mural de um grupo.
* @param m recebe o grupo em questão
*/
void print_mural_grupo(grupo *m);

/**
* @brief imprime as informações de um grupo.
*/
int print_grupo();

////Tentei implementar funções para limpar a memória ao final do código mas não consegui
void limpa_amgs_grupo(grupo *lag);
void limpa_mural_grupo(grupo *lmg);
void limpa_amgs_mural_grupo();
void limpa_tudo_grupo();

/**
* @brief verifica se o grupo existe
* @param b recebe o nome do grupo
* @return retorna se achou ou não
*/
grupo *acha(char b[20]);

#endif