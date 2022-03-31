#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_task_prototype_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_task_prototype_free(ast_node_t *node);

ast_node_t* ast_task_prototype_new(ast_node_t *ps_or_hierarchical_identifier, ast_node_t *tf_port_list) {
    ast_task_prototype_t *task_prototype = calloc(1, sizeof(*task_prototype));

    task_prototype->super.print = _ast_task_prototype_print;
    task_prototype->super.free = _ast_task_prototype_free;

    task_prototype->ps_or_hierarchical_identifier = ps_or_hierarchical_identifier;
    task_prototype->tf_port_list = tf_port_list;

    return (ast_node_t *)task_prototype;
}

static void _ast_task_prototype_print(ast_node_t *node, int indent, int indent_incr) {
    ast_task_prototype_t *task_prototype = (ast_task_prototype_t *)node;

    ast_node_print(task_prototype->ps_or_hierarchical_identifier, indent, indent_incr);
    ast_node_print(task_prototype->tf_port_list, indent, indent_incr);
}

static void _ast_task_prototype_free(ast_node_t *node) {
    ast_task_prototype_t *task_prototype = (ast_task_prototype_t *)node;

    ast_node_free(task_prototype->ps_or_hierarchical_identifier);
    ast_node_free(task_prototype->tf_port_list);
}
