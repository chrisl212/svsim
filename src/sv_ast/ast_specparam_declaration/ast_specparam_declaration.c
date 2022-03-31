#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_specparam_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_specparam_declaration_free(ast_node_t *node);

ast_node_t* ast_specparam_declaration_new(ast_node_t *specparam_assignment_list, ast_node_t *packed_dimension_list) {
    ast_specparam_declaration_t *specparam_declaration = calloc(1, sizeof(*specparam_declaration));

    specparam_declaration->super.print = _ast_specparam_declaration_print;
    specparam_declaration->super.free = _ast_specparam_declaration_free;

    specparam_declaration->specparam_assignment_list = specparam_assignment_list;
    specparam_declaration->packed_dimension_list = packed_dimension_list;

    return (ast_node_t *)specparam_declaration;
}

static void _ast_specparam_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_specparam_declaration_t *specparam_declaration = (ast_specparam_declaration_t *)node;

    ast_node_print(specparam_declaration->specparam_assignment_list, indent, indent_incr);
    ast_node_print(specparam_declaration->packed_dimension_list, indent, indent_incr);
}

static void _ast_specparam_declaration_free(ast_node_t *node) {
    ast_specparam_declaration_t *specparam_declaration = (ast_specparam_declaration_t *)node;

    ast_node_free(specparam_declaration->specparam_assignment_list);
    ast_node_free(specparam_declaration->packed_dimension_list);
}
