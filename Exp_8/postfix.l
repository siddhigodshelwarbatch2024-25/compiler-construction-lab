%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[+*\/-]     { return yytext[0]; }
[ \t]       { }
\n          { return '\n'; }
.           { printf("Invalid"); }
%%

int yywrap()
{
    return 1;
}
