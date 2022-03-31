#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_ps_identifier_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_ps_identifier_free(ast_node_t *node);

ast_node_t* ast_ps_identifier_new(ast_node_t *identifier, ast_node_t *ps_identifier_tok) {
    ast_ps_identifier_t *ps_identifier = calloc(1, sizeof(*ps_identifier));

    ps_identifier->super.print = _ast_ps_identifier_print;
    ps_identifier->super.free = _ast_ps_identifier_free;

    ps_identifier->identifier = identifier;
    ps_identifier->ps_identifier_tok = ps_identifier_tok;

    return (ast_node_t *)ps_identifier;
}

static void _ast_ps_identifier_print(ast_node_t *node, int indent, int indent_incr) {
    ast_ps_identifier_t *ps_identifier = (ast_ps_identifier_t *)node;

    ast_node_print(ps_identifier->identifier, indent, indent_incr);
    ast_node_print(ps_identifier->ps_identifier_tok, indent, indent_incr);
}

static void _ast_ps_identifier_free(ast_node_t *node) {
    ast_ps_identifier_t *ps_identifier = (ast_ps_identifier_t *)node;

    ast_node_free(ps_identifier->identifier);
    ast_node_free(ps_identifier->ps_identifier_tok);
}
