#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_class_new_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_class_new_free(ast_node_t *node);

ast_node_t* ast_class_new_new(ast_node_t *class_scope, ast_node_t *expression, ast_node_t *argument_list) {
    ast_class_new_t *class_new = calloc(1, sizeof(*class_new));

    class_new->super.print = _ast_class_new_print;
    class_new->super.free = _ast_class_new_free;

    class_new->class_scope = class_scope;
    class_new->expression = expression;
    class_new->argument_list = argument_list;

    return (ast_node_t *)class_new;
}

static void _ast_class_new_print(ast_node_t *node, int indent, int indent_incr) {
    ast_class_new_t *class_new = (ast_class_new_t *)node;

    ast_node_print(class_new->class_scope, indent, indent_incr);
    ast_node_print(class_new->expression, indent, indent_incr);
    ast_node_print(class_new->argument_list, indent, indent_incr);
}

static void _ast_class_new_free(ast_node_t *node) {
    ast_class_new_t *class_new = (ast_class_new_t *)node;

    ast_node_free(class_new->class_scope);
    ast_node_free(class_new->expression);
    ast_node_free(class_new->argument_list);
}
