#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_specparam_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_specparam_assignment_free(ast_node_t *node);

ast_node_t* ast_specparam_assignment_new(ast_node_t *constant_mintypmax_expression, ast_node_t *identifier, ast_node_t *pulse_control_specparam) {
    ast_specparam_assignment_t *specparam_assignment = calloc(1, sizeof(*specparam_assignment));

    specparam_assignment->super.print = _ast_specparam_assignment_print;
    specparam_assignment->super.free = _ast_specparam_assignment_free;

    specparam_assignment->constant_mintypmax_expression = constant_mintypmax_expression;
    specparam_assignment->identifier = identifier;
    specparam_assignment->pulse_control_specparam = pulse_control_specparam;

    return (ast_node_t *)specparam_assignment;
}

static void _ast_specparam_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_specparam_assignment_t *specparam_assignment = (ast_specparam_assignment_t *)node;

    ast_node_print(specparam_assignment->constant_mintypmax_expression, indent, indent_incr);
    ast_node_print(specparam_assignment->identifier, indent, indent_incr);
    ast_node_print(specparam_assignment->pulse_control_specparam, indent, indent_incr);
}

static void _ast_specparam_assignment_free(ast_node_t *node) {
    ast_specparam_assignment_t *specparam_assignment = (ast_specparam_assignment_t *)node;

    ast_node_free(specparam_assignment->constant_mintypmax_expression);
    ast_node_free(specparam_assignment->identifier);
    ast_node_free(specparam_assignment->pulse_control_specparam);
}
