%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    double value;
}

%token <value> NUMBER
%type <value> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input:
      /* empty */
    | input line
    ;

line:
      '\n'
    | expr '\n' {
          printf("Result = %.2lf\n", $1);
      }
    | error '\n' {
          printf("Invalid expression. Please try again.\n");
          yyerrok;
      }
    ;

expr:
      NUMBER {
          $$ = $1;
      }
    | expr '+' expr {
          $$ = $1 + $3;
      }
    | expr '-' expr {
          $$ = $1 - $3;
      }
    | expr '*' expr {
          $$ = $1 * $3;
      }
    | expr '/' expr {
          if ($3 == 0) {
              printf("Error: Division by zero!\n");
              $$ = 0;
          }
          else {
              $$ = $1 / $3;
          }
      }
    | '-' expr %prec UMINUS {
          $$ = -$2;
      }
    | '(' expr ')' {
          $$ = $2;
      }
    ;

%%

void yyerror(const char *s)
{
    printf("Syntax Error: %s\n", s);
}

int main()
{
    printf("Desk Calculator with Error Recovery\n");
    printf("Enter expressions (one per line):\n");

    yyparse();

    return 0;
}
