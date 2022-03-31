#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_overload_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_overload_declaration_free(ast_node_t *node);

ast_node_t* ast_overload_declaration_new(ast_node_t *identifier, ast_node_t *data_type, ast_node_t *overload_proto_formals, ast_overload_operator_t overload_operator) {
    ast_overload_declaration_t *overload_declaration = calloc(1, sizeof(*overload_declaration));

    overload_declaration->super.print = _ast_overload_declaration_print;
    overload_declaration->super.free = _ast_overload_declaration_free;

    overload_declaration->identifier = identifier;
    overload_declaration->data_type = data_type;
    overload_declaration->overload_proto_formals = overload_proto_formals;
    overload_declaration->overload_operator = overload_operator;

    return (ast_node_t *)overload_declaration;
}

static void _ast_overload_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_overload_declaration_t *overload_declaration = (ast_overload_declaration_t *)node;

    ast_node_print(overload_declaration->identifier, indent, indent_incr);
    ast_node_print(overload_declaration->data_type, indent, indent_incr);
    ast_node_print(overload_declaration->overload_proto_formals, indent, indent_incr);
    ast_overload_operator_print(overload_declaration->overload_operator);
}

static void _ast_overload_declaration_free(ast_node_t *node) {
    ast_overload_declaration_t *overload_declaration = (ast_overload_declaration_t *)node;

    ast_node_free(overload_declaration->identifier);
    ast_node_free(overload_declaration->data_type);
    ast_node_free(overload_declaration->overload_proto_formals);
}
