#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_assertion_variable_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_assertion_variable_declaration_free(ast_node_t *node);

ast_node_t* ast_assertion_variable_declaration_new(ast_node_t *data_type, ast_node_t *variable_decl_assignment_list) {
    ast_assertion_variable_declaration_t *assertion_variable_declaration = calloc(1, sizeof(*assertion_variable_declaration));

    assertion_variable_declaration->super.print = _ast_assertion_variable_declaration_print;
    assertion_variable_declaration->super.free = _ast_assertion_variable_declaration_free;

    assertion_variable_declaration->data_type = data_type;
    assertion_variable_declaration->variable_decl_assignment_list = variable_decl_assignment_list;

    return (ast_node_t *)assertion_variable_declaration;
}

static void _ast_assertion_variable_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_assertion_variable_declaration_t *assertion_variable_declaration = (ast_assertion_variable_declaration_t *)node;

    ast_node_print(assertion_variable_declaration->data_type, indent, indent_incr);
    ast_node_print(assertion_variable_declaration->variable_decl_assignment_list, indent, indent_incr);
}

static void _ast_assertion_variable_declaration_free(ast_node_t *node) {
    ast_assertion_variable_declaration_t *assertion_variable_declaration = (ast_assertion_variable_declaration_t *)node;

    ast_node_free(assertion_variable_declaration->data_type);
    ast_node_free(assertion_variable_declaration->variable_decl_assignment_list);
}
