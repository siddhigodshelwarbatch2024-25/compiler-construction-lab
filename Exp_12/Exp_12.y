%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

int temp = 1;
%}

%union {
    int value;
    char name[20];
}

%token <value> NUM
%token <name> ID
%type <name> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
      expr '\n'
      {
          printf("\nIntermediate Code Generated Successfully.\n");
      }
    ;

expr:
      NUM
      {
          sprintf($$, "%d", $1);
      }
    | ID
      {
          sprintf($$, "%s", $1);
      }
    | expr '+' expr
      {
          char t[20];
          sprintf(t, "t%d", temp++);
          printf("%s = %s + %s\n", t, $1, $3);
          sprintf($$, "%s", t);
      }
    | expr '-' expr
      {
          char t[20];
          sprintf(t, "t%d", temp++);
          printf("%s = %s - %s\n", t, $1, $3);
          sprintf($$, "%s", t);
      }
    | expr '*' expr
      {
          char t[20];
          sprintf(t, "t%d", temp++);
          printf("%s = %s * %s\n", t, $1, $3);
          sprintf($$, "%s", t);
      }
    | expr '/' expr
      {
          char t[20];
          sprintf(t, "t%d", temp++);
          printf("%s = %s / %s\n", t, $1, $3);
          sprintf($$, "%s", t);
      }
    | '(' expr ')'
      {
          sprintf($$, "%s", $2);
      }
    | '-' expr %prec UMINUS
      {
          char t[20];
          sprintf(t, "t%d", temp++);
          printf("%s = -%s\n", t, $2);
          sprintf($$, "%s", t);
      }
    ;

%%

void yyerror(const char *s)
{
    printf("Invalid arithmetic expression: %s\n", s);
}

int main()
{
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}
