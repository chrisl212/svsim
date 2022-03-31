#include <stdio.h>
#include "ast_edge_identifier.h"

void ast_edge_identifier_print(ast_edge_identifier_t edge_identifier) {
    const char *val;

    switch (edge_identifier) {
        case AST_EDGE_IDENTIFIER_NEGEDGE: val = "negedge"; break;
        case AST_EDGE_IDENTIFIER_EDGE: val = "edge"; break;
        case AST_EDGE_IDENTIFIER_POSEDGE: val = "posedge"; break;
    }

    printf("%s", val);
}
