#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_interface_class_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_interface_class_declaration_free(ast_node_t *node);

ast_node_t* ast_interface_class_declaration_new(ast_node_t *ps_or_normal_identifier, ast_node_t *interface_class_type_list, ast_node_t *interface_class_parameters, ast_node_t *block_end_identifier, ast_node_t *interface_class_item_list) {
    ast_interface_class_declaration_t *interface_class_declaration = calloc(1, sizeof(*interface_class_declaration));

    interface_class_declaration->super.print = _ast_interface_class_declaration_print;
    interface_class_declaration->super.free = _ast_interface_class_declaration_free;

    interface_class_declaration->ps_or_normal_identifier = ps_or_normal_identifier;
    interface_class_declaration->interface_class_type_list = interface_class_type_list;
    interface_class_declaration->interface_class_parameters = interface_class_parameters;
    interface_class_declaration->block_end_identifier = block_end_identifier;
    interface_class_declaration->interface_class_item_list = interface_class_item_list;

    return (ast_node_t *)interface_class_declaration;
}

static void _ast_interface_class_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_interface_class_declaration_t *interface_class_declaration = (ast_interface_class_declaration_t *)node;

    ast_node_print(interface_class_declaration->ps_or_normal_identifier, indent, indent_incr);
    ast_node_print(interface_class_declaration->interface_class_type_list, indent, indent_incr);
    ast_node_print(interface_class_declaration->interface_class_parameters, indent, indent_incr);
    ast_node_print(interface_class_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(interface_class_declaration->interface_class_item_list, indent, indent_incr);
}

static void _ast_interface_class_declaration_free(ast_node_t *node) {
    ast_interface_class_declaration_t *interface_class_declaration = (ast_interface_class_declaration_t *)node;

    ast_node_free(interface_class_declaration->ps_or_normal_identifier);
    ast_node_free(interface_class_declaration->interface_class_type_list);
    ast_node_free(interface_class_declaration->interface_class_parameters);
    ast_node_free(interface_class_declaration->block_end_identifier);
    ast_node_free(interface_class_declaration->interface_class_item_list);
}
