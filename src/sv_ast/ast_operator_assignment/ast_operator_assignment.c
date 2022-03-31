#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_operator_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_operator_assignment_free(ast_node_t *node);

ast_node_t* ast_operator_assignment_new(ast_node_t *lvalue, ast_assignment_operator_t assignment_operator, ast_node_t *expression) {
    ast_operator_assignment_t *operator_assignment = calloc(1, sizeof(*operator_assignment));

    operator_assignment->super.print = _ast_operator_assignment_print;
    operator_assignment->super.free = _ast_operator_assignment_free;

    operator_assignment->lvalue = lvalue;
    operator_assignment->assignment_operator = assignment_operator;
    operator_assignment->expression = expression;

    return (ast_node_t *)operator_assignment;
}

static void _ast_operator_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_operator_assignment_t *operator_assignment = (ast_operator_assignment_t *)node;

    ast_node_print(operator_assignment->lvalue, indent, indent_incr);
    ast_assignment_operator_print(operator_assignment->assignment_operator);
    ast_node_print(operator_assignment->expression, indent, indent_incr);
}

static void _ast_operator_assignment_free(ast_node_t *node) {
    ast_operator_assignment_t *operator_assignment = (ast_operator_assignment_t *)node;

    ast_node_free(operator_assignment->lvalue);
    ast_node_free(operator_assignment->expression);
}
