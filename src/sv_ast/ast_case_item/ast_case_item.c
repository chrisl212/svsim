#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_case_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_case_item_free(ast_node_t *node);

ast_node_t* ast_case_item_new(ast_node_t *expression_list, ast_node_t *statement) {
    ast_case_item_t *case_item = calloc(1, sizeof(*case_item));

    case_item->super.print = _ast_case_item_print;
    case_item->super.free = _ast_case_item_free;

    case_item->expression_list = expression_list;
    case_item->statement = statement;

    return (ast_node_t *)case_item;
}

static void _ast_case_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_case_item_t *case_item = (ast_case_item_t *)node;

    ast_node_print(case_item->expression_list, indent, indent_incr);
    ast_node_print(case_item->statement, indent, indent_incr);
}

static void _ast_case_item_free(ast_node_t *node) {
    ast_case_item_t *case_item = (ast_case_item_t *)node;

    ast_node_free(case_item->expression_list);
    ast_node_free(case_item->statement);
}
