#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_name_of_instance_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_name_of_instance_free(ast_node_t *node);

ast_node_t* ast_name_of_instance_new(ast_node_t *identifier, ast_node_t *unpacked_dimension_list) {
    ast_name_of_instance_t *name_of_instance = calloc(1, sizeof(*name_of_instance));

    name_of_instance->super.print = _ast_name_of_instance_print;
    name_of_instance->super.free = _ast_name_of_instance_free;

    name_of_instance->identifier = identifier;
    name_of_instance->unpacked_dimension_list = unpacked_dimension_list;

    return (ast_node_t *)name_of_instance;
}

static void _ast_name_of_instance_print(ast_node_t *node, int indent, int indent_incr) {
    ast_name_of_instance_t *name_of_instance = (ast_name_of_instance_t *)node;

    ast_node_print(name_of_instance->identifier, indent, indent_incr);
    ast_node_print(name_of_instance->unpacked_dimension_list, indent, indent_incr);
}

static void _ast_name_of_instance_free(ast_node_t *node) {
    ast_name_of_instance_t *name_of_instance = (ast_name_of_instance_t *)node;

    ast_node_free(name_of_instance->identifier);
    ast_node_free(name_of_instance->unpacked_dimension_list);
}
