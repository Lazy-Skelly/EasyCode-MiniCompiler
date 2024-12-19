
%{
#include <stdio.h>
#include <stdlib.h>
int nb_ligne = 1;
int col =1;
int currenttype = -1;

#define INT 0
#define FLOAT 1
#define TEX 2
#define INTTABLE 3
#define FLOATTABLE 4
#define NONE -1

%}

//int 0, float 1, string 2
%union{
	char* value;
}

%token DEBUT EXECUTION FIN NUM REAL TEXT FIXE SI ALORS SINON TANTQUE AFFICHE LIRE
%token <value>IDF <value>CST <value>STRING OP AFF <value>fl <value>integer

%start program
%%
program: DEBUT declaration EXECUTION '{' body '}' FIN {printf("the code is syntaxicaly correct\n");}
;

declaration: dectype declaration | fix declaration | 
;

dectype: type ':' IDF encore ';' {if(!rechercher($3)){inserer($3,currenttype,1);}else{printf("Erreur semantique : La variable '%s' existe\n", $3);}}| type ':' IDF '[' CST ']' encore ';' {if(!rechercher($3)){inserer($3,currenttype+3,atoi($5));}else{printf("Erreur semantique : La variable '%s' existe\n", $3);}}
;

encore: ',' IDF encore {if(!rechercher($2)){inserer($2,currenttype,1);}}| ',' IDF '[' CST ']' encore {if(!rechercher($2)){inserer($2,currenttype,atoi($4));}}|
;

fix: FIXE TEXT ':' IDF OP STRING ';' {if(!rechercher($4)){inserer($4,6,1);}} | FIXE NUM ':' IDF OP CST ';' {if(!rechercher($4)){inserer($4,6,1);}} | FIXE REAL ':' IDF OP values ';' {if(!rechercher($4)){inserer($4,7,1);}}
; 

type: NUM {currenttype = INT}| TEXT {currenttype = TEX}| REAL {currenttype = FLOAT}
;

body: affectation ';' body| function body| condition body | boucle body |
;

affectation: IDF AFF operation {verifierVariableNonDeclaree($1);addopname($1);verifop();verifconst($1);} | IDF AFF STRING {verifierVariableNonDeclaree($1);verifconst($1);}| IDF '[' CST ']'  AFF operation {verifierVariableNonDeclaree($1);verifierDepassementTableau($1,atoi($3));verifop();}
;

operation: values OP operation | IDF OP operation {verifierVariableNonDeclaree($1);addopname($1);}|
 IDF '[' CST ']' operation {verifierVariableNonDeclaree($1);verifierDepassementTableau($1,atoi($3));addopname($1);}| 
values | IDF {verifierVariableNonDeclaree($1);addopname($1);}|
IDF '[' CST ']' {verifierVariableNonDeclaree($1);verifierDepassementTableau($1,atoi($3));addopname($1);}|
'('operation')' | '('operation')' OP operation 
;

values: CST {addop(INT);}| fl {addop(FLOAT);}| integer {addop(INT);}
; 

function: LIRE '('IDF')' ';' | AFFICHE '(' expression ')' ';'
;

expression: operation ',' expression {verifop();}| STRING ',' expression| operation {verifop();}| STRING
;

condition: SI '(' operation ')' ALORS '{' body '}' {verifop();}| SI '(' operation ')' ALORS '{' body '}' SINON '{' body '}' {verifop();}
;

boucle: TANTQUE '(' operation ')' '{' body '}' {verifop();}
;

%%
int yyerror(char *msg) {
    fprintf(stderr, "Erreur syntaxique : %s ligne %d col %d\n", msg, nb_ligne, col);
    return 0;
}
main() {
	
    yyparse();
    afficher();
}

yywrap()
{}

