#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_class_property_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_class_property_free(ast_node_t *node);

ast_node_t* ast_class_property_new(ast_node_t *verify, ast_node_t *modifiers, ast_node_t *data_declaration, ast_node_t *correct, ast_node_t *only) {
    ast_class_property_t *class_property = calloc(1, sizeof(*class_property));

    class_property->super.print = _ast_class_property_print;
    class_property->super.free = _ast_class_property_free;

    class_property->verify = verify;
    class_property->modifiers = modifiers;
    class_property->data_declaration = data_declaration;
    class_property->correct = correct;
    class_property->only = only;

    return (ast_node_t *)class_property;
}

static void _ast_class_property_print(ast_node_t *node, int indent, int indent_incr) {
    ast_class_property_t *class_property = (ast_class_property_t *)node;

    ast_node_print(class_property->verify, indent, indent_incr);
    ast_node_print(class_property->modifiers, indent, indent_incr);
    ast_node_print(class_property->data_declaration, indent, indent_incr);
    ast_node_print(class_property->correct, indent, indent_incr);
    ast_node_print(class_property->only, indent, indent_incr);
}

static void _ast_class_property_free(ast_node_t *node) {
    ast_class_property_t *class_property = (ast_class_property_t *)node;

    ast_node_free(class_property->verify);
    ast_node_free(class_property->modifiers);
    ast_node_free(class_property->data_declaration);
    ast_node_free(class_property->correct);
    ast_node_free(class_property->only);
}
