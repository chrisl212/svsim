#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_clocking_skew_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_clocking_skew_free(ast_node_t *node);

ast_node_t* ast_clocking_skew_new(ast_node_t *delay_control, ast_edge_identifier_t edge_identifier) {
    ast_clocking_skew_t *clocking_skew = calloc(1, sizeof(*clocking_skew));

    clocking_skew->super.print = _ast_clocking_skew_print;
    clocking_skew->super.free = _ast_clocking_skew_free;

    clocking_skew->delay_control = delay_control;
    clocking_skew->edge_identifier = edge_identifier;

    return (ast_node_t *)clocking_skew;
}

static void _ast_clocking_skew_print(ast_node_t *node, int indent, int indent_incr) {
    ast_clocking_skew_t *clocking_skew = (ast_clocking_skew_t *)node;

    ast_node_print(clocking_skew->delay_control, indent, indent_incr);
    ast_edge_identifier_print(clocking_skew->edge_identifier);
}

static void _ast_clocking_skew_free(ast_node_t *node) {
    ast_clocking_skew_t *clocking_skew = (ast_clocking_skew_t *)node;

    ast_node_free(clocking_skew->delay_control);
}
