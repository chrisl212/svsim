#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_action_block_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_action_block_free(ast_node_t *node);

ast_node_t* ast_action_block_new(ast_node_t *statement1, ast_node_t *statement, ast_node_t *statement0) {
    ast_action_block_t *action_block = calloc(1, sizeof(*action_block));

    action_block->super.print = _ast_action_block_print;
    action_block->super.free = _ast_action_block_free;

    action_block->statement1 = statement1;
    action_block->statement = statement;
    action_block->statement0 = statement0;

    return (ast_node_t *)action_block;
}

static void _ast_action_block_print(ast_node_t *node, int indent, int indent_incr) {
    ast_action_block_t *action_block = (ast_action_block_t *)node;

    ast_node_print(action_block->statement1, indent, indent_incr);
    ast_node_print(action_block->statement, indent, indent_incr);
    ast_node_print(action_block->statement0, indent, indent_incr);
}

static void _ast_action_block_free(ast_node_t *node) {
    ast_action_block_t *action_block = (ast_action_block_t *)node;

    ast_node_free(action_block->statement1);
    ast_node_free(action_block->statement);
    ast_node_free(action_block->statement0);
}
