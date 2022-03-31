#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_cover_sequence_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_cover_sequence_statement_free(ast_node_t *node);

ast_node_t* ast_cover_sequence_statement_new(ast_node_t *statement, ast_node_t *expression_or_dist, ast_node_t *sequence_expr, ast_node_t *clocking_event) {
    ast_cover_sequence_statement_t *cover_sequence_statement = calloc(1, sizeof(*cover_sequence_statement));

    cover_sequence_statement->super.print = _ast_cover_sequence_statement_print;
    cover_sequence_statement->super.free = _ast_cover_sequence_statement_free;

    cover_sequence_statement->statement = statement;
    cover_sequence_statement->expression_or_dist = expression_or_dist;
    cover_sequence_statement->sequence_expr = sequence_expr;
    cover_sequence_statement->clocking_event = clocking_event;

    return (ast_node_t *)cover_sequence_statement;
}

static void _ast_cover_sequence_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_cover_sequence_statement_t *cover_sequence_statement = (ast_cover_sequence_statement_t *)node;

    ast_node_print(cover_sequence_statement->statement, indent, indent_incr);
    ast_node_print(cover_sequence_statement->expression_or_dist, indent, indent_incr);
    ast_node_print(cover_sequence_statement->sequence_expr, indent, indent_incr);
    ast_node_print(cover_sequence_statement->clocking_event, indent, indent_incr);
}

static void _ast_cover_sequence_statement_free(ast_node_t *node) {
    ast_cover_sequence_statement_t *cover_sequence_statement = (ast_cover_sequence_statement_t *)node;

    ast_node_free(cover_sequence_statement->statement);
    ast_node_free(cover_sequence_statement->expression_or_dist);
    ast_node_free(cover_sequence_statement->sequence_expr);
    ast_node_free(cover_sequence_statement->clocking_event);
}
