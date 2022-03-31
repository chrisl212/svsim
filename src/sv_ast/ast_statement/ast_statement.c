#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_statement_free(ast_node_t *node);

ast_node_t* ast_statement_new(ast_node_t *identifier, ast_node_t *statement_item) {
    ast_statement_t *statement = calloc(1, sizeof(*statement));

    statement->super.print = _ast_statement_print;
    statement->super.free = _ast_statement_free;

    statement->identifier = identifier;
    statement->statement_item = statement_item;

    return (ast_node_t *)statement;
}

static void _ast_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_statement_t *statement = (ast_statement_t *)node;

    ast_node_print(statement->identifier, indent, indent_incr);
    ast_node_print(statement->statement_item, indent, indent_incr);
}

static void _ast_statement_free(ast_node_t *node) {
    ast_statement_t *statement = (ast_statement_t *)node;

    ast_node_free(statement->identifier);
    ast_node_free(statement->statement_item);
}
