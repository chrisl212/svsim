#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_interface_class_parameters_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_interface_class_parameters_free(ast_node_t *node);

ast_node_t* ast_interface_class_parameters_new(ast_node_t *parameter_port_list, ast_node_t *parameter_value_assignment) {
    ast_interface_class_parameters_t *interface_class_parameters = calloc(1, sizeof(*interface_class_parameters));

    interface_class_parameters->super.print = _ast_interface_class_parameters_print;
    interface_class_parameters->super.free = _ast_interface_class_parameters_free;

    interface_class_parameters->parameter_port_list = parameter_port_list;
    interface_class_parameters->parameter_value_assignment = parameter_value_assignment;

    return (ast_node_t *)interface_class_parameters;
}

static void _ast_interface_class_parameters_print(ast_node_t *node, int indent, int indent_incr) {
    ast_interface_class_parameters_t *interface_class_parameters = (ast_interface_class_parameters_t *)node;

    ast_node_print(interface_class_parameters->parameter_port_list, indent, indent_incr);
    ast_node_print(interface_class_parameters->parameter_value_assignment, indent, indent_incr);
}

static void _ast_interface_class_parameters_free(ast_node_t *node) {
    ast_interface_class_parameters_t *interface_class_parameters = (ast_interface_class_parameters_t *)node;

    ast_node_free(interface_class_parameters->parameter_port_list);
    ast_node_free(interface_class_parameters->parameter_value_assignment);
}
