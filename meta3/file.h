#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <stdbool.h>
#include "y.tab.h"

typedef enum tipo_no{
    no_raiz,
    no_declaracao,
    no_metodos,
    no_statments,
    no_operadores,
    no_terminais,
    no_id
}tipo_no;

typedef struct no *no1;

typedef struct no{
    no1 pai;
    no1 filho;
    no1 irmao;
    tipo_no no_tipo;
    char *valor;           
    char *tipo; 
    char *tipo_anotada;           
}no;

typedef struct metodo{
    char *tipo;
    char *nome_class;
    char *nome_funcao;
    char *tipo_retorna;
    char **tipo_param;
    char **nome_param;
    int num_param;
    char *variavel;
    struct metodo *proximo_metodo;
}metodo;

typedef struct lista{
    metodo *inicio;
}lista;


no1 criar_no(tipo_no no_tipo, char *valor, char *tipo);
void adicionar_irmao(no1 novo, no1 irmao);
void adicionar_filho(no1 pai, no1 novo);
int conta_irmaos(no1 raiz);
void imprime_arvore(no1 raiz, int num);

void imprime_tabela(lista *l);
lista criar_tabela(no1 raiz);
void metodo_decl(no1 r2, lista *l, char *nome_class);
void metodo_header(metodo *tabela, no1 r2);
void metodo_body(metodo *tabela, no1 r2);
char *type(char *type);
void imprime_parametros(char **p, int num);
void field_decl(no1 cr7, lista *l, char *nome_class);
bool verifica_repetido(metodo *aux, char *tipo, char *valor);


