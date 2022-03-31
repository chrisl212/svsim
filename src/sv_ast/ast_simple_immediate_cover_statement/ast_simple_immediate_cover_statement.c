#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_simple_immediate_cover_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_simple_immediate_cover_statement_free(ast_node_t *node);

ast_node_t* ast_simple_immediate_cover_statement_new(ast_node_t *expression, ast_node_t *statement) {
    ast_simple_immediate_cover_statement_t *simple_immediate_cover_statement = calloc(1, sizeof(*simple_immediate_cover_statement));

    simple_immediate_cover_statement->super.print = _ast_simple_immediate_cover_statement_print;
    simple_immediate_cover_statement->super.free = _ast_simple_immediate_cover_statement_free;

    simple_immediate_cover_statement->expression = expression;
    simple_immediate_cover_statement->statement = statement;

    return (ast_node_t *)simple_immediate_cover_statement;
}

static void _ast_simple_immediate_cover_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_simple_immediate_cover_statement_t *simple_immediate_cover_statement = (ast_simple_immediate_cover_statement_t *)node;

    ast_node_print(simple_immediate_cover_statement->expression, indent, indent_incr);
    ast_node_print(simple_immediate_cover_statement->statement, indent, indent_incr);
}

static void _ast_simple_immediate_cover_statement_free(ast_node_t *node) {
    ast_simple_immediate_cover_statement_t *simple_immediate_cover_statement = (ast_simple_immediate_cover_statement_t *)node;

    ast_node_free(simple_immediate_cover_statement->expression);
    ast_node_free(simple_immediate_cover_statement->statement);
}
