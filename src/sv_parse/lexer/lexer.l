%{
    #include <stdio.h>
    #include <string.h>
    #include "sv_types/sv_types.h"
    #include "sv_parse/parser/parser.tab.h"

    int lex_isKeyword(char *s);
%}

NUM     [0-9]+
ID      [A-z_$][A-z0-9_$]*

%%

[ \t\n]+                                        { }
\/\/.*|"/*"([^*]|\*+[^*/])*\*+"/"               { }

{NUM}?'?({NUM}|[hdbo]({NUM}|[ZzXx?A-Fa-f])+)    {
                                                    yylval.int_val = sv_int_create(yytext);
                                                    return LIT_INT;
                                                }
;                                               { return ';'; }
{ID}                                            {
                                                    int k;

                                                    if ((k = lex_isKeyword(yytext))) {
                                                        return k;
                                                    }
                                                    return IDENT;
                                                }

%%

int lex_isKeyword(char *s) {
    if (strcmp(s, "module") == 0) {
        return MODULE;        
    } else if (strcmp(s, "endmodule") == 0) {
        return ENDMODULE;
    }
    return 0;
}
