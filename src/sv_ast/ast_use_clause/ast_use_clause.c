#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_use_clause_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_use_clause_free(ast_node_t *node);

ast_node_t* ast_use_clause_new(ast_node_t *hierarchical_identifier, ast_node_t *named_parameter_assignment_list) {
    ast_use_clause_t *use_clause = calloc(1, sizeof(*use_clause));

    use_clause->super.print = _ast_use_clause_print;
    use_clause->super.free = _ast_use_clause_free;

    use_clause->hierarchical_identifier = hierarchical_identifier;
    use_clause->named_parameter_assignment_list = named_parameter_assignment_list;

    return (ast_node_t *)use_clause;
}

static void _ast_use_clause_print(ast_node_t *node, int indent, int indent_incr) {
    ast_use_clause_t *use_clause = (ast_use_clause_t *)node;

    ast_node_print(use_clause->hierarchical_identifier, indent, indent_incr);
    ast_node_print(use_clause->named_parameter_assignment_list, indent, indent_incr);
}

static void _ast_use_clause_free(ast_node_t *node) {
    ast_use_clause_t *use_clause = (ast_use_clause_t *)node;

    ast_node_free(use_clause->hierarchical_identifier);
    ast_node_free(use_clause->named_parameter_assignment_list);
}
