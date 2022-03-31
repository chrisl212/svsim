#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_input_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_input_declaration_free(ast_node_t *node);

ast_node_t* ast_input_declaration_new(ast_node_t *net_port_type, ast_node_t *variable_identifier_list, ast_node_t *port_identifier_list, ast_node_t *variable_port_type) {
    ast_input_declaration_t *input_declaration = calloc(1, sizeof(*input_declaration));

    input_declaration->super.print = _ast_input_declaration_print;
    input_declaration->super.free = _ast_input_declaration_free;

    input_declaration->net_port_type = net_port_type;
    input_declaration->variable_identifier_list = variable_identifier_list;
    input_declaration->port_identifier_list = port_identifier_list;
    input_declaration->variable_port_type = variable_port_type;

    return (ast_node_t *)input_declaration;
}

static void _ast_input_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_input_declaration_t *input_declaration = (ast_input_declaration_t *)node;

    ast_node_print(input_declaration->net_port_type, indent, indent_incr);
    ast_node_print(input_declaration->variable_identifier_list, indent, indent_incr);
    ast_node_print(input_declaration->port_identifier_list, indent, indent_incr);
    ast_node_print(input_declaration->variable_port_type, indent, indent_incr);
}

static void _ast_input_declaration_free(ast_node_t *node) {
    ast_input_declaration_t *input_declaration = (ast_input_declaration_t *)node;

    ast_node_free(input_declaration->net_port_type);
    ast_node_free(input_declaration->variable_identifier_list);
    ast_node_free(input_declaration->port_identifier_list);
    ast_node_free(input_declaration->variable_port_type);
}
