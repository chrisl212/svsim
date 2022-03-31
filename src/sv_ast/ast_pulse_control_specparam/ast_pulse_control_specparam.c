#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_pulse_control_specparam_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_pulse_control_specparam_free(ast_node_t *node);

ast_node_t* ast_pulse_control_specparam_new(ast_node_t *constant_mintypmax_expression, ast_node_t *hierarchical_identifier0, ast_node_t *constant_mintypmax_expression1, ast_node_t *hierarchical_identifier1, ast_node_t *constant_mintypmax_expression0) {
    ast_pulse_control_specparam_t *pulse_control_specparam = calloc(1, sizeof(*pulse_control_specparam));

    pulse_control_specparam->super.print = _ast_pulse_control_specparam_print;
    pulse_control_specparam->super.free = _ast_pulse_control_specparam_free;

    pulse_control_specparam->constant_mintypmax_expression = constant_mintypmax_expression;
    pulse_control_specparam->hierarchical_identifier0 = hierarchical_identifier0;
    pulse_control_specparam->constant_mintypmax_expression1 = constant_mintypmax_expression1;
    pulse_control_specparam->hierarchical_identifier1 = hierarchical_identifier1;
    pulse_control_specparam->constant_mintypmax_expression0 = constant_mintypmax_expression0;

    return (ast_node_t *)pulse_control_specparam;
}

static void _ast_pulse_control_specparam_print(ast_node_t *node, int indent, int indent_incr) {
    ast_pulse_control_specparam_t *pulse_control_specparam = (ast_pulse_control_specparam_t *)node;

    ast_node_print(pulse_control_specparam->constant_mintypmax_expression, indent, indent_incr);
    ast_node_print(pulse_control_specparam->hierarchical_identifier0, indent, indent_incr);
    ast_node_print(pulse_control_specparam->constant_mintypmax_expression1, indent, indent_incr);
    ast_node_print(pulse_control_specparam->hierarchical_identifier1, indent, indent_incr);
    ast_node_print(pulse_control_specparam->constant_mintypmax_expression0, indent, indent_incr);
}

static void _ast_pulse_control_specparam_free(ast_node_t *node) {
    ast_pulse_control_specparam_t *pulse_control_specparam = (ast_pulse_control_specparam_t *)node;

    ast_node_free(pulse_control_specparam->constant_mintypmax_expression);
    ast_node_free(pulse_control_specparam->hierarchical_identifier0);
    ast_node_free(pulse_control_specparam->constant_mintypmax_expression1);
    ast_node_free(pulse_control_specparam->hierarchical_identifier1);
    ast_node_free(pulse_control_specparam->constant_mintypmax_expression0);
}
