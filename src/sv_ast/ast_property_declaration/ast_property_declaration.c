#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_property_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_property_declaration_free(ast_node_t *node);

ast_node_t* ast_property_declaration_new(ast_node_t *identifier, ast_node_t *property_port_list, ast_node_t *property_spec, ast_node_t *assertion_variable_declaration_list, ast_node_t *block_end_identifier) {
    ast_property_declaration_t *property_declaration = calloc(1, sizeof(*property_declaration));

    property_declaration->super.print = _ast_property_declaration_print;
    property_declaration->super.free = _ast_property_declaration_free;

    property_declaration->identifier = identifier;
    property_declaration->property_port_list = property_port_list;
    property_declaration->property_spec = property_spec;
    property_declaration->assertion_variable_declaration_list = assertion_variable_declaration_list;
    property_declaration->block_end_identifier = block_end_identifier;

    return (ast_node_t *)property_declaration;
}

static void _ast_property_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_property_declaration_t *property_declaration = (ast_property_declaration_t *)node;

    ast_node_print(property_declaration->identifier, indent, indent_incr);
    ast_node_print(property_declaration->property_port_list, indent, indent_incr);
    ast_node_print(property_declaration->property_spec, indent, indent_incr);
    ast_node_print(property_declaration->assertion_variable_declaration_list, indent, indent_incr);
    ast_node_print(property_declaration->block_end_identifier, indent, indent_incr);
}

static void _ast_property_declaration_free(ast_node_t *node) {
    ast_property_declaration_t *property_declaration = (ast_property_declaration_t *)node;

    ast_node_free(property_declaration->identifier);
    ast_node_free(property_declaration->property_port_list);
    ast_node_free(property_declaration->property_spec);
    ast_node_free(property_declaration->assertion_variable_declaration_list);
    ast_node_free(property_declaration->block_end_identifier);
}
