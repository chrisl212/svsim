#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_data_type_or_param_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_data_type_or_param_free(ast_node_t *node);

ast_node_t* ast_data_type_or_param_new(ast_node_t *data_type) {
    ast_data_type_or_param_t *data_type_or_param = calloc(1, sizeof(*data_type_or_param));

    data_type_or_param->super.print = _ast_data_type_or_param_print;
    data_type_or_param->super.free = _ast_data_type_or_param_free;

    data_type_or_param->data_type = data_type;

    return (ast_node_t *)data_type_or_param;
}

static void _ast_data_type_or_param_print(ast_node_t *node, int indent, int indent_incr) {
    ast_data_type_or_param_t *data_type_or_param = (ast_data_type_or_param_t *)node;

    ast_node_print(data_type_or_param->data_type, indent, indent_incr);
}

static void _ast_data_type_or_param_free(ast_node_t *node) {
    ast_data_type_or_param_t *data_type_or_param = (ast_data_type_or_param_t *)node;

    ast_node_free(data_type_or_param->data_type);
}
