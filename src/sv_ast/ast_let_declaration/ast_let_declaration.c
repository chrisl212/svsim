#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_let_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_let_declaration_free(ast_node_t *node);

ast_node_t* ast_let_declaration_new(ast_node_t *identifier, ast_node_t *expression, ast_node_t *let_port_list) {
    ast_let_declaration_t *let_declaration = calloc(1, sizeof(*let_declaration));

    let_declaration->super.print = _ast_let_declaration_print;
    let_declaration->super.free = _ast_let_declaration_free;

    let_declaration->identifier = identifier;
    let_declaration->expression = expression;
    let_declaration->let_port_list = let_port_list;

    return (ast_node_t *)let_declaration;
}

static void _ast_let_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_let_declaration_t *let_declaration = (ast_let_declaration_t *)node;

    ast_node_print(let_declaration->identifier, indent, indent_incr);
    ast_node_print(let_declaration->expression, indent, indent_incr);
    ast_node_print(let_declaration->let_port_list, indent, indent_incr);
}

static void _ast_let_declaration_free(ast_node_t *node) {
    ast_let_declaration_t *let_declaration = (ast_let_declaration_t *)node;

    ast_node_free(let_declaration->identifier);
    ast_node_free(let_declaration->expression);
    ast_node_free(let_declaration->let_port_list);
}
