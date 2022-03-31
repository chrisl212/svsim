#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_output_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_output_declaration_free(ast_node_t *node);

ast_node_t* ast_udp_output_declaration_new(ast_node_t *identifier, ast_node_t *expression) {
    ast_udp_output_declaration_t *udp_output_declaration = calloc(1, sizeof(*udp_output_declaration));

    udp_output_declaration->super.print = _ast_udp_output_declaration_print;
    udp_output_declaration->super.free = _ast_udp_output_declaration_free;

    udp_output_declaration->identifier = identifier;
    udp_output_declaration->expression = expression;

    return (ast_node_t *)udp_output_declaration;
}

static void _ast_udp_output_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_output_declaration_t *udp_output_declaration = (ast_udp_output_declaration_t *)node;

    ast_node_print(udp_output_declaration->identifier, indent, indent_incr);
    ast_node_print(udp_output_declaration->expression, indent, indent_incr);
}

static void _ast_udp_output_declaration_free(ast_node_t *node) {
    ast_udp_output_declaration_t *udp_output_declaration = (ast_udp_output_declaration_t *)node;

    ast_node_free(udp_output_declaration->identifier);
    ast_node_free(udp_output_declaration->expression);
}
