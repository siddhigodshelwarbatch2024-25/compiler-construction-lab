%{
#include <stdio.h>

int comments = 0;
int keywords = 0;
int identifiers = 0;
int words = 0;
int lines = 0;
int spaces = 0;
%}

%%
"//".*                              { comments++; }
"/*"([^*]|\*+[^*/])*\*+"/"          { comments++; }

"int"|"float"|"char"|"double"|"if"|"else"|"for"|"while"|"return"
                                    { keywords++; }

[a-zA-Z_][a-zA-Z0-9_]*              { identifiers++; words++; }

\n                                  { lines++; }
[ ]                                 { spaces++; }
[ \t]+                              { spaces += yyleng; }

.                                   { }
%%

int main()
{
    FILE *fp = fopen("input.txt", "r");

    if (fp == NULL)
    {
        printf("Cannot open input file.\n");
        return 1;
    }

    yyin = fp;
    yylex();

    printf("Comments   : %d\n", comments);
    printf("Keywords   : %d\n", keywords);
    printf("Identifiers: %d\n", identifiers);
    printf("Words      : %d\n", words);
    printf("Lines      : %d\n", lines);
    printf("Spaces     : %d\n", spaces);

    fclose(fp);
    return 0;
}

int yywrap()
{
    return 1;
}
