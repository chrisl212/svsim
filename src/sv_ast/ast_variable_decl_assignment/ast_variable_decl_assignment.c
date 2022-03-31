#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_variable_decl_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_variable_decl_assignment_free(ast_node_t *node);

ast_node_t* ast_variable_decl_assignment_new(ast_node_t *identifier, ast_node_t *expression, ast_node_t *variable_dimension_list) {
    ast_variable_decl_assignment_t *variable_decl_assignment = calloc(1, sizeof(*variable_decl_assignment));

    variable_decl_assignment->super.print = _ast_variable_decl_assignment_print;
    variable_decl_assignment->super.free = _ast_variable_decl_assignment_free;

    variable_decl_assignment->identifier = identifier;
    variable_decl_assignment->expression = expression;
    variable_decl_assignment->variable_dimension_list = variable_dimension_list;

    return (ast_node_t *)variable_decl_assignment;
}

static void _ast_variable_decl_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_variable_decl_assignment_t *variable_decl_assignment = (ast_variable_decl_assignment_t *)node;

    ast_node_print(variable_decl_assignment->identifier, indent, indent_incr);
    ast_node_print(variable_decl_assignment->expression, indent, indent_incr);
    ast_node_print(variable_decl_assignment->variable_dimension_list, indent, indent_incr);
}

static void _ast_variable_decl_assignment_free(ast_node_t *node) {
    ast_variable_decl_assignment_t *variable_decl_assignment = (ast_variable_decl_assignment_t *)node;

    ast_node_free(variable_decl_assignment->identifier);
    ast_node_free(variable_decl_assignment->expression);
    ast_node_free(variable_decl_assignment->variable_dimension_list);
}
