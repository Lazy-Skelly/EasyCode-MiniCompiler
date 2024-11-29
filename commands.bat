flex lexical.l
bison -d syntax.y
gcc lex.yy.c syntax.tab.c -lfl -ly -o lexical
pause
cls
lexical.exe<twice.txt
pause
