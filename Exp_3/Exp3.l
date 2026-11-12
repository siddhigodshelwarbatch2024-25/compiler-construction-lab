%{
#include <stdio.h>

int count = 0;
%}

%%
[Aa][a-zA-Z]*    { count++; }
[ \t\n]+         { }
.                { }
%%

int main()
{
    printf("Enter text:\n");
    yylex();

    printf("Words starting with A: %d\n", count);
    return 0;
}

int yywrap()
{
    return 1;
}
