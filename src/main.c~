#include <stdio.h>
#include "sv_error/sv_error.h"
#include "sv_parse/parser/parser.tab.h"
#include "sv_ast/ast.h"

ast_node_t *root;

int main(int argc, char **argv) {
    int rc = yyparse();

    ast_node_print(root, 0, 2);

    return (rc) ? 1 : SV_OK;
}
