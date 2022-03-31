#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"
#include "ast_identifier.h"

static void _ast_identifier_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_identifier_free(ast_node_t *node);

ast_node_t* ast_identifier_new(char *identifier) {
    ast_identifier_t *ident = calloc(1, sizeof(*ident));

    ident->super.print = _ast_identifier_print;
    ident->super.free = _ast_identifier_free;

    ident->identifier = identifier;

    return (ast_node_t *)ident;
}

static void _ast_identifier_print(ast_node_t *node, int indent, int indent_incr) {
    ast_identifier_t *identifier = (ast_identifier_t *)node;

    printf("%s", identifier->identifier);
}

static void _ast_identifier_free(ast_node_t *node) {
    ast_identifier_t *identifier = (ast_identifier_t *)node;

    free(identifier->identifier);
}

