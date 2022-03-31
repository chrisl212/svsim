#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_module_ansi_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_module_ansi_header_free(ast_node_t *node);

ast_node_t* ast_module_ansi_header_new(ast_node_t *package_import_declaration_list, ast_lifetime_t lifetime, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_module_keyword_t module_keyword, ast_node_t *port_declaration_list) {
    ast_module_ansi_header_t *module_ansi_header = calloc(1, sizeof(*module_ansi_header));

    module_ansi_header->super.print = _ast_module_ansi_header_print;
    module_ansi_header->super.free = _ast_module_ansi_header_free;

    module_ansi_header->package_import_declaration_list = package_import_declaration_list;
    module_ansi_header->lifetime = lifetime;
    module_ansi_header->parameter_port_list = parameter_port_list;
    module_ansi_header->identifier = identifier;
    module_ansi_header->module_keyword = module_keyword;
    module_ansi_header->port_declaration_list = port_declaration_list;

    return (ast_node_t *)module_ansi_header;
}

static void _ast_module_ansi_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_module_ansi_header_t *module_ansi_header = (ast_module_ansi_header_t *)node;

    ast_node_print(module_ansi_header->package_import_declaration_list, indent, indent_incr);
    ast_lifetime_print(module_ansi_header->lifetime);
    ast_node_print(module_ansi_header->parameter_port_list, indent, indent_incr);
    ast_node_print(module_ansi_header->identifier, indent, indent_incr);
    ast_module_keyword_print(module_ansi_header->module_keyword);
    ast_node_print(module_ansi_header->port_declaration_list, indent, indent_incr);
}

static void _ast_module_ansi_header_free(ast_node_t *node) {
    ast_module_ansi_header_t *module_ansi_header = (ast_module_ansi_header_t *)node;

    ast_node_free(module_ansi_header->package_import_declaration_list);
    ast_node_free(module_ansi_header->parameter_port_list);
    ast_node_free(module_ansi_header->identifier);
    ast_node_free(module_ansi_header->port_declaration_list);
}
