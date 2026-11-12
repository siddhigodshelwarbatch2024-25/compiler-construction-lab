include <stdio.h>
%}

%%
"sec-B" { printf("found sec-B"); }
.|\n    {}
%%

int main(){
    printf("Enter a Statement: ");
    yylex();
    return 0;
}

int yywrap(){
    return 1;
}
