#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_nonblocking_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_nonblocking_assignment_free(ast_node_t *node);

ast_node_t* ast_nonblocking_assignment_new(ast_node_t *lvalue, ast_node_t *expression, ast_node_t *delay_or_event_control) {
    ast_nonblocking_assignment_t *nonblocking_assignment = calloc(1, sizeof(*nonblocking_assignment));

    nonblocking_assignment->super.print = _ast_nonblocking_assignment_print;
    nonblocking_assignment->super.free = _ast_nonblocking_assignment_free;

    nonblocking_assignment->lvalue = lvalue;
    nonblocking_assignment->expression = expression;
    nonblocking_assignment->delay_or_event_control = delay_or_event_control;

    return (ast_node_t *)nonblocking_assignment;
}

static void _ast_nonblocking_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_nonblocking_assignment_t *nonblocking_assignment = (ast_nonblocking_assignment_t *)node;

    ast_node_print(nonblocking_assignment->lvalue, indent, indent_incr);
    ast_node_print(nonblocking_assignment->expression, indent, indent_incr);
    ast_node_print(nonblocking_assignment->delay_or_event_control, indent, indent_incr);
}

static void _ast_nonblocking_assignment_free(ast_node_t *node) {
    ast_nonblocking_assignment_t *nonblocking_assignment = (ast_nonblocking_assignment_t *)node;

    ast_node_free(nonblocking_assignment->lvalue);
    ast_node_free(nonblocking_assignment->expression);
    ast_node_free(nonblocking_assignment->delay_or_event_control);
}
