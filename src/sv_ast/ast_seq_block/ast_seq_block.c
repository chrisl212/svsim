#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_seq_block_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_seq_block_free(ast_node_t *node);

ast_node_t* ast_seq_block_new(ast_node_t *statement_list, ast_node_t *block_end_identifier1, ast_node_t *block_item_declaration_list, ast_node_t *block_end_identifier0) {
    ast_seq_block_t *seq_block = calloc(1, sizeof(*seq_block));

    seq_block->super.print = _ast_seq_block_print;
    seq_block->super.free = _ast_seq_block_free;

    seq_block->statement_list = statement_list;
    seq_block->block_end_identifier1 = block_end_identifier1;
    seq_block->block_item_declaration_list = block_item_declaration_list;
    seq_block->block_end_identifier0 = block_end_identifier0;

    return (ast_node_t *)seq_block;
}

static void _ast_seq_block_print(ast_node_t *node, int indent, int indent_incr) {
    ast_seq_block_t *seq_block = (ast_seq_block_t *)node;

    ast_node_print(seq_block->statement_list, indent, indent_incr);
    ast_node_print(seq_block->block_end_identifier1, indent, indent_incr);
    ast_node_print(seq_block->block_item_declaration_list, indent, indent_incr);
    ast_node_print(seq_block->block_end_identifier0, indent, indent_incr);
}

static void _ast_seq_block_free(ast_node_t *node) {
    ast_seq_block_t *seq_block = (ast_seq_block_t *)node;

    ast_node_free(seq_block->statement_list);
    ast_node_free(seq_block->block_end_identifier1);
    ast_node_free(seq_block->block_item_declaration_list);
    ast_node_free(seq_block->block_end_identifier0);
}
