#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define INT 0
#define FLOAT 1
#define TEXT 2
#define INTTABLE 3
#define FLOATTABLE 4
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
	printf("\t| NomEntite |  TypeEntite | ValueEntite\n");
	printf("\t_____________________________________\n");
	
	while(temp){	
		printf("\t|%s ",temp->name);
		if(temp->type == INT){
			printf("| integer | %d\n", temp->ival);
		}else if(temp->type == FLOAT){
			printf("| float | %f\n", temp->fval);
		}else{ 
			printf("| text | %s\n", temp->tval);
		}
		temp = temp->next;
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

void verifierIncompatibiliteType(char* entite1, char* entite2) {
    table* e1 = rechercher(entite1);
    table* e2 = rechercher(entite2);    

    if (e1 == NULL || e2 == NULL) {
        printf("Erreur semantique : Une des entites '%s' ou '%s' n'existe pas.\n", entite1, entite2);
        return;
    }

    if (e1->type != e2->type) {
        printf("Erreur semantique : Incompatibilite de type entre '%s' et '%s'.\n", entite1, entite2);
    }
}

void addop(int type){
	operationstack* temp = malloc(operationstack);
	temp->type = type;
	temp->next = stack;
	stack = temp; 
}
void verifop(){
	operationstack* temp;
	while(stack){
		temp = stack->next;
		if(temp){
			if(temp->type != stack->type){
				printf("Erreur semantique : Incompatibilite de type\n");
			}
		}
	}
}
