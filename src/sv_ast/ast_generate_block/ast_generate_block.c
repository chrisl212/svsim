#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_generate_block_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_generate_block_free(ast_node_t *node);

ast_node_t* ast_generate_block_new(ast_node_t *identifier1, ast_node_t *generate_item_list, ast_node_t *identifier, ast_node_t *generate_item, ast_node_t *block_end_identifier, ast_node_t *identifier0) {
    ast_generate_block_t *generate_block = calloc(1, sizeof(*generate_block));

    generate_block->super.print = _ast_generate_block_print;
    generate_block->super.free = _ast_generate_block_free;

    generate_block->identifier1 = identifier1;
    generate_block->generate_item_list = generate_item_list;
    generate_block->identifier = identifier;
    generate_block->generate_item = generate_item;
    generate_block->block_end_identifier = block_end_identifier;
    generate_block->identifier0 = identifier0;

    return (ast_node_t *)generate_block;
}

static void _ast_generate_block_print(ast_node_t *node, int indent, int indent_incr) {
    ast_generate_block_t *generate_block = (ast_generate_block_t *)node;

    ast_node_print(generate_block->identifier1, indent, indent_incr);
    ast_node_print(generate_block->generate_item_list, indent, indent_incr);
    ast_node_print(generate_block->identifier, indent, indent_incr);
    ast_node_print(generate_block->generate_item, indent, indent_incr);
    ast_node_print(generate_block->block_end_identifier, indent, indent_incr);
    ast_node_print(generate_block->identifier0, indent, indent_incr);
}

static void _ast_generate_block_free(ast_node_t *node) {
    ast_generate_block_t *generate_block = (ast_generate_block_t *)node;

    ast_node_free(generate_block->identifier1);
    ast_node_free(generate_block->generate_item_list);
    ast_node_free(generate_block->identifier);
    ast_node_free(generate_block->generate_item);
    ast_node_free(generate_block->block_end_identifier);
    ast_node_free(generate_block->identifier0);
}
