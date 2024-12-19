#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define INT 0
#define FLOAT 1
#define TEX 2
#define INTTABLE 3
#define FLOATTABLE 4
#define TEXTTABLE 5
#define FIXINT 6
#define FIXFLOAT 7
#define FIXTXT 8
#define NONE -1

typedef struct table{
	char* name;
   	int type;
   	int ival;
   	float fval;
   	char* tval;
   	int size;
   	int con;
   	
	struct table* next; 	
}table;

typedef struct operationstack{
	int type;
	struct operationstack* next;
}operationstack;

operationstack* stack = NULL;
table* head = NULL;

table* inserer(char name[], int type, int size){
	table* temp = malloc(sizeof(table));
	temp->name = strdup(name);
	temp->next = head;
	temp->type = type;
	temp->size = size;
	head = temp;
}

table* rechercher(char name[]){
	table* temp = head;
	while(temp){
		if(strcmp(temp->name, name) == 0){
			return temp;
		}
		temp = temp->next;
	}
	return NULL;
}

void afficher(){
	table* temp = head;
	
	printf("\t_____________________________________\n");
	printf("\t| NomEntite |  TypeEntite | extra\n");
	printf("\t_____________________________________\n");
	
	while(temp){	
		printf("\t|%s ",temp->name);
		if(temp->type == INT){
			printf("| integer | \n", temp->ival);
		}else if(temp->type == FLOAT){
			printf("| float | \n", temp->fval);
		}else if(temp->type == TEX){ 
			printf("| text \n");
		}else if(temp->type == INTTABLE){
			printf("| int table | %d\n", temp->size);
		}else if(temp->type == FLOATTABLE){
			printf("| float table | %d\n", temp->size);
		}else if(temp->type == FIXINT){
			printf("| int const | \n");
		}else if(temp->type == FIXFLOAT){
			printf("| float const | \n");
		}else if(temp->type == FIXTXT){
			printf("| TEXT const | \n");
		}else{
			printf("\n");
		}
		temp = temp->next;
	}
}

void verifconst(char* name){
	table* e = rechercher(name);
	if (e == NULL) {
        printf("Erreur semantique : La constante '%s' n'existe pas.\n", name);
        return;
    }
    if(e->type >= 6){
    	printf("Erreur semantique : La constante ne peut pas etre mis a jour\n");
	}
}

void verifierDivisionParZero(char* constante) {
    table* e = rechercher(constante);

    if (e == NULL) {
        printf("Erreur semantique : La constante '%s' n'existe pas.\n", constante);
        return;
    }

    if (e->type == INT && e->ival == 0) {
        printf("Erreur semantique : Division par zero avec la constante '%s'.\n", constante);
    } else if (e->type == FLOAT && e->fval == 0.0) {
        printf("Erreur semantique : Division par zero avec la constante '%s'.\n", constante);
    }  
}

void verifierVariableNonDeclaree(char* var) {
    table* variable = rechercher(var);

    if (variable == NULL) { 
        printf("Erreur semantique : La variable '%s' n'est pas declaree.\n", var);
    }
}

void verifierDepassementTableau(char* tableau, int index) {
    table* e = rechercher(tableau);

    if (e == NULL) {
        printf("Erreur semantique : Le tableau '%s' n'existe pas.\n", tableau);
        return;
    }
    if (e->size <= index) { // e->ival contient la taille du tableau
        printf("Erreur semantique : Depassement de la taille du tableau '%s'. Index %d hors limites (taille max = %d).\n", 
               tableau, index, e->size);
    }
}

void addop(int type){
	operationstack* temp = malloc(sizeof(operationstack));
	temp->type = type;
	temp->next = stack;
	stack = temp; 
}
void addopname(char* name){
	operationstack* temp = malloc(sizeof(operationstack));
	table* t = rechercher(name);
	if(t){
			temp->type = t->type%3;
	}else{
		temp->type = NONE;
	}
	temp->next = stack;
	stack = temp; 
}

void verifop(){
	operationstack* temp;
	while(stack){
		temp = stack->next;
		if(temp){
			if(temp->type != stack->type){
				printf("Erreur semantique : Incompatibilite type operation\n");
				while(temp){
					free(stack);
					stack = temp;
					temp = stack->next;
				}
				stack = NULL;
				return;
			}
		}
		free(stack);
		stack = temp;
	}
	stack= NULL;
}
