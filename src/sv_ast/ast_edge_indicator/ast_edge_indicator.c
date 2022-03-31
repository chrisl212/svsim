#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_edge_indicator_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_edge_indicator_free(ast_node_t *node);

ast_node_t* ast_edge_indicator_new(ast_node_t *edge_symbol, ast_node_t *level_symbol0, ast_node_t *level_symbol1) {
    ast_edge_indicator_t *edge_indicator = calloc(1, sizeof(*edge_indicator));

    edge_indicator->super.print = _ast_edge_indicator_print;
    edge_indicator->super.free = _ast_edge_indicator_free;

    edge_indicator->edge_symbol = edge_symbol;
    edge_indicator->level_symbol0 = level_symbol0;
    edge_indicator->level_symbol1 = level_symbol1;

    return (ast_node_t *)edge_indicator;
}

static void _ast_edge_indicator_print(ast_node_t *node, int indent, int indent_incr) {
    ast_edge_indicator_t *edge_indicator = (ast_edge_indicator_t *)node;

    ast_node_print(edge_indicator->edge_symbol, indent, indent_incr);
    ast_node_print(edge_indicator->level_symbol0, indent, indent_incr);
    ast_node_print(edge_indicator->level_symbol1, indent, indent_incr);
}

static void _ast_edge_indicator_free(ast_node_t *node) {
    ast_edge_indicator_t *edge_indicator = (ast_edge_indicator_t *)node;

    ast_node_free(edge_indicator->edge_symbol);
    ast_node_free(edge_indicator->level_symbol0);
    ast_node_free(edge_indicator->level_symbol1);
}
