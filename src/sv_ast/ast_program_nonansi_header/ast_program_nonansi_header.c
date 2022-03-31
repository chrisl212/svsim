#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_program_nonansi_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_program_nonansi_header_free(ast_node_t *node);

ast_node_t* ast_program_nonansi_header_new(ast_node_t *package_import_declaration_list, ast_lifetime_t lifetime, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_node_t *list_of_ports) {
    ast_program_nonansi_header_t *program_nonansi_header = calloc(1, sizeof(*program_nonansi_header));

    program_nonansi_header->super.print = _ast_program_nonansi_header_print;
    program_nonansi_header->super.free = _ast_program_nonansi_header_free;

    program_nonansi_header->package_import_declaration_list = package_import_declaration_list;
    program_nonansi_header->lifetime = lifetime;
    program_nonansi_header->parameter_port_list = parameter_port_list;
    program_nonansi_header->identifier = identifier;
    program_nonansi_header->list_of_ports = list_of_ports;

    return (ast_node_t *)program_nonansi_header;
}

static void _ast_program_nonansi_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_program_nonansi_header_t *program_nonansi_header = (ast_program_nonansi_header_t *)node;

    ast_node_print(program_nonansi_header->package_import_declaration_list, indent, indent_incr);
    ast_lifetime_print(program_nonansi_header->lifetime);
    ast_node_print(program_nonansi_header->parameter_port_list, indent, indent_incr);
    ast_node_print(program_nonansi_header->identifier, indent, indent_incr);
    ast_node_print(program_nonansi_header->list_of_ports, indent, indent_incr);
}

static void _ast_program_nonansi_header_free(ast_node_t *node) {
    ast_program_nonansi_header_t *program_nonansi_header = (ast_program_nonansi_header_t *)node;

    ast_node_free(program_nonansi_header->package_import_declaration_list);
    ast_node_free(program_nonansi_header->parameter_port_list);
    ast_node_free(program_nonansi_header->identifier);
    ast_node_free(program_nonansi_header->list_of_ports);
}
