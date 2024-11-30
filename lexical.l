/* ------ Analyseur lexicale pour : x=5;  -------------*/
%{
    // Partie : Declarations en C
    #include "syntax.tab.h"
    int nb_ligne=1;
%}
/* -- Partie : Expressions -- */
commentls (--.*##)|("{"-(.|\t)*-"}")
commentm "{"(.|\n)*"}"
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_){0,9}
cst {chiffre}+
string \".*\"
operator ["*"+/<=>]|<=|>=|!=
%%
commentls {printf("commentl");}
commentm {printf("commentm");}
DEBUT {return DEBUT;}
FIN {return FIN;}
EXECUTION {return EXECUTION;}
NUM {return NUM;}
REAL {return REAL;}
TEXT  {return TEXT;}
FIXE  {return FIXE;}
SI  {return SI;}
ALORS  {return ALORS;}
SINON  {return SINON;}
TANTQUE  {return TANTQUE;}
affiche  {return AFFICHE;}
lire  {return LIRE;}
"{" {return '{';}
"}" {return '}';}
"[" {return '[';}
"]" {return ']';} 
")" {return ')';}
"(" {return '(';}
";" {return ';';}
":" {return ':';}
"," {return ',';}
{IDF} {return IDF;}
{cst} {return CST;}
{string} {return STRING;}
{operator} {return OP;}
"<-" {return AFF;}

[ \t] 
\n {nb_ligne++; }
. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
%%
