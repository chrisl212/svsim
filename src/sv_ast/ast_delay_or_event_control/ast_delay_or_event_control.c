#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_delay_or_event_control_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_delay_or_event_control_free(ast_node_t *node);

ast_node_t* ast_delay_or_event_control_new(ast_node_t *delay_control, ast_node_t *event_control, ast_node_t *expression) {
    ast_delay_or_event_control_t *delay_or_event_control = calloc(1, sizeof(*delay_or_event_control));

    delay_or_event_control->super.print = _ast_delay_or_event_control_print;
    delay_or_event_control->super.free = _ast_delay_or_event_control_free;

    delay_or_event_control->delay_control = delay_control;
    delay_or_event_control->event_control = event_control;
    delay_or_event_control->expression = expression;

    return (ast_node_t *)delay_or_event_control;
}

static void _ast_delay_or_event_control_print(ast_node_t *node, int indent, int indent_incr) {
    ast_delay_or_event_control_t *delay_or_event_control = (ast_delay_or_event_control_t *)node;

    ast_node_print(delay_or_event_control->delay_control, indent, indent_incr);
    ast_node_print(delay_or_event_control->event_control, indent, indent_incr);
    ast_node_print(delay_or_event_control->expression, indent, indent_incr);
}

static void _ast_delay_or_event_control_free(ast_node_t *node) {
    ast_delay_or_event_control_t *delay_or_event_control = (ast_delay_or_event_control_t *)node;

    ast_node_free(delay_or_event_control->delay_control);
    ast_node_free(delay_or_event_control->event_control);
    ast_node_free(delay_or_event_control->expression);
}
