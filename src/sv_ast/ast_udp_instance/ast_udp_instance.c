#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_instance_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_instance_free(ast_node_t *node);

ast_node_t* ast_udp_instance_new(ast_node_t *output_terminal, ast_node_t *input_terminal, ast_node_t *input_terminal1, ast_node_t *name_of_instance, ast_node_t *input_terminal0) {
    ast_udp_instance_t *udp_instance = calloc(1, sizeof(*udp_instance));

    udp_instance->super.print = _ast_udp_instance_print;
    udp_instance->super.free = _ast_udp_instance_free;

    udp_instance->output_terminal = output_terminal;
    udp_instance->input_terminal = input_terminal;
    udp_instance->input_terminal1 = input_terminal1;
    udp_instance->name_of_instance = name_of_instance;
    udp_instance->input_terminal0 = input_terminal0;

    return (ast_node_t *)udp_instance;
}

static void _ast_udp_instance_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_instance_t *udp_instance = (ast_udp_instance_t *)node;

    ast_node_print(udp_instance->output_terminal, indent, indent_incr);
    ast_node_print(udp_instance->input_terminal, indent, indent_incr);
    ast_node_print(udp_instance->input_terminal1, indent, indent_incr);
    ast_node_print(udp_instance->name_of_instance, indent, indent_incr);
    ast_node_print(udp_instance->input_terminal0, indent, indent_incr);
}

static void _ast_udp_instance_free(ast_node_t *node) {
    ast_udp_instance_t *udp_instance = (ast_udp_instance_t *)node;

    ast_node_free(udp_instance->output_terminal);
    ast_node_free(udp_instance->input_terminal);
    ast_node_free(udp_instance->input_terminal1);
    ast_node_free(udp_instance->name_of_instance);
    ast_node_free(udp_instance->input_terminal0);
}
