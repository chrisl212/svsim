#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_let_port_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_let_port_item_free(ast_node_t *node);

ast_node_t* ast_let_port_item_new(ast_node_t *identifier, ast_node_t *expression, ast_node_t *let_formal_type, ast_node_t *variable_dimension_list) {
    ast_let_port_item_t *let_port_item = calloc(1, sizeof(*let_port_item));

    let_port_item->super.print = _ast_let_port_item_print;
    let_port_item->super.free = _ast_let_port_item_free;

    let_port_item->identifier = identifier;
    let_port_item->expression = expression;
    let_port_item->let_formal_type = let_formal_type;
    let_port_item->variable_dimension_list = variable_dimension_list;

    return (ast_node_t *)let_port_item;
}

static void _ast_let_port_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_let_port_item_t *let_port_item = (ast_let_port_item_t *)node;

    ast_node_print(let_port_item->identifier, indent, indent_incr);
    ast_node_print(let_port_item->expression, indent, indent_incr);
    ast_node_print(let_port_item->let_formal_type, indent, indent_incr);
    ast_node_print(let_port_item->variable_dimension_list, indent, indent_incr);
}

static void _ast_let_port_item_free(ast_node_t *node) {
    ast_let_port_item_t *let_port_item = (ast_let_port_item_t *)node;

    ast_node_free(let_port_item->identifier);
    ast_node_free(let_port_item->expression);
    ast_node_free(let_port_item->let_formal_type);
    ast_node_free(let_port_item->variable_dimension_list);
}
