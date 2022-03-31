#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_data_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_data_declaration_free(ast_node_t *node);

ast_node_t* ast_data_declaration_new(ast_node_t *variable_decl_assignment_list, ast_node_t *method_variable_qualifier_list, ast_node_t *variable_qualifier_list, ast_node_t *data_type, ast_node_t *type_declaration, ast_node_t *package_import_declaration) {
    ast_data_declaration_t *data_declaration = calloc(1, sizeof(*data_declaration));

    data_declaration->super.print = _ast_data_declaration_print;
    data_declaration->super.free = _ast_data_declaration_free;

    data_declaration->variable_decl_assignment_list = variable_decl_assignment_list;
    data_declaration->method_variable_qualifier_list = method_variable_qualifier_list;
    data_declaration->variable_qualifier_list = variable_qualifier_list;
    data_declaration->data_type = data_type;
    data_declaration->type_declaration = type_declaration;
    data_declaration->package_import_declaration = package_import_declaration;

    return (ast_node_t *)data_declaration;
}

static void _ast_data_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_data_declaration_t *data_declaration = (ast_data_declaration_t *)node;

    ast_node_print(data_declaration->variable_decl_assignment_list, indent, indent_incr);
    ast_node_print(data_declaration->method_variable_qualifier_list, indent, indent_incr);
    ast_node_print(data_declaration->variable_qualifier_list, indent, indent_incr);
    ast_node_print(data_declaration->data_type, indent, indent_incr);
    ast_node_print(data_declaration->type_declaration, indent, indent_incr);
    ast_node_print(data_declaration->package_import_declaration, indent, indent_incr);
}

static void _ast_data_declaration_free(ast_node_t *node) {
    ast_data_declaration_t *data_declaration = (ast_data_declaration_t *)node;

    ast_node_free(data_declaration->variable_decl_assignment_list);
    ast_node_free(data_declaration->method_variable_qualifier_list);
    ast_node_free(data_declaration->variable_qualifier_list);
    ast_node_free(data_declaration->data_type);
    ast_node_free(data_declaration->type_declaration);
    ast_node_free(data_declaration->package_import_declaration);
}
