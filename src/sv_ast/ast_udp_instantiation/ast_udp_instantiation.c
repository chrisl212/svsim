#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_udp_instantiation_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_udp_instantiation_free(ast_node_t *node);

ast_node_t* ast_udp_instantiation_new(ast_node_t *identifier, ast_node_t *delay2, ast_node_t *drive_strength, ast_node_t *udp_instance_list) {
    ast_udp_instantiation_t *udp_instantiation = calloc(1, sizeof(*udp_instantiation));

    udp_instantiation->super.print = _ast_udp_instantiation_print;
    udp_instantiation->super.free = _ast_udp_instantiation_free;

    udp_instantiation->identifier = identifier;
    udp_instantiation->delay2 = delay2;
    udp_instantiation->drive_strength = drive_strength;
    udp_instantiation->udp_instance_list = udp_instance_list;

    return (ast_node_t *)udp_instantiation;
}

static void _ast_udp_instantiation_print(ast_node_t *node, int indent, int indent_incr) {
    ast_udp_instantiation_t *udp_instantiation = (ast_udp_instantiation_t *)node;

    ast_node_print(udp_instantiation->identifier, indent, indent_incr);
    ast_node_print(udp_instantiation->delay2, indent, indent_incr);
    ast_node_print(udp_instantiation->drive_strength, indent, indent_incr);
    ast_node_print(udp_instantiation->udp_instance_list, indent, indent_incr);
}

static void _ast_udp_instantiation_free(ast_node_t *node) {
    ast_udp_instantiation_t *udp_instantiation = (ast_udp_instantiation_t *)node;

    ast_node_free(udp_instantiation->identifier);
    ast_node_free(udp_instantiation->delay2);
    ast_node_free(udp_instantiation->drive_strength);
    ast_node_free(udp_instantiation->udp_instance_list);
}
