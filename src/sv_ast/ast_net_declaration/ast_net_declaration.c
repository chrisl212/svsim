#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_net_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_net_declaration_free(ast_node_t *node);

ast_node_t* ast_net_declaration_new(ast_node_t *identifier_unpacked_dimension_list, ast_net_type_t net_type, ast_node_t *vectored_or_scalared, ast_node_t *identifier, ast_node_t *delay3, ast_node_t *variable_decl_assignment_list, ast_node_t *drive_or_charge_strength, ast_signing_t signing, ast_node_t *delay_value, ast_node_t *delay_control, ast_node_t *data_type_no_param, ast_node_t *packed_dimension_list) {
    ast_net_declaration_t *net_declaration = calloc(1, sizeof(*net_declaration));

    net_declaration->super.print = _ast_net_declaration_print;
    net_declaration->super.free = _ast_net_declaration_free;

    net_declaration->identifier_unpacked_dimension_list = identifier_unpacked_dimension_list;
    net_declaration->net_type = net_type;
    net_declaration->vectored_or_scalared = vectored_or_scalared;
    net_declaration->identifier = identifier;
    net_declaration->delay3 = delay3;
    net_declaration->variable_decl_assignment_list = variable_decl_assignment_list;
    net_declaration->drive_or_charge_strength = drive_or_charge_strength;
    net_declaration->signing = signing;
    net_declaration->delay_value = delay_value;
    net_declaration->delay_control = delay_control;
    net_declaration->data_type_no_param = data_type_no_param;
    net_declaration->packed_dimension_list = packed_dimension_list;

    return (ast_node_t *)net_declaration;
}

static void _ast_net_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_net_declaration_t *net_declaration = (ast_net_declaration_t *)node;

    ast_node_print(net_declaration->identifier_unpacked_dimension_list, indent, indent_incr);
    ast_net_type_print(net_declaration->net_type);
    ast_node_print(net_declaration->vectored_or_scalared, indent, indent_incr);
    ast_node_print(net_declaration->identifier, indent, indent_incr);
    ast_node_print(net_declaration->delay3, indent, indent_incr);
    ast_node_print(net_declaration->variable_decl_assignment_list, indent, indent_incr);
    ast_node_print(net_declaration->drive_or_charge_strength, indent, indent_incr);
    ast_signing_print(net_declaration->signing);
    ast_node_print(net_declaration->delay_value, indent, indent_incr);
    ast_node_print(net_declaration->delay_control, indent, indent_incr);
    ast_node_print(net_declaration->data_type_no_param, indent, indent_incr);
    ast_node_print(net_declaration->packed_dimension_list, indent, indent_incr);
}

static void _ast_net_declaration_free(ast_node_t *node) {
    ast_net_declaration_t *net_declaration = (ast_net_declaration_t *)node;

    ast_node_free(net_declaration->identifier_unpacked_dimension_list);
    ast_node_free(net_declaration->vectored_or_scalared);
    ast_node_free(net_declaration->identifier);
    ast_node_free(net_declaration->delay3);
    ast_node_free(net_declaration->variable_decl_assignment_list);
    ast_node_free(net_declaration->drive_or_charge_strength);
    ast_node_free(net_declaration->delay_value);
    ast_node_free(net_declaration->delay_control);
    ast_node_free(net_declaration->data_type_no_param);
    ast_node_free(net_declaration->packed_dimension_list);
}
