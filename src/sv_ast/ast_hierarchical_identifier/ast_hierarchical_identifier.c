#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_hierarchical_identifier_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_hierarchical_identifier_free(ast_node_t *node);

ast_node_t* ast_hierarchical_identifier_new(ast_node_t *identifier, ast_node_t *unpacked_dimension_list) {
    ast_hierarchical_identifier_t *hierarchical_identifier = calloc(1, sizeof(*hierarchical_identifier));

    hierarchical_identifier->super.print = _ast_hierarchical_identifier_print;
    hierarchical_identifier->super.free = _ast_hierarchical_identifier_free;

    hierarchical_identifier->identifier = identifier;
    hierarchical_identifier->unpacked_dimension_list = unpacked_dimension_list;

    return (ast_node_t *)hierarchical_identifier;
}

static void _ast_hierarchical_identifier_print(ast_node_t *node, int indent, int indent_incr) {
    ast_hierarchical_identifier_t *hierarchical_identifier = (ast_hierarchical_identifier_t *)node;

    ast_node_print(hierarchical_identifier->identifier, indent, indent_incr);
    ast_node_print(hierarchical_identifier->unpacked_dimension_list, indent, indent_incr);
}

static void _ast_hierarchical_identifier_free(ast_node_t *node) {
    ast_hierarchical_identifier_t *hierarchical_identifier = (ast_hierarchical_identifier_t *)node;

    ast_node_free(hierarchical_identifier->identifier);
    ast_node_free(hierarchical_identifier->unpacked_dimension_list);
}
