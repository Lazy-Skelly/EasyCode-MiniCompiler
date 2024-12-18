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
   	
	struct table* next; 	
}table;


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
