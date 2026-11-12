
%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);
%}

%token FOR ID NUM INC DEC
%token LE GE EQ NE

%%

S:
    FOR '(' INIT ';' COND ';' UPDATE ')' '{' '}'
    {
        printf("\nValid FOR loop statement!\n");
    }
    ;

INIT:
      ID '=' NUM
    | ID '=' ID
    ;

COND:
      ID '<' NUM
    | ID '>' NUM
    | ID LE NUM
    | ID GE NUM
    | ID EQ NUM
    | ID NE NUM
    | ID '<' ID
    | ID '>' ID
    ;

UPDATE:
      ID INC
    | ID DEC
    | INC ID
    | DEC ID
    | ID '=' ID '+' NUM
    | ID '=' ID '-' NUM
    ;

%%

void yyerror(const char *s)
{
    printf("\nInvalid FOR loop statement!\n");
}

int main()
{
    printf("Enter a FOR loop statement:\n");

    yyparse();

    return 0;
}
