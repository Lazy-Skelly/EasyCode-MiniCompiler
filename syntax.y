
%{
#include <stdio.h>
#include <stdlib.h>
%}

%token DEBUT EXECUTION FIN NUM REAL TEXT FIXE SI ALORS SINON TANTQUE AFFICHE LIRE
%token IDF CST STRING OP AFF

%start program
%%
program: DEBUT declaration EXECUTION '{' body '}' FIN {printf("UwU master youw code is sywantiquawy cowwect !! \\( \"UwU)/");}
;

declaration: dectype declaration | fix declaration | 
;

dectype: type ':' IDF ';' | type ':' IDF '[' CST ']' ';'
;

fix: FIXE TEXT ':' IDF OP STRING ';' | FIXE NUM ':' IDF OP CST ';' | FIXE REAL ':' IDF OP CST ';'
; 

type: NUM | TEXT | REAL
;

body: affectation body| function body| condition body | boucle body |
;

affectation: IDF AFF operation ';'
;

operation: CST OP operation | IDF OP operation | IDF '[' CST ']' operation | CST | IDF | IDF '[' CST ']' | '('operation')' | '('operation')' OP operation 
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
    fprintf(stderr, "Erreur syntaxique : %s\n", msg);
    return 0;
}
main() {
	
    yyparse();
}

yywrap()
{}

