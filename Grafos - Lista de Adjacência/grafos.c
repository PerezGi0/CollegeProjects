//Representação de grafos por lista de adjacências.
//Aluna: Giovanna Perez
#include <stdio.h>
#include <stdlib.h>

//Struct que representa um nó de um grafo.
typedef struct vertice{
	int info;
	struct vertice *prox;
} vert;

//Inicializa uma lista de adjacência com cada caminho apontando pra nulo, recebendo o tamanho da lista como parâmetro.
vert *inicializa(int quantVertice){
	vert *vetor =  (vert*)malloc(quantVertice*sizeof(vert));
	for(int i = 0; i < quantVertice; ++i){
		vetor[i].info = i+1;
		vetor[i].prox = NULL;
	}
	return vetor;
}

//Realiza uma busca, retornando o ultimo elemento de um caminho específico, para auxiliar postaeriormente na inserção.
vert *busca(vert *vetor, int indice){
	vert *aux = &vetor[indice-1];
	while(aux->prox != NULL){
		aux = aux->prox;
	}
	return aux;
}

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

//verifica se um vértice específico possui loop.
int loop(vert *vetor, int indice){
	int q = 0;
	vert *aux = vetor[indice-1].prox;
	while(aux != NULL){
		if(aux->info == indice){
			return 1;
		}
		aux = aux->prox;
	}
	return 0;
}

//Calcula o grau de um vértice específico da lista.
int grau(vert *vetor, int indice){
	int l = 0;
	int g = 0;
	vert *aux = vetor[indice-1].prox;
	while(aux != NULL){
			l = loop(vetor, indice);
			if(l == 1){
				g += 2;
			}
			else{
				++g;
			}
			aux = aux->prox;
	}
	return g;
}

//Calcula o grau de cada vértice da lista.
void grauTotal(vert *vetor, int tamanho){
	vert *aux;
	int g = 0;
	for(int i = 0; i < tamanho; ++i){
		aux = vetor[i].prox;
		g = grau(vetor, i+1);
		printf("Vértice %d tem grau %d\n", i+1, g);
	}
	puts("");

}

//Calcula o grau máximo da lista.
void grauMax(vert *vetor, int tamanho){
	int g = 0;
	int aux = 0;
	for(int i = 0; i < tamanho; ++i){
		g = grau(vetor, i+1);
		if(g > aux){
			aux = g;
		}
	}
	printf("Grau Máximo: %d\n", aux);
}

//Calcula o grau mínimo da lista.
void grauMin(vert *vetor, int tamanho){
	int g = 0;
	int aux = tamanho;
	for(int i = 0; i < tamanho; ++i){
		g = grau(vetor, i+1);
		if(g < aux){
			aux = g;
		}
	}
	printf("Grau Mínimo: %d\n", aux);
	puts("");
}

//Verifica se existe algum vértice isolado, se sim, quantos e quais.
void isolados(vert *vetor, int tamanho){
	int v[tamanho];
	for(int i = 0; i < tamanho; ++i){
		v[i] = 0;
	}
	int q = 0, g = 0;
	for(int i = 1; i <= tamanho; ++i){
		g = grau(vetor, i);
		if(g == 0){
			++q;
			v[i-1] = i;
		}
	}
	if(q == 0){
		puts("Não há vértices isolados");
		puts("");
	}
	else{
		printf("Os vértices abaixo são isolados:\n");
		for(int i = 0; i < tamanho; ++i){
			if(v[i] != 0)
				printf("%d ", v[i]);
		}
		puts("");
		printf("Total: %d\n", q);
		puts("");
	}
}

//Verifica se existe algum loop na lista, se sim, quantos e quais.
void loops(vert *vetor, int tamanho){
	int v[tamanho];
	for(int i = 0; i < tamanho; ++i){
		v[i] = 0;
	}
	int q = 0;
	vert *aux;
	for(int i = 0; i < tamanho; ++i){
		aux = vetor[i].prox;
		while(aux != NULL){
			if(aux->info == vetor[i].info){
				++q;
				v[i] = aux->info;
				break;
			}
			aux = aux->prox;
		}
	}
	if(q == 0){
		puts("Não há loops");
		puts("");
	}
	else{
		printf("Há loop nos vértices abaixo:\n");
		for(int i = 0; i < tamanho; ++i){
			if(v[i] != 0)
				printf("%d ", v[i]);
		}
		puts("");
		printf("Total: %d\n", q);
		puts("");
	}
}

//Verifica se a lista é regular.
void regular(vert *vetor, int tamanho){
	int g = 0, cont = 0;
	int aux = grau(vetor, 1);
	for(int i = 1; i < tamanho; ++i){
		g = grau(vetor, i+1);
		if(g != aux){
			puts("Grafo não regular");
			puts("");
			cont = 1;
			break;
		}
		else{
			aux = g;
		}
	}
	if(cont == 0){
		puts("Grafo regular");
		puts("");
	}
}

//verifica se a lista é completa.
void completo(vert *vetor, int tamanho){
	int g = 0, cont = 0;
	int aux = grau(vetor, 1);
	if(aux != tamanho-1){
		puts("Grafo não completo");
		cont = 1;
	}
	else{
		for(int i = 0; i < tamanho; ++i){
			g = grau(vetor, i+1);
			if(g != tamanho-1){
				puts("Grafo não completo");
				cont = 1;
				break;
			}
		}
	}
	if(cont == 0){
		puts("Grafo Completo");
	}
}

//verifica se um determinado caminho é elementar.
void elementar(vert *cab){
	vert *aux = cab;
	vert *aux2 = cab->prox;
	//int i = cab->info;
	int cont = 0;
	while(aux != NULL){
		if(aux->prox != NULL){
			aux2 = aux->prox;
		}
		while(aux2 != NULL){
			if(aux->info == aux2->info){
				puts("O caminho não é elementar");
				cont = 1;
				break;
			}
			aux2 = aux2->prox;
		}
		if(cont == 1){
			break;
		}
		aux = aux->prox;
	}
	if(cont == 0){
		puts("O caminho é elementar");
	}
}

//verifica se um determinado caminho é um ciclo.
void ciclo(vert *cab){
	int p = cab->info;
	vert *aux = cab;
	while(aux->prox != NULL){
		aux = aux->prox;
	}
	if(aux->info == p){
		puts("O caminho é um ciclo");
	}
	else{
		puts("O caminho não é um ciclo");
	}
}

//lê um caminho e chama as funções elementar e ciclo.
void lerCaminho(){
	int aux = 0, cont = 0;
	vert *cab = malloc(sizeof(struct vertice));
	vert *p, *n;
	while(scanf("%i", &aux) != EOF){
		if(cont == 0){
			cab->info = aux;
			cab->prox = NULL;
			//p1 = cab;
		}
		else{
			p = cab;
			while(p->prox != NULL){
				p = p->prox;
			}
			n = malloc(sizeof(struct vertice));
			n->info = aux;
			n->prox = NULL;
			p->prox = n;
		}
		++cont;
	}
	elementar(cab);
	ciclo(cab);
}


int main(){
	int qv = 0, qa = 0, d = 0;

	scanf("%d %d %d", &qv, &qa, &d);
	vert *v = inicializa(qv);

	int cont = 0;
	int x, y;
	while(cont < qa){
		scanf("%d %d", &x, &y);
		insere(v, x, y, d);
		++cont;
	}
	imprime(v, qv);
	loops(v, qv);
	isolados(v, qv);
	grauTotal(v, qv);
	grauMax(v, qv);
	grauMin(v, qv);
	completo(v, qv);
	regular(v, qv);
	lerCaminho();
	return 0;
}