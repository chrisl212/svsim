#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_interface_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_interface_declaration_free(ast_node_t *node);

ast_node_t* ast_interface_declaration_new(ast_node_t *interface_item_list, ast_node_t *interface_ansi_header, ast_node_t *non_port_interface_item_list, ast_node_t *interface_non_ansi_header, ast_node_t *block_end_identifier) {
    ast_interface_declaration_t *interface_declaration = calloc(1, sizeof(*interface_declaration));

    interface_declaration->super.print = _ast_interface_declaration_print;
    interface_declaration->super.free = _ast_interface_declaration_free;

    interface_declaration->interface_item_list = interface_item_list;
    interface_declaration->interface_ansi_header = interface_ansi_header;
    interface_declaration->non_port_interface_item_list = non_port_interface_item_list;
    interface_declaration->interface_non_ansi_header = interface_non_ansi_header;
    interface_declaration->block_end_identifier = block_end_identifier;

    return (ast_node_t *)interface_declaration;
}

static void _ast_interface_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_interface_declaration_t *interface_declaration = (ast_interface_declaration_t *)node;

    ast_node_print(interface_declaration->interface_item_list, indent, indent_incr);
    ast_node_print(interface_declaration->interface_ansi_header, indent, indent_incr);
    ast_node_print(interface_declaration->non_port_interface_item_list, indent, indent_incr);
    ast_node_print(interface_declaration->interface_non_ansi_header, indent, indent_incr);
    ast_node_print(interface_declaration->block_end_identifier, indent, indent_incr);
}

static void _ast_interface_declaration_free(ast_node_t *node) {
    ast_interface_declaration_t *interface_declaration = (ast_interface_declaration_t *)node;

    ast_node_free(interface_declaration->interface_item_list);
    ast_node_free(interface_declaration->interface_ansi_header);
    ast_node_free(interface_declaration->non_port_interface_item_list);
    ast_node_free(interface_declaration->interface_non_ansi_header);
    ast_node_free(interface_declaration->block_end_identifier);
}
