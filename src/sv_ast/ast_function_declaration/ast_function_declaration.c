#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_function_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_function_declaration_free(ast_node_t *node);

ast_node_t* ast_function_declaration_new(ast_node_t *function_body_declaration, ast_lifetime_t lifetime) {
    ast_function_declaration_t *function_declaration = calloc(1, sizeof(*function_declaration));

    function_declaration->super.print = _ast_function_declaration_print;
    function_declaration->super.free = _ast_function_declaration_free;

    function_declaration->function_body_declaration = function_body_declaration;
    function_declaration->lifetime = lifetime;

    return (ast_node_t *)function_declaration;
}

static void _ast_function_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_function_declaration_t *function_declaration = (ast_function_declaration_t *)node;

    ast_node_print(function_declaration->function_body_declaration, indent, indent_incr);
    ast_lifetime_print(function_declaration->lifetime);
}

static void _ast_function_declaration_free(ast_node_t *node) {
    ast_function_declaration_t *function_declaration = (ast_function_declaration_t *)node;

    ast_node_free(function_declaration->function_body_declaration);
}
