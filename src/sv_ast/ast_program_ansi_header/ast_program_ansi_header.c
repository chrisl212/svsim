#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_program_ansi_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_program_ansi_header_free(ast_node_t *node);

ast_node_t* ast_program_ansi_header_new(ast_node_t *package_import_declaration_list, ast_lifetime_t lifetime, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_node_t *port_declaration_list) {
    ast_program_ansi_header_t *program_ansi_header = calloc(1, sizeof(*program_ansi_header));

    program_ansi_header->super.print = _ast_program_ansi_header_print;
    program_ansi_header->super.free = _ast_program_ansi_header_free;

    program_ansi_header->package_import_declaration_list = package_import_declaration_list;
    program_ansi_header->lifetime = lifetime;
    program_ansi_header->parameter_port_list = parameter_port_list;
    program_ansi_header->identifier = identifier;
    program_ansi_header->port_declaration_list = port_declaration_list;

    return (ast_node_t *)program_ansi_header;
}

static void _ast_program_ansi_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_program_ansi_header_t *program_ansi_header = (ast_program_ansi_header_t *)node;

    ast_node_print(program_ansi_header->package_import_declaration_list, indent, indent_incr);
    ast_lifetime_print(program_ansi_header->lifetime);
    ast_node_print(program_ansi_header->parameter_port_list, indent, indent_incr);
    ast_node_print(program_ansi_header->identifier, indent, indent_incr);
    ast_node_print(program_ansi_header->port_declaration_list, indent, indent_incr);
}

static void _ast_program_ansi_header_free(ast_node_t *node) {
    ast_program_ansi_header_t *program_ansi_header = (ast_program_ansi_header_t *)node;

    ast_node_free(program_ansi_header->package_import_declaration_list);
    ast_node_free(program_ansi_header->parameter_port_list);
    ast_node_free(program_ansi_header->identifier);
    ast_node_free(program_ansi_header->port_declaration_list);
}
