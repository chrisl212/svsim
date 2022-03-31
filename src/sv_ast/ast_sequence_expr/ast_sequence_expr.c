#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_sequence_expr_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_sequence_expr_free(ast_node_t *node);

ast_node_t* ast_sequence_expr_new(ast_node_t *cycle_delay_range, ast_node_t *sequence_expr1, ast_node_t *covered, ast_node_t *sequence_instance, ast_node_t *expression, ast_node_t *sequence_abbrev, ast_node_t *sequence_match_item_list, ast_node_t *boolean_abbrev, ast_node_t *expression_or_dist, ast_node_t *under, ast_node_t *sequence_expr0, ast_node_t *clocking_event) {
    ast_sequence_expr_t *sequence_expr = calloc(1, sizeof(*sequence_expr));

    sequence_expr->super.print = _ast_sequence_expr_print;
    sequence_expr->super.free = _ast_sequence_expr_free;

    sequence_expr->cycle_delay_range = cycle_delay_range;
    sequence_expr->sequence_expr1 = sequence_expr1;
    sequence_expr->covered = covered;
    sequence_expr->sequence_instance = sequence_instance;
    sequence_expr->expression = expression;
    sequence_expr->sequence_abbrev = sequence_abbrev;
    sequence_expr->sequence_match_item_list = sequence_match_item_list;
    sequence_expr->boolean_abbrev = boolean_abbrev;
    sequence_expr->expression_or_dist = expression_or_dist;
    sequence_expr->under = under;
    sequence_expr->sequence_expr0 = sequence_expr0;
    sequence_expr->clocking_event = clocking_event;

    return (ast_node_t *)sequence_expr;
}

static void _ast_sequence_expr_print(ast_node_t *node, int indent, int indent_incr) {
    ast_sequence_expr_t *sequence_expr = (ast_sequence_expr_t *)node;

    ast_node_print(sequence_expr->cycle_delay_range, indent, indent_incr);
    ast_node_print(sequence_expr->sequence_expr1, indent, indent_incr);
    ast_node_print(sequence_expr->covered, indent, indent_incr);
    ast_node_print(sequence_expr->sequence_instance, indent, indent_incr);
    ast_node_print(sequence_expr->expression, indent, indent_incr);
    ast_node_print(sequence_expr->sequence_abbrev, indent, indent_incr);
    ast_node_print(sequence_expr->sequence_match_item_list, indent, indent_incr);
    ast_node_print(sequence_expr->boolean_abbrev, indent, indent_incr);
    ast_node_print(sequence_expr->expression_or_dist, indent, indent_incr);
    ast_node_print(sequence_expr->under, indent, indent_incr);
    ast_node_print(sequence_expr->sequence_expr0, indent, indent_incr);
    ast_node_print(sequence_expr->clocking_event, indent, indent_incr);
}

static void _ast_sequence_expr_free(ast_node_t *node) {
    ast_sequence_expr_t *sequence_expr = (ast_sequence_expr_t *)node;

    ast_node_free(sequence_expr->cycle_delay_range);
    ast_node_free(sequence_expr->sequence_expr1);
    ast_node_free(sequence_expr->covered);
    ast_node_free(sequence_expr->sequence_instance);
    ast_node_free(sequence_expr->expression);
    ast_node_free(sequence_expr->sequence_abbrev);
    ast_node_free(sequence_expr->sequence_match_item_list);
    ast_node_free(sequence_expr->boolean_abbrev);
    ast_node_free(sequence_expr->expression_or_dist);
    ast_node_free(sequence_expr->under);
    ast_node_free(sequence_expr->sequence_expr0);
    ast_node_free(sequence_expr->clocking_event);
}
