#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_mintypmax_expression_list_2_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_mintypmax_expression_list_2_free(ast_node_t *node);

ast_node_t* ast_mintypmax_expression_list_2_new(ast_node_t *mintypmax_expression, ast_node_t *mintypmax_expression0, ast_node_t *mintypmax_expression1) {
    ast_mintypmax_expression_list_2_t *mintypmax_expression_list_2 = calloc(1, sizeof(*mintypmax_expression_list_2));

    mintypmax_expression_list_2->super.print = _ast_mintypmax_expression_list_2_print;
    mintypmax_expression_list_2->super.free = _ast_mintypmax_expression_list_2_free;

    mintypmax_expression_list_2->mintypmax_expression = mintypmax_expression;
    mintypmax_expression_list_2->mintypmax_expression0 = mintypmax_expression0;
    mintypmax_expression_list_2->mintypmax_expression1 = mintypmax_expression1;

    return (ast_node_t *)mintypmax_expression_list_2;
}

static void _ast_mintypmax_expression_list_2_print(ast_node_t *node, int indent, int indent_incr) {
    ast_mintypmax_expression_list_2_t *mintypmax_expression_list_2 = (ast_mintypmax_expression_list_2_t *)node;

    ast_node_print(mintypmax_expression_list_2->mintypmax_expression, indent, indent_incr);
    ast_node_print(mintypmax_expression_list_2->mintypmax_expression0, indent, indent_incr);
    ast_node_print(mintypmax_expression_list_2->mintypmax_expression1, indent, indent_incr);
}

static void _ast_mintypmax_expression_list_2_free(ast_node_t *node) {
    ast_mintypmax_expression_list_2_t *mintypmax_expression_list_2 = (ast_mintypmax_expression_list_2_t *)node;

    ast_node_free(mintypmax_expression_list_2->mintypmax_expression);
    ast_node_free(mintypmax_expression_list_2->mintypmax_expression0);
    ast_node_free(mintypmax_expression_list_2->mintypmax_expression1);
}
