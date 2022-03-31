#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_defparam_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_defparam_assignment_free(ast_node_t *node);

ast_node_t* ast_defparam_assignment_new(ast_node_t *constant_mintypmax_expression, ast_node_t *hierarchical_identifier) {
    ast_defparam_assignment_t *defparam_assignment = calloc(1, sizeof(*defparam_assignment));

    defparam_assignment->super.print = _ast_defparam_assignment_print;
    defparam_assignment->super.free = _ast_defparam_assignment_free;

    defparam_assignment->constant_mintypmax_expression = constant_mintypmax_expression;
    defparam_assignment->hierarchical_identifier = hierarchical_identifier;

    return (ast_node_t *)defparam_assignment;
}

static void _ast_defparam_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_defparam_assignment_t *defparam_assignment = (ast_defparam_assignment_t *)node;

    ast_node_print(defparam_assignment->constant_mintypmax_expression, indent, indent_incr);
    ast_node_print(defparam_assignment->hierarchical_identifier, indent, indent_incr);
}

static void _ast_defparam_assignment_free(ast_node_t *node) {
    ast_defparam_assignment_t *defparam_assignment = (ast_defparam_assignment_t *)node;

    ast_node_free(defparam_assignment->constant_mintypmax_expression);
    ast_node_free(defparam_assignment->hierarchical_identifier);
}
