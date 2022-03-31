#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_blocking_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_blocking_assignment_free(ast_node_t *node);

ast_node_t* ast_blocking_assignment_new(ast_assignment_operator_t assignment_operator, ast_node_t *lvalue, ast_node_t *operator_assignment, ast_node_t *expression, ast_node_t *delay_or_event_control, ast_node_t *dynamic_array_new, ast_node_t *class_new) {
    ast_blocking_assignment_t *blocking_assignment = calloc(1, sizeof(*blocking_assignment));

    blocking_assignment->super.print = _ast_blocking_assignment_print;
    blocking_assignment->super.free = _ast_blocking_assignment_free;

    blocking_assignment->assignment_operator = assignment_operator;
    blocking_assignment->lvalue = lvalue;
    blocking_assignment->operator_assignment = operator_assignment;
    blocking_assignment->expression = expression;
    blocking_assignment->delay_or_event_control = delay_or_event_control;
    blocking_assignment->dynamic_array_new = dynamic_array_new;
    blocking_assignment->class_new = class_new;

    return (ast_node_t *)blocking_assignment;
}

static void _ast_blocking_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_blocking_assignment_t *blocking_assignment = (ast_blocking_assignment_t *)node;

    ast_assignment_operator_print(blocking_assignment->assignment_operator);
    ast_node_print(blocking_assignment->lvalue, indent, indent_incr);
    ast_node_print(blocking_assignment->operator_assignment, indent, indent_incr);
    ast_node_print(blocking_assignment->expression, indent, indent_incr);
    ast_node_print(blocking_assignment->delay_or_event_control, indent, indent_incr);
    ast_node_print(blocking_assignment->dynamic_array_new, indent, indent_incr);
    ast_node_print(blocking_assignment->class_new, indent, indent_incr);
}

static void _ast_blocking_assignment_free(ast_node_t *node) {
    ast_blocking_assignment_t *blocking_assignment = (ast_blocking_assignment_t *)node;

    ast_node_free(blocking_assignment->lvalue);
    ast_node_free(blocking_assignment->operator_assignment);
    ast_node_free(blocking_assignment->expression);
    ast_node_free(blocking_assignment->delay_or_event_control);
    ast_node_free(blocking_assignment->dynamic_array_new);
    ast_node_free(blocking_assignment->class_new);
}
