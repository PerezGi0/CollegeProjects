//Algoritmos em grafos - busca por largura.
//Aluna: Giovanna Perez
#include <stdio.h>
#include <stdlib.h>

typedef struct vertice{//estrutura do vértice
	char cor;
	int info;
	struct vertice *prox;
	int ant;
	int distancia;
} vert;

vert *inicializa(int quantVertice){
	vert *vetor =  (vert*)malloc(quantVertice*sizeof(vert));
	for(int i = 0; i < quantVertice; ++i){
		vetor[i].info = i+1;
		vetor[i].prox = NULL;
		vetor[i].cor = 'W';
		vetor[i].ant = -1;
		vetor[i].distancia = 0;
	}
	return vetor;
}

typedef struct filaBFS{
	int info;
	struct filaBFS *prox;
} fila;

fila *alocaFila(){
	fila *vetor =  (fila*)malloc(sizeof(fila));
	vetor->prox = NULL;
	vetor->info = 0;
	return vetor;
}

fila *enfileira(fila *f, int chave){
	fila *novo = (fila *)malloc(sizeof(fila));
	novo->prox = NULL;
	novo->info = chave;

	if(f->info == 0){//se for o cab
		f = novo;
	}
	else{
		fila *aux = f->prox;
		fila *x;
		if(aux == NULL){
			f->prox = novo;
		}
		else{
			while(aux != NULL){
				x = aux;
				aux = aux->prox;
			}
			x->prox = novo;
		}
	}
	return f;
}

fila *desenfileira(fila *f){
	fila *aux = f->prox;
	if(aux == NULL){
		free(f);
		return NULL;
	}
	f->prox = NULL;
	free(f);
	return aux;
}

void imprimeFila(fila *f){
	fila *aux = f;
	printf("Fila: ");
	while(aux != NULL){
		printf("%d ", aux->info);
		aux = aux->prox;
	}
	puts(" ");
}

void imprimeTudo(fila *f, vert *grafo, int tamanho){
	printf("Noh ");
	for(int i = 0; i < tamanho; ++i){
		printf("%d ", i+1);
	}
	puts(" ");
	printf("d[] ");
	for(int i = 0; i < tamanho; ++i){
		printf("%d ", grafo[i].distancia);
	}
	puts(" ");
	printf("pi[] ");
	for(int i = 0; i < tamanho; ++i){
		printf("%d ", grafo[i].ant);
	}
	puts(" ");
	printf("cor ");
	for(int i = 0; i < tamanho; ++i){
		printf("%c ", grafo[i].cor);
	}
	puts(" ");
	imprimeFila(f);
	puts(" ");
}

void buscaBFS(vert *grafo, int tamanho, int raiz){//recebe um grafo, e o seu vertice inicial
	vert *aux = &grafo[raiz-1];//recebe o vertice de partida da lista de adjacencia
	int x = grafo[raiz-1].info;//recebe o valor do indice de partida

	//cria uma fila e enfilera o primeiro vértice
	fila *f = alocaFila();
	imprimeTudo(f, grafo, tamanho);
	f = enfileira(f, x);
	puts(" ");

	//"pinta" o vértice de partida como cinza (descoberto)
	grafo[x-1].cor = 'G';
	grafo[x-1].distancia = 0;
	grafo[x-1].ant = -1;

	imprimeTudo(f, grafo, tamanho);
	puts(" ");

	//percorre os adjacentes
	int q, adj;
	while(f->info != 0){
		q = f->info;
		f = desenfileira(f);
		if(f == NULL){
			f = alocaFila();
		}
		vert *predecessor = grafo[q-1].prox;
		while(predecessor != NULL){
			adj = predecessor->info;
			if(grafo[adj-1].cor == 'W'){
				f = enfileira(f, adj);
				grafo[adj-1].cor = 'G';
				grafo[adj-1].ant = q;
				grafo[adj-1].distancia = grafo[q-1].distancia+1;
			}
			predecessor = predecessor->prox;
		}
		grafo[q-1].cor = 'B';
		imprimeTudo(f, grafo, tamanho);
		puts(" ");
	}
}

//Realiza uma busca, retornando o ultimo elemento de um caminho específico, para auxiliar postaeriormente na inserção.
vert *busca(vert *vetor, int indice){
	vert *aux = &vetor[indice-1];
	while(aux->prox != NULL){
		aux = aux->prox;
	}
	return aux;
}

/*
//Imprime a lista de adjacência.
void imprime(vert *vetor, int tamanho){
	vert *aux;
	for(int i = 0; i < tamanho; ++i){
		printf("%d: ", i+1);
		aux = vetor[i].prox;
		while(aux != NULL){
			printf("%d ", aux->info);
			aux = aux->prox;
		}
		puts("");
	}
	puts("");	
}
*/

//Realiza a inserção de um vértice em um caminho, recebendo ambos como parâmetro.
void insere(vert *vetor, int indice, int x, int d){
	vert *aux = busca(vetor, indice);
	vert *novo = malloc(sizeof(struct vertice));
	novo->info = x;
	aux->prox = novo;
	novo->prox = NULL;
	if((indice != x) && (d == 0)){
		vert *aux2 = busca(vetor, x);
		//printf("%d\n", aux->info);
		vert *novo2 = malloc(sizeof(struct vertice));
		novo2->info = indice;
		aux2->prox = novo2;
		novo2->prox = NULL;
	}
}

int main(){
	int a, b, c, d;//quantidade de nós, arestas, se é direcional ou não, nó que inicia a busca.
	scanf("%d %d %d %d", &a, &b, &c, &d);
	vert *v = inicializa(a);
	
	int cont = 0;
	int x, y;
	while(cont < b){
		scanf("%d %d", &x, &y);
		insere(v, x, y, c);
		++cont;
	}

	//imprime(v, a);

	buscaBFS(v, a, d);

	return 0;
}

