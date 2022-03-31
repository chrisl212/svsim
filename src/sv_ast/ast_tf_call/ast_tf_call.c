#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_tf_call_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_tf_call_free(ast_node_t *node);

ast_node_t* ast_tf_call_new(ast_node_t *identifier, ast_node_t *ps_or_hierarchical_identifier, ast_implicit_class_handle_t implicit_class_handle, ast_node_t *argument_list) {
    ast_tf_call_t *tf_call = calloc(1, sizeof(*tf_call));

    tf_call->super.print = _ast_tf_call_print;
    tf_call->super.free = _ast_tf_call_free;

    tf_call->identifier = identifier;
    tf_call->ps_or_hierarchical_identifier = ps_or_hierarchical_identifier;
    tf_call->implicit_class_handle = implicit_class_handle;
    tf_call->argument_list = argument_list;

    return (ast_node_t *)tf_call;
}

static void _ast_tf_call_print(ast_node_t *node, int indent, int indent_incr) {
    ast_tf_call_t *tf_call = (ast_tf_call_t *)node;

    ast_node_print(tf_call->identifier, indent, indent_incr);
    ast_node_print(tf_call->ps_or_hierarchical_identifier, indent, indent_incr);
    ast_implicit_class_handle_print(tf_call->implicit_class_handle);
    ast_node_print(tf_call->argument_list, indent, indent_incr);
}

static void _ast_tf_call_free(ast_node_t *node) {
    ast_tf_call_t *tf_call = (ast_tf_call_t *)node;

    ast_node_free(tf_call->identifier);
    ast_node_free(tf_call->ps_or_hierarchical_identifier);
    ast_node_free(tf_call->argument_list);
}
