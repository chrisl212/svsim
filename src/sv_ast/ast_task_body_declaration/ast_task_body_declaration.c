#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_task_body_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_task_body_declaration_free(ast_node_t *node);

ast_node_t* ast_task_body_declaration_new(ast_node_t *statement_list, ast_node_t *tf_port_list, ast_node_t *tf_item_declaration_list, ast_node_t *ps_or_hierarchical_identifier, ast_node_t *block_end_identifier, ast_node_t *block_item_declaration_list) {
    ast_task_body_declaration_t *task_body_declaration = calloc(1, sizeof(*task_body_declaration));

    task_body_declaration->super.print = _ast_task_body_declaration_print;
    task_body_declaration->super.free = _ast_task_body_declaration_free;

    task_body_declaration->statement_list = statement_list;
    task_body_declaration->tf_port_list = tf_port_list;
    task_body_declaration->tf_item_declaration_list = tf_item_declaration_list;
    task_body_declaration->ps_or_hierarchical_identifier = ps_or_hierarchical_identifier;
    task_body_declaration->block_end_identifier = block_end_identifier;
    task_body_declaration->block_item_declaration_list = block_item_declaration_list;

    return (ast_node_t *)task_body_declaration;
}

static void _ast_task_body_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_task_body_declaration_t *task_body_declaration = (ast_task_body_declaration_t *)node;

    ast_node_print(task_body_declaration->statement_list, indent, indent_incr);
    ast_node_print(task_body_declaration->tf_port_list, indent, indent_incr);
    ast_node_print(task_body_declaration->tf_item_declaration_list, indent, indent_incr);
    ast_node_print(task_body_declaration->ps_or_hierarchical_identifier, indent, indent_incr);
    ast_node_print(task_body_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(task_body_declaration->block_item_declaration_list, indent, indent_incr);
}

static void _ast_task_body_declaration_free(ast_node_t *node) {
    ast_task_body_declaration_t *task_body_declaration = (ast_task_body_declaration_t *)node;

    ast_node_free(task_body_declaration->statement_list);
    ast_node_free(task_body_declaration->tf_port_list);
    ast_node_free(task_body_declaration->tf_item_declaration_list);
    ast_node_free(task_body_declaration->ps_or_hierarchical_identifier);
    ast_node_free(task_body_declaration->block_end_identifier);
    ast_node_free(task_body_declaration->block_item_declaration_list);
}
