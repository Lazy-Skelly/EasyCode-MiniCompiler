%{
#include <stdio.h>
#include <stdlib.h>
%}

%token DEBUT EXECUTION FIN NUM REAL TEXT FIXE SI ALORS SINON TANTQUE AFFICHE LIRE
%token IDF CST STRING OP AFF

%start program
%%
program: DEBUT declaration EXECUTION '{' body '}' FIN {printf("UwU master youw code is sywantiquawy cowwect !!");}
;

declaration: dectype declaration | fix declaration | 
;

dectype: type ':' IDF ';' 
;

fix: FIXE TEXT ':' IDF OP STRING ';' | FIXE NUM ':' IDF OP CST ';' | FIXE REAL ':' IDF OP CST ';'
; 

type: NUM | TEXT | REAL
;

body: affectation body|
;

affectation: IDF AFF operation ';'
;

operation: CST OP operation | IDF OP operation | CST | IDF | '('operation')' | '('operation')' OP operation 
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
