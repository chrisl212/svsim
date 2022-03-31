#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_declaration_free(ast_node_t *node);

ast_node_t* ast_udp_declaration_new(ast_node_t *udp_ansi_declaration, ast_node_t *udp_nonansi_declaration, ast_node_t *udp_body, ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *udp_port_declaration_list) {
    ast_udp_declaration_t *udp_declaration = calloc(1, sizeof(*udp_declaration));

    udp_declaration->super.print = _ast_udp_declaration_print;
    udp_declaration->super.free = _ast_udp_declaration_free;

    udp_declaration->udp_ansi_declaration = udp_ansi_declaration;
    udp_declaration->udp_nonansi_declaration = udp_nonansi_declaration;
    udp_declaration->udp_body = udp_body;
    udp_declaration->identifier = identifier;
    udp_declaration->block_end_identifier = block_end_identifier;
    udp_declaration->udp_port_declaration_list = udp_port_declaration_list;

    return (ast_node_t *)udp_declaration;
}

static void _ast_udp_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_declaration_t *udp_declaration = (ast_udp_declaration_t *)node;

    ast_node_print(udp_declaration->udp_ansi_declaration, indent, indent_incr);
    ast_node_print(udp_declaration->udp_nonansi_declaration, indent, indent_incr);
    ast_node_print(udp_declaration->udp_body, indent, indent_incr);
    ast_node_print(udp_declaration->identifier, indent, indent_incr);
    ast_node_print(udp_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(udp_declaration->udp_port_declaration_list, indent, indent_incr);
}

static void _ast_udp_declaration_free(ast_node_t *node) {
    ast_udp_declaration_t *udp_declaration = (ast_udp_declaration_t *)node;

    ast_node_free(udp_declaration->udp_ansi_declaration);
    ast_node_free(udp_declaration->udp_nonansi_declaration);
    ast_node_free(udp_declaration->udp_body);
    ast_node_free(udp_declaration->identifier);
    ast_node_free(udp_declaration->block_end_identifier);
    ast_node_free(udp_declaration->udp_port_declaration_list);
}
