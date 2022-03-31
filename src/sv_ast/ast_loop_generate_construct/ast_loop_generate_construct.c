#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_loop_generate_construct_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_loop_generate_construct_free(ast_node_t *node);

ast_node_t* ast_loop_generate_construct_new(ast_node_t *generate_block, ast_node_t *genvar_initialization, ast_node_t *expression, ast_node_t *genvar_iteration) {
    ast_loop_generate_construct_t *loop_generate_construct = calloc(1, sizeof(*loop_generate_construct));

    loop_generate_construct->super.print = _ast_loop_generate_construct_print;
    loop_generate_construct->super.free = _ast_loop_generate_construct_free;

    loop_generate_construct->generate_block = generate_block;
    loop_generate_construct->genvar_initialization = genvar_initialization;
    loop_generate_construct->expression = expression;
    loop_generate_construct->genvar_iteration = genvar_iteration;

    return (ast_node_t *)loop_generate_construct;
}

static void _ast_loop_generate_construct_print(ast_node_t *node, int indent, int indent_incr) {
    ast_loop_generate_construct_t *loop_generate_construct = (ast_loop_generate_construct_t *)node;

    ast_node_print(loop_generate_construct->generate_block, indent, indent_incr);
    ast_node_print(loop_generate_construct->genvar_initialization, indent, indent_incr);
    ast_node_print(loop_generate_construct->expression, indent, indent_incr);
    ast_node_print(loop_generate_construct->genvar_iteration, indent, indent_incr);
}

static void _ast_loop_generate_construct_free(ast_node_t *node) {
    ast_loop_generate_construct_t *loop_generate_construct = (ast_loop_generate_construct_t *)node;

    ast_node_free(loop_generate_construct->generate_block);
    ast_node_free(loop_generate_construct->genvar_initialization);
    ast_node_free(loop_generate_construct->expression);
    ast_node_free(loop_generate_construct->genvar_iteration);
}
