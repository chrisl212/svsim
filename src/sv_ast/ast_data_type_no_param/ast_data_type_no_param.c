#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_data_type_no_param_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_data_type_no_param_free(ast_node_t *node);

ast_node_t* ast_data_type_no_param_new(ast_node_t *packed_dimension_list, ast_node_t *ps_identifier, ast_node_t *identifier1, ast_node_t *cases, ast_integer_atom_type_t integer_atom_type, ast_node_t *identifier, ast_signing_t signing, ast_node_t *hierarchical_identifier, ast_virtual_interface_type_t virtual_interface_type, ast_integer_vector_type_t integer_vector_type, ast_node_t *select, ast_node_t *only, ast_non_integer_type_t non_integer_type, ast_node_t *identifier0, ast_node_t *valid) {
    ast_data_type_no_param_t *data_type_no_param = calloc(1, sizeof(*data_type_no_param));

    data_type_no_param->super.print = _ast_data_type_no_param_print;
    data_type_no_param->super.free = _ast_data_type_no_param_free;

    data_type_no_param->packed_dimension_list = packed_dimension_list;
    data_type_no_param->ps_identifier = ps_identifier;
    data_type_no_param->identifier1 = identifier1;
    data_type_no_param->cases = cases;
    data_type_no_param->integer_atom_type = integer_atom_type;
    data_type_no_param->identifier = identifier;
    data_type_no_param->signing = signing;
    data_type_no_param->hierarchical_identifier = hierarchical_identifier;
    data_type_no_param->virtual_interface_type = virtual_interface_type;
    data_type_no_param->integer_vector_type = integer_vector_type;
    data_type_no_param->select = select;
    data_type_no_param->only = only;
    data_type_no_param->non_integer_type = non_integer_type;
    data_type_no_param->identifier0 = identifier0;
    data_type_no_param->valid = valid;

    return (ast_node_t *)data_type_no_param;
}

static void _ast_data_type_no_param_print(ast_node_t *node, int indent, int indent_incr) {
    ast_data_type_no_param_t *data_type_no_param = (ast_data_type_no_param_t *)node;

    ast_node_print(data_type_no_param->packed_dimension_list, indent, indent_incr);
    ast_node_print(data_type_no_param->ps_identifier, indent, indent_incr);
    ast_node_print(data_type_no_param->identifier1, indent, indent_incr);
    ast_node_print(data_type_no_param->cases, indent, indent_incr);
    ast_integer_atom_type_print(data_type_no_param->integer_atom_type);
    ast_node_print(data_type_no_param->identifier, indent, indent_incr);
    ast_signing_print(data_type_no_param->signing);
    ast_node_print(data_type_no_param->hierarchical_identifier, indent, indent_incr);
    ast_virtual_interface_type_print(data_type_no_param->virtual_interface_type);
    ast_integer_vector_type_print(data_type_no_param->integer_vector_type);
    ast_node_print(data_type_no_param->select, indent, indent_incr);
    ast_node_print(data_type_no_param->only, indent, indent_incr);
    ast_non_integer_type_print(data_type_no_param->non_integer_type);
    ast_node_print(data_type_no_param->identifier0, indent, indent_incr);
    ast_node_print(data_type_no_param->valid, indent, indent_incr);
}

static void _ast_data_type_no_param_free(ast_node_t *node) {
    ast_data_type_no_param_t *data_type_no_param = (ast_data_type_no_param_t *)node;

    ast_node_free(data_type_no_param->packed_dimension_list);
    ast_node_free(data_type_no_param->ps_identifier);
    ast_node_free(data_type_no_param->identifier1);
    ast_node_free(data_type_no_param->cases);
    ast_node_free(data_type_no_param->identifier);
    ast_node_free(data_type_no_param->hierarchical_identifier);
    ast_node_free(data_type_no_param->select);
    ast_node_free(data_type_no_param->only);
    ast_node_free(data_type_no_param->identifier0);
    ast_node_free(data_type_no_param->valid);
}
