%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+              {
                        yylval = atoi(yytext);
                        return NUM;
                    }

[a-zA-Z][a-zA-Z0-9]* {
                        return ID;
                    }

[+\-*/()]            { return yytext[0]; }

[ \t]                ;

\n                   return '\n';

.                    return yytext[0];

%%

int yywrap()
{
    return 1;
}
