#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_property_case_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_property_case_item_free(ast_node_t *node);

ast_node_t* ast_property_case_item_new(ast_node_t *property_expr, ast_node_t *expression_or_dist_list) {
    ast_property_case_item_t *property_case_item = calloc(1, sizeof(*property_case_item));

    property_case_item->super.print = _ast_property_case_item_print;
    property_case_item->super.free = _ast_property_case_item_free;

    property_case_item->property_expr = property_expr;
    property_case_item->expression_or_dist_list = expression_or_dist_list;

    return (ast_node_t *)property_case_item;
}

static void _ast_property_case_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_property_case_item_t *property_case_item = (ast_property_case_item_t *)node;

    ast_node_print(property_case_item->property_expr, indent, indent_incr);
    ast_node_print(property_case_item->expression_or_dist_list, indent, indent_incr);
}

static void _ast_property_case_item_free(ast_node_t *node) {
    ast_property_case_item_t *property_case_item = (ast_property_case_item_t *)node;

    ast_node_free(property_case_item->property_expr);
    ast_node_free(property_case_item->expression_or_dist_list);
}
