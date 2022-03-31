#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_property_expr_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_property_expr_free(ast_node_t *node);

ast_node_t* ast_property_expr_new(ast_node_t *clocking_event, ast_node_t *property_expr1, ast_node_t *property_expr0, ast_node_t *property_instance, ast_node_t *expression, ast_node_t *part_select_range, ast_node_t *expression_or_dist, ast_node_t *sequence_expr, ast_node_t *property_case_item_list) {
    ast_property_expr_t *property_expr = calloc(1, sizeof(*property_expr));

    property_expr->super.print = _ast_property_expr_print;
    property_expr->super.free = _ast_property_expr_free;

    property_expr->clocking_event = clocking_event;
    property_expr->property_expr1 = property_expr1;
    property_expr->property_expr0 = property_expr0;
    property_expr->property_instance = property_instance;
    property_expr->expression = expression;
    property_expr->part_select_range = part_select_range;
    property_expr->expression_or_dist = expression_or_dist;
    property_expr->sequence_expr = sequence_expr;
    property_expr->property_case_item_list = property_case_item_list;

    return (ast_node_t *)property_expr;
}

static void _ast_property_expr_print(ast_node_t *node, int indent, int indent_incr) {
    ast_property_expr_t *property_expr = (ast_property_expr_t *)node;

    ast_node_print(property_expr->clocking_event, indent, indent_incr);
    ast_node_print(property_expr->property_expr1, indent, indent_incr);
    ast_node_print(property_expr->property_expr0, indent, indent_incr);
    ast_node_print(property_expr->property_instance, indent, indent_incr);
    ast_node_print(property_expr->expression, indent, indent_incr);
    ast_node_print(property_expr->part_select_range, indent, indent_incr);
    ast_node_print(property_expr->expression_or_dist, indent, indent_incr);
    ast_node_print(property_expr->sequence_expr, indent, indent_incr);
    ast_node_print(property_expr->property_case_item_list, indent, indent_incr);
}

static void _ast_property_expr_free(ast_node_t *node) {
    ast_property_expr_t *property_expr = (ast_property_expr_t *)node;

    ast_node_free(property_expr->clocking_event);
    ast_node_free(property_expr->property_expr1);
    ast_node_free(property_expr->property_expr0);
    ast_node_free(property_expr->property_instance);
    ast_node_free(property_expr->expression);
    ast_node_free(property_expr->part_select_range);
    ast_node_free(property_expr->expression_or_dist);
    ast_node_free(property_expr->sequence_expr);
    ast_node_free(property_expr->property_case_item_list);
}
