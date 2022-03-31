#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_type_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_type_declaration_free(ast_node_t *node);

ast_node_t* ast_type_declaration_new(ast_node_t *identifier, ast_node_t *data_type) {
    ast_type_declaration_t *type_declaration = calloc(1, sizeof(*type_declaration));

    type_declaration->super.print = _ast_type_declaration_print;
    type_declaration->super.free = _ast_type_declaration_free;

    type_declaration->identifier = identifier;
    type_declaration->data_type = data_type;

    return (ast_node_t *)type_declaration;
}

static void _ast_type_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_type_declaration_t *type_declaration = (ast_type_declaration_t *)node;

    ast_node_print(type_declaration->identifier, indent, indent_incr);
    ast_node_print(type_declaration->data_type, indent, indent_incr);
}

static void _ast_type_declaration_free(ast_node_t *node) {
    ast_type_declaration_t *type_declaration = (ast_type_declaration_t *)node;

    ast_node_free(type_declaration->identifier);
    ast_node_free(type_declaration->data_type);
}
