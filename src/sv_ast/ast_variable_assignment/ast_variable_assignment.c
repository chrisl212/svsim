#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_variable_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_variable_assignment_free(ast_node_t *node);

ast_node_t* ast_variable_assignment_new(ast_node_t *lvalue, ast_node_t *expression) {
    ast_variable_assignment_t *variable_assignment = calloc(1, sizeof(*variable_assignment));

    variable_assignment->super.print = _ast_variable_assignment_print;
    variable_assignment->super.free = _ast_variable_assignment_free;

    variable_assignment->lvalue = lvalue;
    variable_assignment->expression = expression;

    return (ast_node_t *)variable_assignment;
}

static void _ast_variable_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_variable_assignment_t *variable_assignment = (ast_variable_assignment_t *)node;

    ast_node_print(variable_assignment->lvalue, indent, indent_incr);
    ast_node_print(variable_assignment->expression, indent, indent_incr);
}

static void _ast_variable_assignment_free(ast_node_t *node) {
    ast_variable_assignment_t *variable_assignment = (ast_variable_assignment_t *)node;

    ast_node_free(variable_assignment->lvalue);
    ast_node_free(variable_assignment->expression);
}
