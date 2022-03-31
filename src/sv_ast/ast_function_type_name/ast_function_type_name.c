#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_function_type_name_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_function_type_name_free(ast_node_t *node);

ast_node_t* ast_function_type_name_new(ast_node_t *ps_or_hierarchical_identifier, ast_node_t *ps_identifier_tok, ast_node_t *function_data_type) {
    ast_function_type_name_t *function_type_name = calloc(1, sizeof(*function_type_name));

    function_type_name->super.print = _ast_function_type_name_print;
    function_type_name->super.free = _ast_function_type_name_free;

    function_type_name->ps_or_hierarchical_identifier = ps_or_hierarchical_identifier;
    function_type_name->ps_identifier_tok = ps_identifier_tok;
    function_type_name->function_data_type = function_data_type;

    return (ast_node_t *)function_type_name;
}

static void _ast_function_type_name_print(ast_node_t *node, int indent, int indent_incr) {
    ast_function_type_name_t *function_type_name = (ast_function_type_name_t *)node;

    ast_node_print(function_type_name->ps_or_hierarchical_identifier, indent, indent_incr);
    ast_node_print(function_type_name->ps_identifier_tok, indent, indent_incr);
    ast_node_print(function_type_name->function_data_type, indent, indent_incr);
}

static void _ast_function_type_name_free(ast_node_t *node) {
    ast_function_type_name_t *function_type_name = (ast_function_type_name_t *)node;

    ast_node_free(function_type_name->ps_or_hierarchical_identifier);
    ast_node_free(function_type_name->ps_identifier_tok);
    ast_node_free(function_type_name->function_data_type);
}
