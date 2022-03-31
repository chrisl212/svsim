#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_data_type_no_identifier_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_data_type_no_identifier_free(ast_node_t *node);

ast_node_t* ast_data_type_no_identifier_new(ast_node_t *identifier1, ast_integer_atom_type_t integer_atom_type, ast_node_t *identifier, ast_signing_t signing, ast_virtual_interface_type_t virtual_interface_type, ast_node_t *parameter_value_assignment, ast_integer_vector_type_t integer_vector_type, ast_non_integer_type_t non_integer_type, ast_node_t *identifier0, ast_node_t *packed_dimension_list) {
    ast_data_type_no_identifier_t *data_type_no_identifier = calloc(1, sizeof(*data_type_no_identifier));

    data_type_no_identifier->super.print = _ast_data_type_no_identifier_print;
    data_type_no_identifier->super.free = _ast_data_type_no_identifier_free;

    data_type_no_identifier->identifier1 = identifier1;
    data_type_no_identifier->integer_atom_type = integer_atom_type;
    data_type_no_identifier->identifier = identifier;
    data_type_no_identifier->signing = signing;
    data_type_no_identifier->virtual_interface_type = virtual_interface_type;
    data_type_no_identifier->parameter_value_assignment = parameter_value_assignment;
    data_type_no_identifier->integer_vector_type = integer_vector_type;
    data_type_no_identifier->non_integer_type = non_integer_type;
    data_type_no_identifier->identifier0 = identifier0;
    data_type_no_identifier->packed_dimension_list = packed_dimension_list;

    return (ast_node_t *)data_type_no_identifier;
}

static void _ast_data_type_no_identifier_print(ast_node_t *node, int indent, int indent_incr) {
    ast_data_type_no_identifier_t *data_type_no_identifier = (ast_data_type_no_identifier_t *)node;

    ast_node_print(data_type_no_identifier->identifier1, indent, indent_incr);
    ast_integer_atom_type_print(data_type_no_identifier->integer_atom_type);
    ast_node_print(data_type_no_identifier->identifier, indent, indent_incr);
    ast_signing_print(data_type_no_identifier->signing);
    ast_virtual_interface_type_print(data_type_no_identifier->virtual_interface_type);
    ast_node_print(data_type_no_identifier->parameter_value_assignment, indent, indent_incr);
    ast_integer_vector_type_print(data_type_no_identifier->integer_vector_type);
    ast_non_integer_type_print(data_type_no_identifier->non_integer_type);
    ast_node_print(data_type_no_identifier->identifier0, indent, indent_incr);
    ast_node_print(data_type_no_identifier->packed_dimension_list, indent, indent_incr);
}

static void _ast_data_type_no_identifier_free(ast_node_t *node) {
    ast_data_type_no_identifier_t *data_type_no_identifier = (ast_data_type_no_identifier_t *)node;

    ast_node_free(data_type_no_identifier->identifier1);
    ast_node_free(data_type_no_identifier->identifier);
    ast_node_free(data_type_no_identifier->parameter_value_assignment);
    ast_node_free(data_type_no_identifier->identifier0);
    ast_node_free(data_type_no_identifier->packed_dimension_list);
}
