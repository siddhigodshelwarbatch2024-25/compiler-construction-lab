%{
#include <math.h>

int yylex();
int yyerror(char *s);
%}

%token NUMBER

%%
stmt : stmt expr '\n' { printf("Result: %d\n", $2); }

expr : NUMBER          { $$ = $1; }
     | expr expr '+'    { $$ = $1 + $2; }
     | expr expr '*'    { $$ = $1 * $2; }
     | expr expr '-'    { $$ = $1 - $2; }
     | expr expr '/'    { $$ = $1 / $2; }
     | expr expr '^'    { $$ = (int)pow($1, $2); }
     ;

%%

int yyerror(char *s)
{
    printf("Error\n");
    return 0;
}

int main()
{
    yyparse();
    return 0;
