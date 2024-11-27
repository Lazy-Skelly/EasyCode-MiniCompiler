/* ------ Analyseur lexicale pour : x=5;  -------------*/
%{
    // Partie : Declarations en C
        int nb_ligne=1;
%}
/* -- Partie : Expressions -- */
lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_){0,9}
cst {chiffre}+
string \".*\"
operator ["*"+-/<=>]|<=|>=|!=
%%
DEBUT printf("debut\n");
FIN printf("fin\n");
EXECUTION printf("execution\n");
NUM printf("int ");
REAL printf("float ");
TEXT  printf("char ");
FIXE  printf("const ");
SI  printf("if ");
SINON  printf("else ");
TANTQUE  printf("while ");
affiche  printf("printf ");
lire  printf("scanf ");
"--" printf(" start comment 1l ");
"##" printf(" end comment 1l \n");
"{-" printf(" start comment ML ");
"-}" printf(" end comment ML \n");
"{" printf("{\n");
"}" printf("}\n");
"[" printf("[ ");
"]" printf("]"); 
")" printf(")");
"(" printf("(");
{IDF} printf ("IDF ");
{cst} printf("cst ");
{string} printf("string ");
{operator} printf("OP ");
"<-" printf ("aff ");
";" printf("pvg \n");
":" printf(": ");

[ \t] 
\n {nb_ligne++; }
. printf("erreur lexicale a la ligne %d \n",nb_ligne) ;
%%

int main () 
{
    yylex () ;
    return 0;
}
