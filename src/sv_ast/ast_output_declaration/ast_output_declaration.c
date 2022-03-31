#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_output_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_output_declaration_free(ast_node_t *node);

ast_node_t* ast_output_declaration_new(ast_node_t *net_port_type, ast_node_t *variable_identifier_list, ast_node_t *port_identifier_list, ast_node_t *variable_port_type) {
    ast_output_declaration_t *output_declaration = calloc(1, sizeof(*output_declaration));

    output_declaration->super.print = _ast_output_declaration_print;
    output_declaration->super.free = _ast_output_declaration_free;

    output_declaration->net_port_type = net_port_type;
    output_declaration->variable_identifier_list = variable_identifier_list;
    output_declaration->port_identifier_list = port_identifier_list;
    output_declaration->variable_port_type = variable_port_type;

    return (ast_node_t *)output_declaration;
}

static void _ast_output_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_output_declaration_t *output_declaration = (ast_output_declaration_t *)node;

    ast_node_print(output_declaration->net_port_type, indent, indent_incr);
    ast_node_print(output_declaration->variable_identifier_list, indent, indent_incr);
    ast_node_print(output_declaration->port_identifier_list, indent, indent_incr);
    ast_node_print(output_declaration->variable_port_type, indent, indent_incr);
}

static void _ast_output_declaration_free(ast_node_t *node) {
    ast_output_declaration_t *output_declaration = (ast_output_declaration_t *)node;

    ast_node_free(output_declaration->net_port_type);
    ast_node_free(output_declaration->variable_identifier_list);
    ast_node_free(output_declaration->port_identifier_list);
    ast_node_free(output_declaration->variable_port_type);
}
