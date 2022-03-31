#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_multiple_concatenation_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_multiple_concatenation_free(ast_node_t *node);

ast_node_t* ast_multiple_concatenation_new(ast_node_t *concatenation, ast_node_t *expression) {
    ast_multiple_concatenation_t *multiple_concatenation = calloc(1, sizeof(*multiple_concatenation));

    multiple_concatenation->super.print = _ast_multiple_concatenation_print;
    multiple_concatenation->super.free = _ast_multiple_concatenation_free;

    multiple_concatenation->concatenation = concatenation;
    multiple_concatenation->expression = expression;

    return (ast_node_t *)multiple_concatenation;
}

static void _ast_multiple_concatenation_print(ast_node_t *node, int indent, int indent_incr) {
    ast_multiple_concatenation_t *multiple_concatenation = (ast_multiple_concatenation_t *)node;

    ast_node_print(multiple_concatenation->concatenation, indent, indent_incr);
    ast_node_print(multiple_concatenation->expression, indent, indent_incr);
}

static void _ast_multiple_concatenation_free(ast_node_t *node) {
    ast_multiple_concatenation_t *multiple_concatenation = (ast_multiple_concatenation_t *)node;

    ast_node_free(multiple_concatenation->concatenation);
    ast_node_free(multiple_concatenation->expression);
}
