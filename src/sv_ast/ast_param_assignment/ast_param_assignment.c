#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_param_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_param_assignment_free(ast_node_t *node);

ast_node_t* ast_param_assignment_new(ast_node_t *identifier, ast_node_t *constant_param_expression) {
    ast_param_assignment_t *param_assignment = calloc(1, sizeof(*param_assignment));

    param_assignment->super.print = _ast_param_assignment_print;
    param_assignment->super.free = _ast_param_assignment_free;

    param_assignment->identifier = identifier;
    param_assignment->constant_param_expression = constant_param_expression;

    return (ast_node_t *)param_assignment;
}

static void _ast_param_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_param_assignment_t *param_assignment = (ast_param_assignment_t *)node;

    ast_node_print(param_assignment->identifier, indent, indent_incr);
    ast_node_print(param_assignment->constant_param_expression, indent, indent_incr);
}

static void _ast_param_assignment_free(ast_node_t *node) {
    ast_param_assignment_t *param_assignment = (ast_param_assignment_t *)node;

    ast_node_free(param_assignment->identifier);
    ast_node_free(param_assignment->constant_param_expression);
}
