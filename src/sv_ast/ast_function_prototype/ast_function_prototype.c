#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_function_prototype_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_function_prototype_free(ast_node_t *node);

ast_node_t* ast_function_prototype_new(ast_node_t *function_type_name, ast_node_t *tf_port_list) {
    ast_function_prototype_t *function_prototype = calloc(1, sizeof(*function_prototype));

    function_prototype->super.print = _ast_function_prototype_print;
    function_prototype->super.free = _ast_function_prototype_free;

    function_prototype->function_type_name = function_type_name;
    function_prototype->tf_port_list = tf_port_list;

    return (ast_node_t *)function_prototype;
}

static void _ast_function_prototype_print(ast_node_t *node, int indent, int indent_incr) {
    ast_function_prototype_t *function_prototype = (ast_function_prototype_t *)node;

    ast_node_print(function_prototype->function_type_name, indent, indent_incr);
    ast_node_print(function_prototype->tf_port_list, indent, indent_incr);
}

static void _ast_function_prototype_free(ast_node_t *node) {
    ast_function_prototype_t *function_prototype = (ast_function_prototype_t *)node;

    ast_node_free(function_prototype->function_type_name);
    ast_node_free(function_prototype->tf_port_list);
}
