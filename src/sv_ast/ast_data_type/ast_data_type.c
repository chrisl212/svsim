#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_data_type_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_data_type_free(ast_node_t *node);

ast_node_t* ast_data_type_new(ast_node_t *packed_dimension_list, ast_node_t *ps_identifier, ast_node_t *cases, ast_node_t *identifier, ast_node_t *hierarchical_identifier, ast_node_t *data_type_no_identifier, ast_node_t *parameter_value_assignment, ast_node_t *select, ast_node_t *only, ast_node_t *valid) {
    ast_data_type_t *data_type = calloc(1, sizeof(*data_type));

    data_type->super.print = _ast_data_type_print;
    data_type->super.free = _ast_data_type_free;

    data_type->packed_dimension_list = packed_dimension_list;
    data_type->ps_identifier = ps_identifier;
    data_type->cases = cases;
    data_type->identifier = identifier;
    data_type->hierarchical_identifier = hierarchical_identifier;
    data_type->data_type_no_identifier = data_type_no_identifier;
    data_type->parameter_value_assignment = parameter_value_assignment;
    data_type->select = select;
    data_type->only = only;
    data_type->valid = valid;

    return (ast_node_t *)data_type;
}

static void _ast_data_type_print(ast_node_t *node, int indent, int indent_incr) {
    ast_data_type_t *data_type = (ast_data_type_t *)node;

    ast_node_print(data_type->packed_dimension_list, indent, indent_incr);
    ast_node_print(data_type->ps_identifier, indent, indent_incr);
    ast_node_print(data_type->cases, indent, indent_incr);
    ast_node_print(data_type->identifier, indent, indent_incr);
    ast_node_print(data_type->hierarchical_identifier, indent, indent_incr);
    ast_node_print(data_type->data_type_no_identifier, indent, indent_incr);
    ast_node_print(data_type->parameter_value_assignment, indent, indent_incr);
    ast_node_print(data_type->select, indent, indent_incr);
    ast_node_print(data_type->only, indent, indent_incr);
    ast_node_print(data_type->valid, indent, indent_incr);
}

static void _ast_data_type_free(ast_node_t *node) {
    ast_data_type_t *data_type = (ast_data_type_t *)node;

    ast_node_free(data_type->packed_dimension_list);
    ast_node_free(data_type->ps_identifier);
    ast_node_free(data_type->cases);
    ast_node_free(data_type->identifier);
    ast_node_free(data_type->hierarchical_identifier);
    ast_node_free(data_type->data_type_no_identifier);
    ast_node_free(data_type->parameter_value_assignment);
    ast_node_free(data_type->select);
    ast_node_free(data_type->only);
    ast_node_free(data_type->valid);
}
