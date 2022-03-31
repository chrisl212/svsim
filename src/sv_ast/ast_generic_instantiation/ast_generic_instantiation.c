#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_generic_instantiation_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_generic_instantiation_free(ast_node_t *node);

ast_node_t* ast_generic_instantiation_new(ast_node_t *data, ast_node_t *in, ast_node_t *parameters, ast_node_t *type, ast_node_t *data_type, ast_node_t *hierarchical_instance_list, ast_node_t *handled) {
    ast_generic_instantiation_t *generic_instantiation = calloc(1, sizeof(*generic_instantiation));

    generic_instantiation->super.print = _ast_generic_instantiation_print;
    generic_instantiation->super.free = _ast_generic_instantiation_free;

    generic_instantiation->data = data;
    generic_instantiation->in = in;
    generic_instantiation->parameters = parameters;
    generic_instantiation->type = type;
    generic_instantiation->data_type = data_type;
    generic_instantiation->hierarchical_instance_list = hierarchical_instance_list;
    generic_instantiation->handled = handled;

    return (ast_node_t *)generic_instantiation;
}

static void _ast_generic_instantiation_print(ast_node_t *node, int indent, int indent_incr) {
    ast_generic_instantiation_t *generic_instantiation = (ast_generic_instantiation_t *)node;

    ast_node_print(generic_instantiation->data, indent, indent_incr);
    ast_node_print(generic_instantiation->in, indent, indent_incr);
    ast_node_print(generic_instantiation->parameters, indent, indent_incr);
    ast_node_print(generic_instantiation->type, indent, indent_incr);
    ast_node_print(generic_instantiation->data_type, indent, indent_incr);
    ast_node_print(generic_instantiation->hierarchical_instance_list, indent, indent_incr);
    ast_node_print(generic_instantiation->handled, indent, indent_incr);
}

static void _ast_generic_instantiation_free(ast_node_t *node) {
    ast_generic_instantiation_t *generic_instantiation = (ast_generic_instantiation_t *)node;

    ast_node_free(generic_instantiation->data);
    ast_node_free(generic_instantiation->in);
    ast_node_free(generic_instantiation->parameters);
    ast_node_free(generic_instantiation->type);
    ast_node_free(generic_instantiation->data_type);
    ast_node_free(generic_instantiation->hierarchical_instance_list);
    ast_node_free(generic_instantiation->handled);
}
