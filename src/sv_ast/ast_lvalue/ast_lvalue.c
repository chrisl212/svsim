#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_lvalue_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_lvalue_free(ast_node_t *node);

ast_node_t* ast_lvalue_new(ast_node_t *streaming_concatenation, ast_node_t *hierarchical_identifier, ast_node_t *concatenation, ast_node_t *lvlaues) {
    ast_lvalue_t *lvalue = calloc(1, sizeof(*lvalue));

    lvalue->super.print = _ast_lvalue_print;
    lvalue->super.free = _ast_lvalue_free;

    lvalue->streaming_concatenation = streaming_concatenation;
    lvalue->hierarchical_identifier = hierarchical_identifier;
    lvalue->concatenation = concatenation;
    lvalue->lvlaues = lvlaues;

    return (ast_node_t *)lvalue;
}

static void _ast_lvalue_print(ast_node_t *node, int indent, int indent_incr) {
    ast_lvalue_t *lvalue = (ast_lvalue_t *)node;

    ast_node_print(lvalue->streaming_concatenation, indent, indent_incr);
    ast_node_print(lvalue->hierarchical_identifier, indent, indent_incr);
    ast_node_print(lvalue->concatenation, indent, indent_incr);
    ast_node_print(lvalue->lvlaues, indent, indent_incr);
}

static void _ast_lvalue_free(ast_node_t *node) {
    ast_lvalue_t *lvalue = (ast_lvalue_t *)node;

    ast_node_free(lvalue->streaming_concatenation);
    ast_node_free(lvalue->hierarchical_identifier);
    ast_node_free(lvalue->concatenation);
    ast_node_free(lvalue->lvlaues);
}
