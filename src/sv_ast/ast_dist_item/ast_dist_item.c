#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_dist_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_dist_item_free(ast_node_t *node);

ast_node_t* ast_dist_item_new(ast_node_t *dist_weight, ast_node_t *value_range) {
    ast_dist_item_t *dist_item = calloc(1, sizeof(*dist_item));

    dist_item->super.print = _ast_dist_item_print;
    dist_item->super.free = _ast_dist_item_free;

    dist_item->dist_weight = dist_weight;
    dist_item->value_range = value_range;

    return (ast_node_t *)dist_item;
}

static void _ast_dist_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_dist_item_t *dist_item = (ast_dist_item_t *)node;

    ast_node_print(dist_item->dist_weight, indent, indent_incr);
    ast_node_print(dist_item->value_range, indent, indent_incr);
}

static void _ast_dist_item_free(ast_node_t *node) {
    ast_dist_item_t *dist_item = (ast_dist_item_t *)node;

    ast_node_free(dist_item->dist_weight);
    ast_node_free(dist_item->value_range);
}
