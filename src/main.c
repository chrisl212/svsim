#include <stdio.h>
#include "sv_error/sv_error.h"
#include "sv_parse/parser/parser.tab.h"

int main(int argc, char **argv) {
    yyparse();
    return SV_OK;
}
