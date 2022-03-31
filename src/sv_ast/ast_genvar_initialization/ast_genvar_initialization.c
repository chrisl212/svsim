#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_genvar_initialization_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_genvar_initialization_free(ast_node_t *node);

ast_node_t* ast_genvar_initialization_new(ast_node_t *identifier, ast_node_t *expression) {
    ast_genvar_initialization_t *genvar_initialization = calloc(1, sizeof(*genvar_initialization));

    genvar_initialization->super.print = _ast_genvar_initialization_print;
    genvar_initialization->super.free = _ast_genvar_initialization_free;

    genvar_initialization->identifier = identifier;
    genvar_initialization->expression = expression;

    return (ast_node_t *)genvar_initialization;
}

static void _ast_genvar_initialization_print(ast_node_t *node, int indent, int indent_incr) {
    ast_genvar_initialization_t *genvar_initialization = (ast_genvar_initialization_t *)node;

    ast_node_print(genvar_initialization->identifier, indent, indent_incr);
    ast_node_print(genvar_initialization->expression, indent, indent_incr);
}

static void _ast_genvar_initialization_free(ast_node_t *node) {
    ast_genvar_initialization_t *genvar_initialization = (ast_genvar_initialization_t *)node;

    ast_node_free(genvar_initialization->identifier);
    ast_node_free(genvar_initialization->expression);
}
