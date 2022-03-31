#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_loop_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_loop_statement_free(ast_node_t *node);

ast_node_t* ast_loop_statement_new(ast_node_t *identifier_list, ast_node_t *statement, ast_node_t *identifier, ast_node_t *expression, ast_node_t *for_step, ast_node_t *for_initialization) {
    ast_loop_statement_t *loop_statement = calloc(1, sizeof(*loop_statement));

    loop_statement->super.print = _ast_loop_statement_print;
    loop_statement->super.free = _ast_loop_statement_free;

    loop_statement->identifier_list = identifier_list;
    loop_statement->statement = statement;
    loop_statement->identifier = identifier;
    loop_statement->expression = expression;
    loop_statement->for_step = for_step;
    loop_statement->for_initialization = for_initialization;

    return (ast_node_t *)loop_statement;
}

static void _ast_loop_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_loop_statement_t *loop_statement = (ast_loop_statement_t *)node;

    ast_node_print(loop_statement->identifier_list, indent, indent_incr);
    ast_node_print(loop_statement->statement, indent, indent_incr);
    ast_node_print(loop_statement->identifier, indent, indent_incr);
    ast_node_print(loop_statement->expression, indent, indent_incr);
    ast_node_print(loop_statement->for_step, indent, indent_incr);
    ast_node_print(loop_statement->for_initialization, indent, indent_incr);
}

static void _ast_loop_statement_free(ast_node_t *node) {
    ast_loop_statement_t *loop_statement = (ast_loop_statement_t *)node;

    ast_node_free(loop_statement->identifier_list);
    ast_node_free(loop_statement->statement);
    ast_node_free(loop_statement->identifier);
    ast_node_free(loop_statement->expression);
    ast_node_free(loop_statement->for_step);
    ast_node_free(loop_statement->for_initialization);
}
