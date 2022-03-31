#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_assert_property_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_assert_property_statement_free(ast_node_t *node);

ast_node_t* ast_assert_property_statement_new(ast_node_t *action_block, ast_node_t *property_spec) {
    ast_assert_property_statement_t *assert_property_statement = calloc(1, sizeof(*assert_property_statement));

    assert_property_statement->super.print = _ast_assert_property_statement_print;
    assert_property_statement->super.free = _ast_assert_property_statement_free;

    assert_property_statement->action_block = action_block;
    assert_property_statement->property_spec = property_spec;

    return (ast_node_t *)assert_property_statement;
}

static void _ast_assert_property_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_assert_property_statement_t *assert_property_statement = (ast_assert_property_statement_t *)node;

    ast_node_print(assert_property_statement->action_block, indent, indent_incr);
    ast_node_print(assert_property_statement->property_spec, indent, indent_incr);
}

static void _ast_assert_property_statement_free(ast_node_t *node) {
    ast_assert_property_statement_t *assert_property_statement = (ast_assert_property_statement_t *)node;

    ast_node_free(assert_property_statement->action_block);
    ast_node_free(assert_property_statement->property_spec);
}
