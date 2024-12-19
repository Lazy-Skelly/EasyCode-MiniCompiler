/* ------ Analyseur lexicale pour : x=5;  -------------*/
%{
    // Partie : Declarations en C
    #include "syntax.tab.h"
    #include "table.h"
    extern int nb_ligne;
    extern int col;
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
DEBUT {col += strlen(yytext); return DEBUT;}
FIN {col += strlen(yytext);return FIN;}
EXECUTION {col += strlen(yytext);return EXECUTION;}
NUM {col += strlen(yytext);return NUM;}
REAL {col += strlen(yytext);return REAL;}
TEXT  {col += strlen(yytext);return TEXT;}
FIXE  {col += strlen(yytext);return FIXE;}
SI  {col += strlen(yytext);return SI;}
ALORS  {col += strlen(yytext);return ALORS;}
SINON  {col += strlen(yytext);return SINON;}
TANTQUE  {col += strlen(yytext);return TANTQUE;}
affiche  {col += strlen(yytext);return AFFICHE;}
lire  {col += strlen(yytext);return LIRE;}
"{" {col += strlen(yytext);return '{';}
"}" {col += strlen(yytext);return '}';}
"[" {col += strlen(yytext);return '[';}
"]" {col += strlen(yytext);return ']';} 
")" {col += strlen(yytext);return ')';}
"(" {col += strlen(yytext);return '(';}
";" {col += strlen(yytext);return ';';}
":" {col += strlen(yytext);return ':';}
"," {col += strlen(yytext);return ',';}
{IDF} {col += strlen(yytext);yylval.value= strdup(yytext) ;return IDF;}
{cst} {col += strlen(yytext);yylval.value= strdup(yytext) ;return CST;}
{integer} {col += strlen(yytext);yylval.value = strdup(yytext) ;return integer;}
{fl} {col += strlen(yytext);yylval.value= strdup(yytext) ;return fl;}
{string} {col += strlen(yytext);yylval.value = strdup(yytext) ;return STRING;}
{operator} {col += strlen(yytext);return OP;}
"<-" {col += strlen(yytext);return AFF;}

[ \t] 
\n {nb_ligne++; col = 1;}
. printf("erreur lexicale a la ligne %d  col %d\n",nb_ligne, col) ;
%%
