#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_class_scope_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_class_scope_free(ast_node_t *node);

ast_node_t* ast_class_scope_new(ast_node_t *identifier, ast_node_t *parameter_value_assignment, ast_node_t *ps_identifier_tok) {
    ast_class_scope_t *class_scope = calloc(1, sizeof(*class_scope));

    class_scope->super.print = _ast_class_scope_print;
    class_scope->super.free = _ast_class_scope_free;

    class_scope->identifier = identifier;
    class_scope->parameter_value_assignment = parameter_value_assignment;
    class_scope->ps_identifier_tok = ps_identifier_tok;

    return (ast_node_t *)class_scope;
}

static void _ast_class_scope_print(ast_node_t *node, int indent, int indent_incr) {
    ast_class_scope_t *class_scope = (ast_class_scope_t *)node;

    ast_node_print(class_scope->identifier, indent, indent_incr);
    ast_node_print(class_scope->parameter_value_assignment, indent, indent_incr);
    ast_node_print(class_scope->ps_identifier_tok, indent, indent_incr);
}

static void _ast_class_scope_free(ast_node_t *node) {
    ast_class_scope_t *class_scope = (ast_class_scope_t *)node;

    ast_node_free(class_scope->identifier);
    ast_node_free(class_scope->parameter_value_assignment);
    ast_node_free(class_scope->ps_identifier_tok);
}
