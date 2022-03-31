#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_expect_property_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_expect_property_statement_free(ast_node_t *node);

ast_node_t* ast_expect_property_statement_new(ast_node_t *action_block, ast_node_t *property_spec) {
    ast_expect_property_statement_t *expect_property_statement = calloc(1, sizeof(*expect_property_statement));

    expect_property_statement->super.print = _ast_expect_property_statement_print;
    expect_property_statement->super.free = _ast_expect_property_statement_free;

    expect_property_statement->action_block = action_block;
    expect_property_statement->property_spec = property_spec;

    return (ast_node_t *)expect_property_statement;
}

static void _ast_expect_property_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_expect_property_statement_t *expect_property_statement = (ast_expect_property_statement_t *)node;

    ast_node_print(expect_property_statement->action_block, indent, indent_incr);
    ast_node_print(expect_property_statement->property_spec, indent, indent_incr);
}

static void _ast_expect_property_statement_free(ast_node_t *node) {
    ast_expect_property_statement_t *expect_property_statement = (ast_expect_property_statement_t *)node;

    ast_node_free(expect_property_statement->action_block);
    ast_node_free(expect_property_statement->property_spec);
}
