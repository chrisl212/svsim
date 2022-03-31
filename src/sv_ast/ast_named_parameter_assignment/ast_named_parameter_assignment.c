#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_named_parameter_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_named_parameter_assignment_free(ast_node_t *node);

ast_node_t* ast_named_parameter_assignment_new(ast_node_t *identifier, ast_node_t *param_expression) {
    ast_named_parameter_assignment_t *named_parameter_assignment = calloc(1, sizeof(*named_parameter_assignment));

    named_parameter_assignment->super.print = _ast_named_parameter_assignment_print;
    named_parameter_assignment->super.free = _ast_named_parameter_assignment_free;

    named_parameter_assignment->identifier = identifier;
    named_parameter_assignment->param_expression = param_expression;

    return (ast_node_t *)named_parameter_assignment;
}

static void _ast_named_parameter_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_named_parameter_assignment_t *named_parameter_assignment = (ast_named_parameter_assignment_t *)node;

    ast_node_print(named_parameter_assignment->identifier, indent, indent_incr);
    ast_node_print(named_parameter_assignment->param_expression, indent, indent_incr);
}

static void _ast_named_parameter_assignment_free(ast_node_t *node) {
    ast_named_parameter_assignment_t *named_parameter_assignment = (ast_named_parameter_assignment_t *)node;

    ast_node_free(named_parameter_assignment->identifier);
    ast_node_free(named_parameter_assignment->param_expression);
}
