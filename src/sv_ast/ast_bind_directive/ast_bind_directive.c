#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_bind_directive_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_bind_directive_free(ast_node_t *node);

ast_node_t* ast_bind_directive_new(ast_node_t *hierarchical_identifier, ast_node_t *generic_instantiation) {
    ast_bind_directive_t *bind_directive = calloc(1, sizeof(*bind_directive));

    bind_directive->super.print = _ast_bind_directive_print;
    bind_directive->super.free = _ast_bind_directive_free;

    bind_directive->hierarchical_identifier = hierarchical_identifier;
    bind_directive->generic_instantiation = generic_instantiation;

    return (ast_node_t *)bind_directive;
}

static void _ast_bind_directive_print(ast_node_t *node, int indent, int indent_incr) {
    ast_bind_directive_t *bind_directive = (ast_bind_directive_t *)node;

    ast_node_print(bind_directive->hierarchical_identifier, indent, indent_incr);
    ast_node_print(bind_directive->generic_instantiation, indent, indent_incr);
}

static void _ast_bind_directive_free(ast_node_t *node) {
    ast_bind_directive_t *bind_directive = (ast_bind_directive_t *)node;

    ast_node_free(bind_directive->hierarchical_identifier);
    ast_node_free(bind_directive->generic_instantiation);
}
