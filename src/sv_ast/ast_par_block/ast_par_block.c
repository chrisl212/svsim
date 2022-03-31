#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_par_block_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_par_block_free(ast_node_t *node);

ast_node_t* ast_par_block_new(ast_node_t *statement_list, ast_join_keyword_t join_keyword, ast_node_t *block_end_identifier0, ast_node_t *block_end_identifier1, ast_node_t *block_item_declaration_list) {
    ast_par_block_t *par_block = calloc(1, sizeof(*par_block));

    par_block->super.print = _ast_par_block_print;
    par_block->super.free = _ast_par_block_free;

    par_block->statement_list = statement_list;
    par_block->join_keyword = join_keyword;
    par_block->block_end_identifier0 = block_end_identifier0;
    par_block->block_end_identifier1 = block_end_identifier1;
    par_block->block_item_declaration_list = block_item_declaration_list;

    return (ast_node_t *)par_block;
}

static void _ast_par_block_print(ast_node_t *node, int indent, int indent_incr) {
    ast_par_block_t *par_block = (ast_par_block_t *)node;

    ast_node_print(par_block->statement_list, indent, indent_incr);
    ast_join_keyword_print(par_block->join_keyword);
    ast_node_print(par_block->block_end_identifier0, indent, indent_incr);
    ast_node_print(par_block->block_end_identifier1, indent, indent_incr);
    ast_node_print(par_block->block_item_declaration_list, indent, indent_incr);
}

static void _ast_par_block_free(ast_node_t *node) {
    ast_par_block_t *par_block = (ast_par_block_t *)node;

    ast_node_free(par_block->statement_list);
    ast_node_free(par_block->block_end_identifier0);
    ast_node_free(par_block->block_end_identifier1);
    ast_node_free(par_block->block_item_declaration_list);
}
