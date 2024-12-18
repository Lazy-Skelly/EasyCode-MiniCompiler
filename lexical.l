/* ------ Analyseur lexicale pour : x=5;  -------------*/
%{
    // Partie : Declarations en C
    #include "syntax.tab.h"
    #include "table.h"
    extern int nb_ligne;
    extern YYSTYPE yylval;
%}
/* -- Partie : Expressions -- */
commentls "--".*?"##"
commentm "{-"(.|\n)*"-}"
operator ["*"+/<=>]|<=|>=|!=|-|" ET "|" OU "|" NON "
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_){0,9}
cst {chiffre}+
integer [\-]?{chiffre}+
fl [\-]?{chiffre}+(\.{chiffre}+)?
string \".*\"
%%
{commentls}
{commentm}
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
{IDF} {yylval.value= strdup(yytext) ;return IDF;}
{cst} {yylval.value= strdup(yytext) ;return CST;}
{integer} {yylval.value = strdup(yytext) ;return integer;}
{fl} {yylval.value= strdup(yytext) ;return fl;}
{string} {yylval.value = strdup(yytext) ;return STRING;}
{operator} {return OP;}
"<-" {return AFF;}

[ \t] 
\n {nb_ligne++; }
. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
%%
