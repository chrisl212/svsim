#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_inout_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_inout_declaration_free(ast_node_t *node);

ast_node_t* ast_inout_declaration_new(ast_node_t *net_port_type, ast_node_t *port_identifier_list) {
    ast_inout_declaration_t *inout_declaration = calloc(1, sizeof(*inout_declaration));

    inout_declaration->super.print = _ast_inout_declaration_print;
    inout_declaration->super.free = _ast_inout_declaration_free;

    inout_declaration->net_port_type = net_port_type;
    inout_declaration->port_identifier_list = port_identifier_list;

    return (ast_node_t *)inout_declaration;
}

static void _ast_inout_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_inout_declaration_t *inout_declaration = (ast_inout_declaration_t *)node;

    ast_node_print(inout_declaration->net_port_type, indent, indent_incr);
    ast_node_print(inout_declaration->port_identifier_list, indent, indent_incr);
}

static void _ast_inout_declaration_free(ast_node_t *node) {
    ast_inout_declaration_t *inout_declaration = (ast_inout_declaration_t *)node;

    ast_node_free(inout_declaration->net_port_type);
    ast_node_free(inout_declaration->port_identifier_list);
}
