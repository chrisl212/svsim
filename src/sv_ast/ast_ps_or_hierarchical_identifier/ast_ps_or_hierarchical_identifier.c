#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_ps_or_hierarchical_identifier_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_ps_or_hierarchical_identifier_free(ast_node_t *node);

ast_node_t* ast_ps_or_hierarchical_identifier_new(ast_node_t *ps_identifier, ast_node_t *identifier1, ast_node_t *hierarchical_identifier, ast_node_t *parameter_value_assignment, ast_node_t *identifier0) {
    ast_ps_or_hierarchical_identifier_t *ps_or_hierarchical_identifier = calloc(1, sizeof(*ps_or_hierarchical_identifier));

    ps_or_hierarchical_identifier->super.print = _ast_ps_or_hierarchical_identifier_print;
    ps_or_hierarchical_identifier->super.free = _ast_ps_or_hierarchical_identifier_free;

    ps_or_hierarchical_identifier->ps_identifier = ps_identifier;
    ps_or_hierarchical_identifier->identifier1 = identifier1;
    ps_or_hierarchical_identifier->hierarchical_identifier = hierarchical_identifier;
    ps_or_hierarchical_identifier->parameter_value_assignment = parameter_value_assignment;
    ps_or_hierarchical_identifier->identifier0 = identifier0;

    return (ast_node_t *)ps_or_hierarchical_identifier;
}

static void _ast_ps_or_hierarchical_identifier_print(ast_node_t *node, int indent, int indent_incr) {
    ast_ps_or_hierarchical_identifier_t *ps_or_hierarchical_identifier = (ast_ps_or_hierarchical_identifier_t *)node;

    ast_node_print(ps_or_hierarchical_identifier->ps_identifier, indent, indent_incr);
    ast_node_print(ps_or_hierarchical_identifier->identifier1, indent, indent_incr);
    ast_node_print(ps_or_hierarchical_identifier->hierarchical_identifier, indent, indent_incr);
    ast_node_print(ps_or_hierarchical_identifier->parameter_value_assignment, indent, indent_incr);
    ast_node_print(ps_or_hierarchical_identifier->identifier0, indent, indent_incr);
}

static void _ast_ps_or_hierarchical_identifier_free(ast_node_t *node) {
    ast_ps_or_hierarchical_identifier_t *ps_or_hierarchical_identifier = (ast_ps_or_hierarchical_identifier_t *)node;

    ast_node_free(ps_or_hierarchical_identifier->ps_identifier);
    ast_node_free(ps_or_hierarchical_identifier->identifier1);
    ast_node_free(ps_or_hierarchical_identifier->hierarchical_identifier);
    ast_node_free(ps_or_hierarchical_identifier->parameter_value_assignment);
    ast_node_free(ps_or_hierarchical_identifier->identifier0);
}
