#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_concurrent_assertion_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_concurrent_assertion_item_free(ast_node_t *node);

ast_node_t* ast_concurrent_assertion_item_new(ast_node_t *identifier, ast_node_t *concurrent_assertion_statement, ast_node_t *checker_instantiation) {
    ast_concurrent_assertion_item_t *concurrent_assertion_item = calloc(1, sizeof(*concurrent_assertion_item));

    concurrent_assertion_item->super.print = _ast_concurrent_assertion_item_print;
    concurrent_assertion_item->super.free = _ast_concurrent_assertion_item_free;

    concurrent_assertion_item->identifier = identifier;
    concurrent_assertion_item->concurrent_assertion_statement = concurrent_assertion_statement;
    concurrent_assertion_item->checker_instantiation = checker_instantiation;

    return (ast_node_t *)concurrent_assertion_item;
}

static void _ast_concurrent_assertion_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_concurrent_assertion_item_t *concurrent_assertion_item = (ast_concurrent_assertion_item_t *)node;

    ast_node_print(concurrent_assertion_item->identifier, indent, indent_incr);
    ast_node_print(concurrent_assertion_item->concurrent_assertion_statement, indent, indent_incr);
    ast_node_print(concurrent_assertion_item->checker_instantiation, indent, indent_incr);
}

static void _ast_concurrent_assertion_item_free(ast_node_t *node) {
    ast_concurrent_assertion_item_t *concurrent_assertion_item = (ast_concurrent_assertion_item_t *)node;

    ast_node_free(concurrent_assertion_item->identifier);
    ast_node_free(concurrent_assertion_item->concurrent_assertion_statement);
    ast_node_free(concurrent_assertion_item->checker_instantiation);
}
