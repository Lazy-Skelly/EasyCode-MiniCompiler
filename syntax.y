
%{
#include <stdio.h>
#include <stdlib.h>
int nb_ligne = 1;
%}

//int 0, float 1, string 2
%union{
	char* value;
}

%token DEBUT EXECUTION FIN NUM REAL TEXT FIXE SI ALORS SINON TANTQUE AFFICHE LIRE
%token <value>IDF <value>CST <value>STRING OP AFF <value>fl <value>integer

%start program
%%
program: DEBUT declaration EXECUTION '{' body '}' FIN {printf("UwU master youw code is sywantiquawy cowwect !! \\( \"UwU)/");}
;

declaration: dectype declaration | fix declaration | 
;

dectype: type ':' IDF encore ';' {printf("we got %s",$3);}| type ':' IDF '[' CST ']' encore ';'
;

encore: ',' affectation encore | ',' IDF encore | ',' IDF '[' CST ']' encore |
;

fix: FIXE TEXT ':' IDF OP STRING ';' | FIXE NUM ':' IDF OP CST ';' | FIXE REAL ':' IDF OP values ';'
; 

type: NUM | TEXT | REAL
;

body: affectation ';' body| function body| condition body | boucle body |
;

affectation: IDF AFF operation
;

operation: values OP operation | IDF OP operation | IDF '[' CST ']' operation | values | IDF | IDF '[' CST ']' | '('operation')' | '('operation')' OP operation 
;

values: CST | fl | integer
; 

function: LIRE '('IDF')' ';' | AFFICHE '(' expression ')' ';'
;

expression: operation ',' expression| STRING ',' expression| operation | STRING
;

condition: SI '(' operation ')' ALORS '{' body '}' | SI '(' ')' ALORS '{' body '}' SINON '{' body '}'
;

boucle: TANTQUE '(' operation ')' '{' body '}'
;

%%
int yyerror(char *msg) {
    fprintf(stderr, "Erreur syntaxique : %s ligne %d\n", msg, nb_ligne);
    return 0;
}
main() {
	
    yyparse();
}

yywrap()
{}

