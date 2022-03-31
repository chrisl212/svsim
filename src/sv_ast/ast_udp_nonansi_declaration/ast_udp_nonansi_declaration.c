#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_nonansi_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_nonansi_declaration_free(ast_node_t *node);

ast_node_t* ast_udp_nonansi_declaration_new(ast_node_t *identifier, ast_node_t *udp_port_list) {
    ast_udp_nonansi_declaration_t *udp_nonansi_declaration = calloc(1, sizeof(*udp_nonansi_declaration));

    udp_nonansi_declaration->super.print = _ast_udp_nonansi_declaration_print;
    udp_nonansi_declaration->super.free = _ast_udp_nonansi_declaration_free;

    udp_nonansi_declaration->identifier = identifier;
    udp_nonansi_declaration->udp_port_list = udp_port_list;

    return (ast_node_t *)udp_nonansi_declaration;
}

static void _ast_udp_nonansi_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_nonansi_declaration_t *udp_nonansi_declaration = (ast_udp_nonansi_declaration_t *)node;

    ast_node_print(udp_nonansi_declaration->identifier, indent, indent_incr);
    ast_node_print(udp_nonansi_declaration->udp_port_list, indent, indent_incr);
}

static void _ast_udp_nonansi_declaration_free(ast_node_t *node) {
    ast_udp_nonansi_declaration_t *udp_nonansi_declaration = (ast_udp_nonansi_declaration_t *)node;

    ast_node_free(udp_nonansi_declaration->identifier);
    ast_node_free(udp_nonansi_declaration->udp_port_list);
}
