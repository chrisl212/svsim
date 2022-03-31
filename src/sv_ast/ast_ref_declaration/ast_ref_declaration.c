#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_ref_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_ref_declaration_free(ast_node_t *node);

ast_node_t* ast_ref_declaration_new(ast_node_t *variable_identifier_list, ast_node_t *variable_port_type) {
    ast_ref_declaration_t *ref_declaration = calloc(1, sizeof(*ref_declaration));

    ref_declaration->super.print = _ast_ref_declaration_print;
    ref_declaration->super.free = _ast_ref_declaration_free;

    ref_declaration->variable_identifier_list = variable_identifier_list;
    ref_declaration->variable_port_type = variable_port_type;

    return (ast_node_t *)ref_declaration;
}

static void _ast_ref_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_ref_declaration_t *ref_declaration = (ast_ref_declaration_t *)node;

    ast_node_print(ref_declaration->variable_identifier_list, indent, indent_incr);
    ast_node_print(ref_declaration->variable_port_type, indent, indent_incr);
}

static void _ast_ref_declaration_free(ast_node_t *node) {
    ast_ref_declaration_t *ref_declaration = (ast_ref_declaration_t *)node;

    ast_node_free(ref_declaration->variable_identifier_list);
    ast_node_free(ref_declaration->variable_port_type);
}
