#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_ansi_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_ansi_declaration_free(ast_node_t *node);

ast_node_t* ast_udp_ansi_declaration_new(ast_node_t *identifier, ast_node_t *udp_declaration_port_list) {
    ast_udp_ansi_declaration_t *udp_ansi_declaration = calloc(1, sizeof(*udp_ansi_declaration));

    udp_ansi_declaration->super.print = _ast_udp_ansi_declaration_print;
    udp_ansi_declaration->super.free = _ast_udp_ansi_declaration_free;

    udp_ansi_declaration->identifier = identifier;
    udp_ansi_declaration->udp_declaration_port_list = udp_declaration_port_list;

    return (ast_node_t *)udp_ansi_declaration;
}

static void _ast_udp_ansi_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_ansi_declaration_t *udp_ansi_declaration = (ast_udp_ansi_declaration_t *)node;

    ast_node_print(udp_ansi_declaration->identifier, indent, indent_incr);
    ast_node_print(udp_ansi_declaration->udp_declaration_port_list, indent, indent_incr);
}

static void _ast_udp_ansi_declaration_free(ast_node_t *node) {
    ast_udp_ansi_declaration_t *udp_ansi_declaration = (ast_udp_ansi_declaration_t *)node;

    ast_node_free(udp_ansi_declaration->identifier);
    ast_node_free(udp_ansi_declaration->udp_declaration_port_list);
}
