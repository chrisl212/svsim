#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_wait_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_wait_statement_free(ast_node_t *node);

ast_node_t* ast_wait_statement_new(ast_node_t *action_block, ast_node_t *expression, ast_node_t *hierarchical_identifier_list, ast_node_t *statement) {
    ast_wait_statement_t *wait_statement = calloc(1, sizeof(*wait_statement));

    wait_statement->super.print = _ast_wait_statement_print;
    wait_statement->super.free = _ast_wait_statement_free;

    wait_statement->action_block = action_block;
    wait_statement->expression = expression;
    wait_statement->hierarchical_identifier_list = hierarchical_identifier_list;
    wait_statement->statement = statement;

    return (ast_node_t *)wait_statement;
}

static void _ast_wait_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_wait_statement_t *wait_statement = (ast_wait_statement_t *)node;

    ast_node_print(wait_statement->action_block, indent, indent_incr);
    ast_node_print(wait_statement->expression, indent, indent_incr);
    ast_node_print(wait_statement->hierarchical_identifier_list, indent, indent_incr);
    ast_node_print(wait_statement->statement, indent, indent_incr);
}

static void _ast_wait_statement_free(ast_node_t *node) {
    ast_wait_statement_t *wait_statement = (ast_wait_statement_t *)node;

    ast_node_free(wait_statement->action_block);
    ast_node_free(wait_statement->expression);
    ast_node_free(wait_statement->hierarchical_identifier_list);
    ast_node_free(wait_statement->statement);
}
