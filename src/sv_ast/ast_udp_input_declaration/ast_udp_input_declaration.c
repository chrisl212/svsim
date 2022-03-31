#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_input_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_input_declaration_free(ast_node_t *node);

ast_node_t* ast_udp_input_declaration_new(ast_node_t *identifier_list, ast_node_t *identifier) {
    ast_udp_input_declaration_t *udp_input_declaration = calloc(1, sizeof(*udp_input_declaration));

    udp_input_declaration->super.print = _ast_udp_input_declaration_print;
    udp_input_declaration->super.free = _ast_udp_input_declaration_free;

    udp_input_declaration->identifier_list = identifier_list;
    udp_input_declaration->identifier = identifier;

    return (ast_node_t *)udp_input_declaration;
}

static void _ast_udp_input_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_input_declaration_t *udp_input_declaration = (ast_udp_input_declaration_t *)node;

    ast_node_print(udp_input_declaration->identifier_list, indent, indent_incr);
    ast_node_print(udp_input_declaration->identifier, indent, indent_incr);
}

static void _ast_udp_input_declaration_free(ast_node_t *node) {
    ast_udp_input_declaration_t *udp_input_declaration = (ast_udp_input_declaration_t *)node;

    ast_node_free(udp_input_declaration->identifier_list);
    ast_node_free(udp_input_declaration->identifier);
}
