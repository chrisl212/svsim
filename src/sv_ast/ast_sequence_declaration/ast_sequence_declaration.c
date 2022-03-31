#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_sequence_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_sequence_declaration_free(ast_node_t *node);

ast_node_t* ast_sequence_declaration_new(ast_node_t *identifier, ast_node_t *assertion_variable_declaration_list, ast_node_t *sequence_expr, ast_node_t *block_end_identifier, ast_node_t *sequence_port_list) {
    ast_sequence_declaration_t *sequence_declaration = calloc(1, sizeof(*sequence_declaration));

    sequence_declaration->super.print = _ast_sequence_declaration_print;
    sequence_declaration->super.free = _ast_sequence_declaration_free;

    sequence_declaration->identifier = identifier;
    sequence_declaration->assertion_variable_declaration_list = assertion_variable_declaration_list;
    sequence_declaration->sequence_expr = sequence_expr;
    sequence_declaration->block_end_identifier = block_end_identifier;
    sequence_declaration->sequence_port_list = sequence_port_list;

    return (ast_node_t *)sequence_declaration;
}

static void _ast_sequence_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_sequence_declaration_t *sequence_declaration = (ast_sequence_declaration_t *)node;

    ast_node_print(sequence_declaration->identifier, indent, indent_incr);
    ast_node_print(sequence_declaration->assertion_variable_declaration_list, indent, indent_incr);
    ast_node_print(sequence_declaration->sequence_expr, indent, indent_incr);
    ast_node_print(sequence_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(sequence_declaration->sequence_port_list, indent, indent_incr);
}

static void _ast_sequence_declaration_free(ast_node_t *node) {
    ast_sequence_declaration_t *sequence_declaration = (ast_sequence_declaration_t *)node;

    ast_node_free(sequence_declaration->identifier);
    ast_node_free(sequence_declaration->assertion_variable_declaration_list);
    ast_node_free(sequence_declaration->sequence_expr);
    ast_node_free(sequence_declaration->block_end_identifier);
    ast_node_free(sequence_declaration->sequence_port_list);
}
