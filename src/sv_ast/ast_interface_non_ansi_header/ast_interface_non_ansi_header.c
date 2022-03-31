#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_interface_non_ansi_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_interface_non_ansi_header_free(ast_node_t *node);

ast_node_t* ast_interface_non_ansi_header_new(ast_node_t *package_import_declaration_list, ast_lifetime_t lifetime, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_node_t *list_of_ports) {
    ast_interface_non_ansi_header_t *interface_non_ansi_header = calloc(1, sizeof(*interface_non_ansi_header));

    interface_non_ansi_header->super.print = _ast_interface_non_ansi_header_print;
    interface_non_ansi_header->super.free = _ast_interface_non_ansi_header_free;

    interface_non_ansi_header->package_import_declaration_list = package_import_declaration_list;
    interface_non_ansi_header->lifetime = lifetime;
    interface_non_ansi_header->parameter_port_list = parameter_port_list;
    interface_non_ansi_header->identifier = identifier;
    interface_non_ansi_header->list_of_ports = list_of_ports;

    return (ast_node_t *)interface_non_ansi_header;
}

static void _ast_interface_non_ansi_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_interface_non_ansi_header_t *interface_non_ansi_header = (ast_interface_non_ansi_header_t *)node;

    ast_node_print(interface_non_ansi_header->package_import_declaration_list, indent, indent_incr);
    ast_lifetime_print(interface_non_ansi_header->lifetime);
    ast_node_print(interface_non_ansi_header->parameter_port_list, indent, indent_incr);
    ast_node_print(interface_non_ansi_header->identifier, indent, indent_incr);
    ast_node_print(interface_non_ansi_header->list_of_ports, indent, indent_incr);
}

static void _ast_interface_non_ansi_header_free(ast_node_t *node) {
    ast_interface_non_ansi_header_t *interface_non_ansi_header = (ast_interface_non_ansi_header_t *)node;

    ast_node_free(interface_non_ansi_header->package_import_declaration_list);
    ast_node_free(interface_non_ansi_header->parameter_port_list);
    ast_node_free(interface_non_ansi_header->identifier);
    ast_node_free(interface_non_ansi_header->list_of_ports);
}
