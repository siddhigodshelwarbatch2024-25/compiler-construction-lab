%{
#include <stdio.h>
%}

%%
.*[Cc][Oo][Mm]\n    { printf("Valid\n"); }
.*\n                { printf("Invalid\n"); }
%%

int main()
{
    yylex();
    return 0;
}

int yywrap()
{
    return 1;
}
