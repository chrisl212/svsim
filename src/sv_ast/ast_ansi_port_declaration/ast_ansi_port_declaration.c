#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_ansi_port_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_ansi_port_declaration_free(ast_node_t *node);

ast_node_t* ast_ansi_port_declaration_new(ast_node_t *variable_dimension_list, ast_node_t *identifier, ast_node_t *expression, ast_node_t *net_port_header, ast_node_t *variable_port_header, ast_node_t *unpacked_dimension_list, ast_port_direction_t port_direction) {
    ast_ansi_port_declaration_t *ansi_port_declaration = calloc(1, sizeof(*ansi_port_declaration));

    ansi_port_declaration->super.print = _ast_ansi_port_declaration_print;
    ansi_port_declaration->super.free = _ast_ansi_port_declaration_free;

    ansi_port_declaration->variable_dimension_list = variable_dimension_list;
    ansi_port_declaration->identifier = identifier;
    ansi_port_declaration->expression = expression;
    ansi_port_declaration->net_port_header = net_port_header;
    ansi_port_declaration->variable_port_header = variable_port_header;
    ansi_port_declaration->unpacked_dimension_list = unpacked_dimension_list;
    ansi_port_declaration->port_direction = port_direction;

    return (ast_node_t *)ansi_port_declaration;
}

static void _ast_ansi_port_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_ansi_port_declaration_t *ansi_port_declaration = (ast_ansi_port_declaration_t *)node;

    ast_node_print(ansi_port_declaration->variable_dimension_list, indent, indent_incr);
    ast_node_print(ansi_port_declaration->identifier, indent, indent_incr);
    ast_node_print(ansi_port_declaration->expression, indent, indent_incr);
    ast_node_print(ansi_port_declaration->net_port_header, indent, indent_incr);
    ast_node_print(ansi_port_declaration->variable_port_header, indent, indent_incr);
    ast_node_print(ansi_port_declaration->unpacked_dimension_list, indent, indent_incr);
    ast_port_direction_print(ansi_port_declaration->port_direction);
}

static void _ast_ansi_port_declaration_free(ast_node_t *node) {
    ast_ansi_port_declaration_t *ansi_port_declaration = (ast_ansi_port_declaration_t *)node;

    ast_node_free(ansi_port_declaration->variable_dimension_list);
    ast_node_free(ansi_port_declaration->identifier);
    ast_node_free(ansi_port_declaration->expression);
    ast_node_free(ansi_port_declaration->net_port_header);
    ast_node_free(ansi_port_declaration->variable_port_header);
    ast_node_free(ansi_port_declaration->unpacked_dimension_list);
}
