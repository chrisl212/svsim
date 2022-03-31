#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_type_assignment_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_type_assignment_free(ast_node_t *node);

ast_node_t* ast_type_assignment_new(ast_node_t *identifier, ast_node_t *data_type) {
    ast_type_assignment_t *type_assignment = calloc(1, sizeof(*type_assignment));

    type_assignment->super.print = _ast_type_assignment_print;
    type_assignment->super.free = _ast_type_assignment_free;

    type_assignment->identifier = identifier;
    type_assignment->data_type = data_type;

    return (ast_node_t *)type_assignment;
}

static void _ast_type_assignment_print(ast_node_t *node, int indent, int indent_incr) {
    ast_type_assignment_t *type_assignment = (ast_type_assignment_t *)node;

    ast_node_print(type_assignment->identifier, indent, indent_incr);
    ast_node_print(type_assignment->data_type, indent, indent_incr);
}

static void _ast_type_assignment_free(ast_node_t *node) {
    ast_type_assignment_t *type_assignment = (ast_type_assignment_t *)node;

    ast_node_free(type_assignment->identifier);
    ast_node_free(type_assignment->data_type);
}
