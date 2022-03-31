#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_function_body_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_function_body_declaration_free(ast_node_t *node);

ast_node_t* ast_function_body_declaration_new(ast_node_t *statement_list, ast_node_t *tf_port_list, ast_node_t *tf_item_declaration_list, ast_node_t *function_type_name, ast_node_t *block_item_declaration_list, ast_node_t *function_block_end_identifier) {
    ast_function_body_declaration_t *function_body_declaration = calloc(1, sizeof(*function_body_declaration));

    function_body_declaration->super.print = _ast_function_body_declaration_print;
    function_body_declaration->super.free = _ast_function_body_declaration_free;

    function_body_declaration->statement_list = statement_list;
    function_body_declaration->tf_port_list = tf_port_list;
    function_body_declaration->tf_item_declaration_list = tf_item_declaration_list;
    function_body_declaration->function_type_name = function_type_name;
    function_body_declaration->block_item_declaration_list = block_item_declaration_list;
    function_body_declaration->function_block_end_identifier = function_block_end_identifier;

    return (ast_node_t *)function_body_declaration;
}

static void _ast_function_body_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_function_body_declaration_t *function_body_declaration = (ast_function_body_declaration_t *)node;

    ast_node_print(function_body_declaration->statement_list, indent, indent_incr);
    ast_node_print(function_body_declaration->tf_port_list, indent, indent_incr);
    ast_node_print(function_body_declaration->tf_item_declaration_list, indent, indent_incr);
    ast_node_print(function_body_declaration->function_type_name, indent, indent_incr);
    ast_node_print(function_body_declaration->block_item_declaration_list, indent, indent_incr);
    ast_node_print(function_body_declaration->function_block_end_identifier, indent, indent_incr);
}

static void _ast_function_body_declaration_free(ast_node_t *node) {
    ast_function_body_declaration_t *function_body_declaration = (ast_function_body_declaration_t *)node;

    ast_node_free(function_body_declaration->statement_list);
    ast_node_free(function_body_declaration->tf_port_list);
    ast_node_free(function_body_declaration->tf_item_declaration_list);
    ast_node_free(function_body_declaration->function_type_name);
    ast_node_free(function_body_declaration->block_item_declaration_list);
    ast_node_free(function_body_declaration->function_block_end_identifier);
}
