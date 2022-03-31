#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_if_generate_construct_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_if_generate_construct_free(ast_node_t *node);

ast_node_t* ast_if_generate_construct_new(ast_node_t *generate_block0, ast_node_t *expression, ast_node_t *generate_block, ast_node_t *generate_block1) {
    ast_if_generate_construct_t *if_generate_construct = calloc(1, sizeof(*if_generate_construct));

    if_generate_construct->super.print = _ast_if_generate_construct_print;
    if_generate_construct->super.free = _ast_if_generate_construct_free;

    if_generate_construct->generate_block0 = generate_block0;
    if_generate_construct->expression = expression;
    if_generate_construct->generate_block = generate_block;
    if_generate_construct->generate_block1 = generate_block1;

    return (ast_node_t *)if_generate_construct;
}

static void _ast_if_generate_construct_print(ast_node_t *node, int indent, int indent_incr) {
    ast_if_generate_construct_t *if_generate_construct = (ast_if_generate_construct_t *)node;

    ast_node_print(if_generate_construct->generate_block0, indent, indent_incr);
    ast_node_print(if_generate_construct->expression, indent, indent_incr);
    ast_node_print(if_generate_construct->generate_block, indent, indent_incr);
    ast_node_print(if_generate_construct->generate_block1, indent, indent_incr);
}

static void _ast_if_generate_construct_free(ast_node_t *node) {
    ast_if_generate_construct_t *if_generate_construct = (ast_if_generate_construct_t *)node;

    ast_node_free(if_generate_construct->generate_block0);
    ast_node_free(if_generate_construct->expression);
    ast_node_free(if_generate_construct->generate_block);
    ast_node_free(if_generate_construct->generate_block1);
}
