#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_parameter_port_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_parameter_port_declaration_free(ast_node_t *node);

ast_node_t* ast_parameter_port_declaration_new(ast_node_t *dont, ast_node_t *multiple, ast_node_t *parameter_declaration, ast_node_t *support, ast_node_t *type_assignment, ast_node_t *data_type_or_param, ast_node_t *param_assignment, ast_node_t *local_parameter_declaration, ast_node_t *decls) {
    ast_parameter_port_declaration_t *parameter_port_declaration = calloc(1, sizeof(*parameter_port_declaration));

    parameter_port_declaration->super.print = _ast_parameter_port_declaration_print;
    parameter_port_declaration->super.free = _ast_parameter_port_declaration_free;

    parameter_port_declaration->dont = dont;
    parameter_port_declaration->multiple = multiple;
    parameter_port_declaration->parameter_declaration = parameter_declaration;
    parameter_port_declaration->support = support;
    parameter_port_declaration->type_assignment = type_assignment;
    parameter_port_declaration->data_type_or_param = data_type_or_param;
    parameter_port_declaration->param_assignment = param_assignment;
    parameter_port_declaration->local_parameter_declaration = local_parameter_declaration;
    parameter_port_declaration->decls = decls;

    return (ast_node_t *)parameter_port_declaration;
}

static void _ast_parameter_port_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_parameter_port_declaration_t *parameter_port_declaration = (ast_parameter_port_declaration_t *)node;

    ast_node_print(parameter_port_declaration->dont, indent, indent_incr);
    ast_node_print(parameter_port_declaration->multiple, indent, indent_incr);
    ast_node_print(parameter_port_declaration->parameter_declaration, indent, indent_incr);
    ast_node_print(parameter_port_declaration->support, indent, indent_incr);
    ast_node_print(parameter_port_declaration->type_assignment, indent, indent_incr);
    ast_node_print(parameter_port_declaration->data_type_or_param, indent, indent_incr);
    ast_node_print(parameter_port_declaration->param_assignment, indent, indent_incr);
    ast_node_print(parameter_port_declaration->local_parameter_declaration, indent, indent_incr);
    ast_node_print(parameter_port_declaration->decls, indent, indent_incr);
}

static void _ast_parameter_port_declaration_free(ast_node_t *node) {
    ast_parameter_port_declaration_t *parameter_port_declaration = (ast_parameter_port_declaration_t *)node;

    ast_node_free(parameter_port_declaration->dont);
    ast_node_free(parameter_port_declaration->multiple);
    ast_node_free(parameter_port_declaration->parameter_declaration);
    ast_node_free(parameter_port_declaration->support);
    ast_node_free(parameter_port_declaration->type_assignment);
    ast_node_free(parameter_port_declaration->data_type_or_param);
    ast_node_free(parameter_port_declaration->param_assignment);
    ast_node_free(parameter_port_declaration->local_parameter_declaration);
    ast_node_free(parameter_port_declaration->decls);
}
