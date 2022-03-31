#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_class_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_class_declaration_free(ast_node_t *node);

ast_node_t* ast_class_declaration_new(ast_lifetime_t lifetime, ast_node_t *implements_interface, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *virtual, ast_node_t *class_item_list, ast_node_t *extends_class) {
    ast_class_declaration_t *class_declaration = calloc(1, sizeof(*class_declaration));

    class_declaration->super.print = _ast_class_declaration_print;
    class_declaration->super.free = _ast_class_declaration_free;

    class_declaration->lifetime = lifetime;
    class_declaration->implements_interface = implements_interface;
    class_declaration->parameter_port_list = parameter_port_list;
    class_declaration->identifier = identifier;
    class_declaration->block_end_identifier = block_end_identifier;
    class_declaration->virtual = virtual;
    class_declaration->class_item_list = class_item_list;
    class_declaration->extends_class = extends_class;

    return (ast_node_t *)class_declaration;
}

static void _ast_class_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_class_declaration_t *class_declaration = (ast_class_declaration_t *)node;

    ast_lifetime_print(class_declaration->lifetime);
    ast_node_print(class_declaration->implements_interface, indent, indent_incr);
    ast_node_print(class_declaration->parameter_port_list, indent, indent_incr);
    ast_node_print(class_declaration->identifier, indent, indent_incr);
    ast_node_print(class_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(class_declaration->virtual, indent, indent_incr);
    ast_node_print(class_declaration->class_item_list, indent, indent_incr);
    ast_node_print(class_declaration->extends_class, indent, indent_incr);
}

static void _ast_class_declaration_free(ast_node_t *node) {
    ast_class_declaration_t *class_declaration = (ast_class_declaration_t *)node;

    ast_node_free(class_declaration->implements_interface);
    ast_node_free(class_declaration->parameter_port_list);
    ast_node_free(class_declaration->identifier);
    ast_node_free(class_declaration->block_end_identifier);
    ast_node_free(class_declaration->virtual);
    ast_node_free(class_declaration->class_item_list);
    ast_node_free(class_declaration->extends_class);
}
