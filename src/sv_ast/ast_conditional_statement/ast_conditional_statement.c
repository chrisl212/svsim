#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_conditional_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_conditional_statement_free(ast_node_t *node);

ast_node_t* ast_conditional_statement_new(ast_node_t *else_if_list, ast_node_t *statement, ast_node_t *cond_predicate, ast_node_t *unique_priority, ast_node_t *statement0, ast_node_t *statement1) {
    ast_conditional_statement_t *conditional_statement = calloc(1, sizeof(*conditional_statement));

    conditional_statement->super.print = _ast_conditional_statement_print;
    conditional_statement->super.free = _ast_conditional_statement_free;

    conditional_statement->else_if_list = else_if_list;
    conditional_statement->statement = statement;
    conditional_statement->cond_predicate = cond_predicate;
    conditional_statement->unique_priority = unique_priority;
    conditional_statement->statement0 = statement0;
    conditional_statement->statement1 = statement1;

    return (ast_node_t *)conditional_statement;
}

static void _ast_conditional_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_conditional_statement_t *conditional_statement = (ast_conditional_statement_t *)node;

    ast_node_print(conditional_statement->else_if_list, indent, indent_incr);
    ast_node_print(conditional_statement->statement, indent, indent_incr);
    ast_node_print(conditional_statement->cond_predicate, indent, indent_incr);
    ast_node_print(conditional_statement->unique_priority, indent, indent_incr);
    ast_node_print(conditional_statement->statement0, indent, indent_incr);
    ast_node_print(conditional_statement->statement1, indent, indent_incr);
}

static void _ast_conditional_statement_free(ast_node_t *node) {
    ast_conditional_statement_t *conditional_statement = (ast_conditional_statement_t *)node;

    ast_node_free(conditional_statement->else_if_list);
    ast_node_free(conditional_statement->statement);
    ast_node_free(conditional_statement->cond_predicate);
    ast_node_free(conditional_statement->unique_priority);
    ast_node_free(conditional_statement->statement0);
    ast_node_free(conditional_statement->statement1);
}
