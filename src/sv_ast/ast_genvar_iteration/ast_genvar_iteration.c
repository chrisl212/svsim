#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_genvar_iteration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_genvar_iteration_free(ast_node_t *node);

ast_node_t* ast_genvar_iteration_new(ast_node_t *identifier, ast_assignment_operator_t assignment_operator, ast_node_t *expression) {
    ast_genvar_iteration_t *genvar_iteration = calloc(1, sizeof(*genvar_iteration));

    genvar_iteration->super.print = _ast_genvar_iteration_print;
    genvar_iteration->super.free = _ast_genvar_iteration_free;

    genvar_iteration->identifier = identifier;
    genvar_iteration->assignment_operator = assignment_operator;
    genvar_iteration->expression = expression;

    return (ast_node_t *)genvar_iteration;
}

static void _ast_genvar_iteration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_genvar_iteration_t *genvar_iteration = (ast_genvar_iteration_t *)node;

    ast_node_print(genvar_iteration->identifier, indent, indent_incr);
    ast_assignment_operator_print(genvar_iteration->assignment_operator);
    ast_node_print(genvar_iteration->expression, indent, indent_incr);
}

static void _ast_genvar_iteration_free(ast_node_t *node) {
    ast_genvar_iteration_t *genvar_iteration = (ast_genvar_iteration_t *)node;

    ast_node_free(genvar_iteration->identifier);
    ast_node_free(genvar_iteration->expression);
}
