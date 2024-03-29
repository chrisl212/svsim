#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_module_nonansi_header_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_module_nonansi_header_free(ast_node_t *node);

ast_node_t* ast_module_nonansi_header_new(ast_node_t *package_import_declaration_list, ast_lifetime_t lifetime, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_module_keyword_t module_keyword, ast_node_t *list_of_ports) {
    ast_module_nonansi_header_t *module_nonansi_header = calloc(1, sizeof(*module_nonansi_header));

    module_nonansi_header->super.print = _ast_module_nonansi_header_print;
    module_nonansi_header->super.free = _ast_module_nonansi_header_free;

    module_nonansi_header->package_import_declaration_list = package_import_declaration_list;
    module_nonansi_header->lifetime = lifetime;
    module_nonansi_header->parameter_port_list = parameter_port_list;
    module_nonansi_header->identifier = identifier;
    module_nonansi_header->module_keyword = module_keyword;
    module_nonansi_header->list_of_ports = list_of_ports;

    return (ast_node_t *)module_nonansi_header;
}

static void _ast_module_nonansi_header_print(ast_node_t *node, int indent, int indent_incr) {
    ast_module_nonansi_header_t *module_nonansi_header = (ast_module_nonansi_header_t *)node;

    printf("%s", node->indent);
    ast_module_keyword_print(module_nonansi_header->module_keyword);
    printf(" ");
    ast_lifetime_print(module_nonansi_header->lifetime);
    printf(" ");
    ast_node_print(module_nonansi_header->identifier, indent, indent_incr);
    if (module_nonansi_header->package_import_declaration_list) {
        printf("\n%s", node->next_indent);
        ast_node_list_print((ast_node_list_t *)module_nonansi_header->package_import_declaration_list, indent + indent_incr, indent_incr, "\n");
    }
    if (module_nonansi_header->parameter_port_list) {
        printf("\n%s", node->indent);
        ast_node_list_print((ast_node_list_t *)module_nonansi_header->parameter_port_list, indent + indent_incr, indent_incr, ", ");
    }
    if (module_nonansi_header->list_of_ports) {
        printf("\n%s(\n%s", node->indent, node->next_indent);
        ast_node_list_print((ast_node_list_t *)module_nonansi_header->list_of_ports, indent + indent_incr, indent_incr, ",\n");
        printf("\n%s)", node->indent);
    }
    printf(";");
}

static void _ast_module_nonansi_header_free(ast_node_t *node) {
    ast_module_nonansi_header_t *module_nonansi_header = (ast_module_nonansi_header_t *)node;

    ast_node_free(module_nonansi_header->package_import_declaration_list);
    ast_node_free(module_nonansi_header->parameter_port_list);
    ast_node_free(module_nonansi_header->identifier);
    ast_node_free(module_nonansi_header->list_of_ports);
}
