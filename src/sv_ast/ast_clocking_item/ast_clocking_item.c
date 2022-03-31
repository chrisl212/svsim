#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_clocking_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_clocking_item_free(ast_node_t *node);

ast_node_t* ast_clocking_item_new(ast_node_t *default_skew, ast_node_t *clocking_direction, ast_node_t *clocking_decl_assign_list, ast_node_t *assertion_item_declaration) {
    ast_clocking_item_t *clocking_item = calloc(1, sizeof(*clocking_item));

    clocking_item->super.print = _ast_clocking_item_print;
    clocking_item->super.free = _ast_clocking_item_free;

    clocking_item->default_skew = default_skew;
    clocking_item->clocking_direction = clocking_direction;
    clocking_item->clocking_decl_assign_list = clocking_decl_assign_list;
    clocking_item->assertion_item_declaration = assertion_item_declaration;

    return (ast_node_t *)clocking_item;
}

static void _ast_clocking_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_clocking_item_t *clocking_item = (ast_clocking_item_t *)node;

    ast_node_print(clocking_item->default_skew, indent, indent_incr);
    ast_node_print(clocking_item->clocking_direction, indent, indent_incr);
    ast_node_print(clocking_item->clocking_decl_assign_list, indent, indent_incr);
    ast_node_print(clocking_item->assertion_item_declaration, indent, indent_incr);
}

static void _ast_clocking_item_free(ast_node_t *node) {
    ast_clocking_item_t *clocking_item = (ast_clocking_item_t *)node;

    ast_node_free(clocking_item->default_skew);
    ast_node_free(clocking_item->clocking_direction);
    ast_node_free(clocking_item->clocking_decl_assign_list);
    ast_node_free(clocking_item->assertion_item_declaration);
}
