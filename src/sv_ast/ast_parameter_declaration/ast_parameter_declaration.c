#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_parameter_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_parameter_declaration_free(ast_node_t *node);

ast_node_t* ast_parameter_declaration_new(ast_node_t *data_type, ast_node_t *param_assignment_list, ast_node_t *type_assignment_list) {
    ast_parameter_declaration_t *parameter_declaration = calloc(1, sizeof(*parameter_declaration));

    parameter_declaration->super.print = _ast_parameter_declaration_print;
    parameter_declaration->super.free = _ast_parameter_declaration_free;

    parameter_declaration->data_type = data_type;
    parameter_declaration->param_assignment_list = param_assignment_list;
    parameter_declaration->type_assignment_list = type_assignment_list;

    return (ast_node_t *)parameter_declaration;
}

static void _ast_parameter_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_parameter_declaration_t *parameter_declaration = (ast_parameter_declaration_t *)node;

    ast_node_print(parameter_declaration->data_type, indent, indent_incr);
    ast_node_print(parameter_declaration->param_assignment_list, indent, indent_incr);
    ast_node_print(parameter_declaration->type_assignment_list, indent, indent_incr);
}

static void _ast_parameter_declaration_free(ast_node_t *node) {
    ast_parameter_declaration_t *parameter_declaration = (ast_parameter_declaration_t *)node;

    ast_node_free(parameter_declaration->data_type);
    ast_node_free(parameter_declaration->param_assignment_list);
    ast_node_free(parameter_declaration->type_assignment_list);
}
