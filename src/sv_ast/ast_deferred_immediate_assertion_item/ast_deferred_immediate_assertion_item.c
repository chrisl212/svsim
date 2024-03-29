#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_deferred_immediate_assertion_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_deferred_immediate_assertion_item_free(ast_node_t *node);

ast_node_t* ast_deferred_immediate_assertion_item_new(ast_node_t *identifier, ast_node_t *deferred_immediate_assertion_statement) {
    ast_deferred_immediate_assertion_item_t *deferred_immediate_assertion_item = calloc(1, sizeof(*deferred_immediate_assertion_item));

    deferred_immediate_assertion_item->super.print = _ast_deferred_immediate_assertion_item_print;
    deferred_immediate_assertion_item->super.free = _ast_deferred_immediate_assertion_item_free;

    deferred_immediate_assertion_item->identifier = identifier;
    deferred_immediate_assertion_item->deferred_immediate_assertion_statement = deferred_immediate_assertion_statement;

    return (ast_node_t *)deferred_immediate_assertion_item;
}

static void _ast_deferred_immediate_assertion_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_deferred_immediate_assertion_item_t *deferred_immediate_assertion_item = (ast_deferred_immediate_assertion_item_t *)node;

    ast_node_print(deferred_immediate_assertion_item->identifier, indent, indent_incr);
    ast_node_print(deferred_immediate_assertion_item->deferred_immediate_assertion_statement, indent, indent_incr);
}

static void _ast_deferred_immediate_assertion_item_free(ast_node_t *node) {
    ast_deferred_immediate_assertion_item_t *deferred_immediate_assertion_item = (ast_deferred_immediate_assertion_item_t *)node;

    ast_node_free(deferred_immediate_assertion_item->identifier);
    ast_node_free(deferred_immediate_assertion_item->deferred_immediate_assertion_statement);
}
