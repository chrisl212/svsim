#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_continuous_assign_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_continuous_assign_free(ast_node_t *node);

ast_node_t* ast_continuous_assign_new(ast_node_t *delay_control, ast_node_t *variable_assignment_list) {
    ast_continuous_assign_t *continuous_assign = calloc(1, sizeof(*continuous_assign));

    continuous_assign->super.print = _ast_continuous_assign_print;
    continuous_assign->super.free = _ast_continuous_assign_free;

    continuous_assign->delay_control = delay_control;
    continuous_assign->variable_assignment_list = variable_assignment_list;

    return (ast_node_t *)continuous_assign;
}

static void _ast_continuous_assign_print(ast_node_t *node, int indent, int indent_incr) {
    ast_continuous_assign_t *continuous_assign = (ast_continuous_assign_t *)node;

    ast_node_print(continuous_assign->delay_control, indent, indent_incr);
    ast_node_print(continuous_assign->variable_assignment_list, indent, indent_incr);
}

static void _ast_continuous_assign_free(ast_node_t *node) {
    ast_continuous_assign_t *continuous_assign = (ast_continuous_assign_t *)node;

    ast_node_free(continuous_assign->delay_control);
    ast_node_free(continuous_assign->variable_assignment_list);
}
