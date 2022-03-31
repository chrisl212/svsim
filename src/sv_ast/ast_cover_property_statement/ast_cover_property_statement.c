#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_cover_property_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_cover_property_statement_free(ast_node_t *node);

ast_node_t* ast_cover_property_statement_new(ast_node_t *property_spec, ast_node_t *statement) {
    ast_cover_property_statement_t *cover_property_statement = calloc(1, sizeof(*cover_property_statement));

    cover_property_statement->super.print = _ast_cover_property_statement_print;
    cover_property_statement->super.free = _ast_cover_property_statement_free;

    cover_property_statement->property_spec = property_spec;
    cover_property_statement->statement = statement;

    return (ast_node_t *)cover_property_statement;
}

static void _ast_cover_property_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_cover_property_statement_t *cover_property_statement = (ast_cover_property_statement_t *)node;

    ast_node_print(cover_property_statement->property_spec, indent, indent_incr);
    ast_node_print(cover_property_statement->statement, indent, indent_incr);
}

static void _ast_cover_property_statement_free(ast_node_t *node) {
    ast_cover_property_statement_t *cover_property_statement = (ast_cover_property_statement_t *)node;

    ast_node_free(cover_property_statement->property_spec);
    ast_node_free(cover_property_statement->statement);
}
