#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_case_generate_construct_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_case_generate_construct_free(ast_node_t *node);

ast_node_t* ast_case_generate_construct_new(ast_node_t *case_generate_item_list, ast_node_t *expression) {
    ast_case_generate_construct_t *case_generate_construct = calloc(1, sizeof(*case_generate_construct));

    case_generate_construct->super.print = _ast_case_generate_construct_print;
    case_generate_construct->super.free = _ast_case_generate_construct_free;

    case_generate_construct->case_generate_item_list = case_generate_item_list;
    case_generate_construct->expression = expression;

    return (ast_node_t *)case_generate_construct;
}

static void _ast_case_generate_construct_print(ast_node_t *node, int indent, int indent_incr) {
    ast_case_generate_construct_t *case_generate_construct = (ast_case_generate_construct_t *)node;

    ast_node_print(case_generate_construct->case_generate_item_list, indent, indent_incr);
    ast_node_print(case_generate_construct->expression, indent, indent_incr);
}

static void _ast_case_generate_construct_free(ast_node_t *node) {
    ast_case_generate_construct_t *case_generate_construct = (ast_case_generate_construct_t *)node;

    ast_node_free(case_generate_construct->case_generate_item_list);
    ast_node_free(case_generate_construct->expression);
}
