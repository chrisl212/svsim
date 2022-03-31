#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_clocking_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_clocking_declaration_free(ast_node_t *node);

ast_node_t* ast_clocking_declaration_new(ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *clocking_item_list, ast_node_t *clocking_event) {
    ast_clocking_declaration_t *clocking_declaration = calloc(1, sizeof(*clocking_declaration));

    clocking_declaration->super.print = _ast_clocking_declaration_print;
    clocking_declaration->super.free = _ast_clocking_declaration_free;

    clocking_declaration->identifier = identifier;
    clocking_declaration->block_end_identifier = block_end_identifier;
    clocking_declaration->clocking_item_list = clocking_item_list;
    clocking_declaration->clocking_event = clocking_event;

    return (ast_node_t *)clocking_declaration;
}

static void _ast_clocking_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_clocking_declaration_t *clocking_declaration = (ast_clocking_declaration_t *)node;

    ast_node_print(clocking_declaration->identifier, indent, indent_incr);
    ast_node_print(clocking_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(clocking_declaration->clocking_item_list, indent, indent_incr);
    ast_node_print(clocking_declaration->clocking_event, indent, indent_incr);
}

static void _ast_clocking_declaration_free(ast_node_t *node) {
    ast_clocking_declaration_t *clocking_declaration = (ast_clocking_declaration_t *)node;

    ast_node_free(clocking_declaration->identifier);
    ast_node_free(clocking_declaration->block_end_identifier);
    ast_node_free(clocking_declaration->clocking_item_list);
    ast_node_free(clocking_declaration->clocking_event);
}
