#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_modport_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_modport_item_free(ast_node_t *node);

ast_node_t* ast_modport_item_new(ast_node_t *identifier, ast_node_t *modport_ports_declaration_list) {
    ast_modport_item_t *modport_item = calloc(1, sizeof(*modport_item));

    modport_item->super.print = _ast_modport_item_print;
    modport_item->super.free = _ast_modport_item_free;

    modport_item->identifier = identifier;
    modport_item->modport_ports_declaration_list = modport_ports_declaration_list;

    return (ast_node_t *)modport_item;
}

static void _ast_modport_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_modport_item_t *modport_item = (ast_modport_item_t *)node;

    ast_node_print(modport_item->identifier, indent, indent_incr);
    ast_node_print(modport_item->modport_ports_declaration_list, indent, indent_incr);
}

static void _ast_modport_item_free(ast_node_t *node) {
    ast_modport_item_t *modport_item = (ast_modport_item_t *)node;

    ast_node_free(modport_item->identifier);
    ast_node_free(modport_item->modport_ports_declaration_list);
}
