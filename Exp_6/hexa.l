%{
#include <stdio.h>
#include <stdlib.h>

FILE *output;
%}

%%
[0-9]+ {
    int n = atoi(yytext);

    printf("Hexadecimal: %X\n", n);
    fprintf(output, "Decimal: %d Hexadecimal: %X\n", n, n);
}

[ \t\n]+ ;

. {
    printf("Invalid input\n");
}
%%

int main()
{
    output = fopen("output.txt", "w");

    if (output == NULL)
    {
        printf("Error opening file\n");
        return 1;
    }

    printf("Enter decimal number: ");
    yylex();

    fclose(output);
    return 0;
}

int yywrap()
{
    return 1;
}
