#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_combinational_entry_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_combinational_entry_free(ast_node_t *node);

ast_node_t* ast_combinational_entry_new(ast_node_t *output_symbol, ast_node_t *level_input_list) {
    ast_combinational_entry_t *combinational_entry = calloc(1, sizeof(*combinational_entry));

    combinational_entry->super.print = _ast_combinational_entry_print;
    combinational_entry->super.free = _ast_combinational_entry_free;

    combinational_entry->output_symbol = output_symbol;
    combinational_entry->level_input_list = level_input_list;

    return (ast_node_t *)combinational_entry;
}

static void _ast_combinational_entry_print(ast_node_t *node, int indent, int indent_incr) {
    ast_combinational_entry_t *combinational_entry = (ast_combinational_entry_t *)node;

    ast_node_print(combinational_entry->output_symbol, indent, indent_incr);
    ast_node_print(combinational_entry->level_input_list, indent, indent_incr);
}

static void _ast_combinational_entry_free(ast_node_t *node) {
    ast_combinational_entry_t *combinational_entry = (ast_combinational_entry_t *)node;

    ast_node_free(combinational_entry->output_symbol);
    ast_node_free(combinational_entry->level_input_list);
}
