#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_class_method_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_class_method_free(ast_node_t *node);

ast_node_t* ast_class_method_new(ast_node_t *method_prototype, ast_node_t *class_method_qualifier_list, ast_node_t *task_declaration, ast_node_t *function_declaration) {
    ast_class_method_t *class_method = calloc(1, sizeof(*class_method));

    class_method->super.print = _ast_class_method_print;
    class_method->super.free = _ast_class_method_free;

    class_method->method_prototype = method_prototype;
    class_method->class_method_qualifier_list = class_method_qualifier_list;
    class_method->task_declaration = task_declaration;
    class_method->function_declaration = function_declaration;

    return (ast_node_t *)class_method;
}

static void _ast_class_method_print(ast_node_t *node, int indent, int indent_incr) {
    ast_class_method_t *class_method = (ast_class_method_t *)node;

    ast_node_print(class_method->method_prototype, indent, indent_incr);
    ast_node_print(class_method->class_method_qualifier_list, indent, indent_incr);
    ast_node_print(class_method->task_declaration, indent, indent_incr);
    ast_node_print(class_method->function_declaration, indent, indent_incr);
}

static void _ast_class_method_free(ast_node_t *node) {
    ast_class_method_t *class_method = (ast_class_method_t *)node;

    ast_node_free(class_method->method_prototype);
    ast_node_free(class_method->class_method_qualifier_list);
    ast_node_free(class_method->task_declaration);
    ast_node_free(class_method->function_declaration);
}
