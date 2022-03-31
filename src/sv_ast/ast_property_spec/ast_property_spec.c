#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_property_spec_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_property_spec_free(ast_node_t *node);

ast_node_t* ast_property_spec_new(ast_node_t *expression_or_dist, ast_node_t *property_expr, ast_node_t *clocking_event) {
    ast_property_spec_t *property_spec = calloc(1, sizeof(*property_spec));

    property_spec->super.print = _ast_property_spec_print;
    property_spec->super.free = _ast_property_spec_free;

    property_spec->expression_or_dist = expression_or_dist;
    property_spec->property_expr = property_expr;
    property_spec->clocking_event = clocking_event;

    return (ast_node_t *)property_spec;
}

static void _ast_property_spec_print(ast_node_t *node, int indent, int indent_incr) {
    ast_property_spec_t *property_spec = (ast_property_spec_t *)node;

    ast_node_print(property_spec->expression_or_dist, indent, indent_incr);
    ast_node_print(property_spec->property_expr, indent, indent_incr);
    ast_node_print(property_spec->clocking_event, indent, indent_incr);
}

static void _ast_property_spec_free(ast_node_t *node) {
    ast_property_spec_t *property_spec = (ast_property_spec_t *)node;

    ast_node_free(property_spec->expression_or_dist);
    ast_node_free(property_spec->property_expr);
    ast_node_free(property_spec->clocking_event);
}
