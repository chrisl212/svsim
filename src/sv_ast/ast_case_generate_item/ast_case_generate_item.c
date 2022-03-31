#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_case_generate_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_case_generate_item_free(ast_node_t *node);

ast_node_t* ast_case_generate_item_new(ast_node_t *expression_list, ast_node_t *generate_block) {
    ast_case_generate_item_t *case_generate_item = calloc(1, sizeof(*case_generate_item));

    case_generate_item->super.print = _ast_case_generate_item_print;
    case_generate_item->super.free = _ast_case_generate_item_free;

    case_generate_item->expression_list = expression_list;
    case_generate_item->generate_block = generate_block;

    return (ast_node_t *)case_generate_item;
}

static void _ast_case_generate_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_case_generate_item_t *case_generate_item = (ast_case_generate_item_t *)node;

    ast_node_print(case_generate_item->expression_list, indent, indent_incr);
    ast_node_print(case_generate_item->generate_block, indent, indent_incr);
}

static void _ast_case_generate_item_free(ast_node_t *node) {
    ast_case_generate_item_t *case_generate_item = (ast_case_generate_item_t *)node;

    ast_node_free(case_generate_item->expression_list);
    ast_node_free(case_generate_item->generate_block);
}
