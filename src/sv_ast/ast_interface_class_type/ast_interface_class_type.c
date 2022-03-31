#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_interface_class_type_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_interface_class_type_free(ast_node_t *node);

ast_node_t* ast_interface_class_type_new(ast_node_t *ps_or_normal_identifier, ast_node_t *parameter_value_assignment) {
    ast_interface_class_type_t *interface_class_type = calloc(1, sizeof(*interface_class_type));

    interface_class_type->super.print = _ast_interface_class_type_print;
    interface_class_type->super.free = _ast_interface_class_type_free;

    interface_class_type->ps_or_normal_identifier = ps_or_normal_identifier;
    interface_class_type->parameter_value_assignment = parameter_value_assignment;

    return (ast_node_t *)interface_class_type;
}

static void _ast_interface_class_type_print(ast_node_t *node, int indent, int indent_incr) {
    ast_interface_class_type_t *interface_class_type = (ast_interface_class_type_t *)node;

    ast_node_print(interface_class_type->ps_or_normal_identifier, indent, indent_incr);
    ast_node_print(interface_class_type->parameter_value_assignment, indent, indent_incr);
}

static void _ast_interface_class_type_free(ast_node_t *node) {
    ast_interface_class_type_t *interface_class_type = (ast_interface_class_type_t *)node;

    ast_node_free(interface_class_type->ps_or_normal_identifier);
    ast_node_free(interface_class_type->parameter_value_assignment);
}
