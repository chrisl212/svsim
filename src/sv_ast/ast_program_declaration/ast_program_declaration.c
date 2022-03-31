#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_program_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_program_declaration_free(ast_node_t *node);

ast_node_t* ast_program_declaration_new(ast_node_t *timeunits_declaration, ast_node_t *non_port_program_item_list, ast_node_t *program_ansi_header, ast_node_t *program_item_list, ast_node_t *block_end_identifier, ast_node_t *program_nonansi_header) {
    ast_program_declaration_t *program_declaration = calloc(1, sizeof(*program_declaration));

    program_declaration->super.print = _ast_program_declaration_print;
    program_declaration->super.free = _ast_program_declaration_free;

    program_declaration->timeunits_declaration = timeunits_declaration;
    program_declaration->non_port_program_item_list = non_port_program_item_list;
    program_declaration->program_ansi_header = program_ansi_header;
    program_declaration->program_item_list = program_item_list;
    program_declaration->block_end_identifier = block_end_identifier;
    program_declaration->program_nonansi_header = program_nonansi_header;

    return (ast_node_t *)program_declaration;
}

static void _ast_program_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_program_declaration_t *program_declaration = (ast_program_declaration_t *)node;

    ast_node_print(program_declaration->timeunits_declaration, indent, indent_incr);
    ast_node_print(program_declaration->non_port_program_item_list, indent, indent_incr);
    ast_node_print(program_declaration->program_ansi_header, indent, indent_incr);
    ast_node_print(program_declaration->program_item_list, indent, indent_incr);
    ast_node_print(program_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(program_declaration->program_nonansi_header, indent, indent_incr);
}

static void _ast_program_declaration_free(ast_node_t *node) {
    ast_program_declaration_t *program_declaration = (ast_program_declaration_t *)node;

    ast_node_free(program_declaration->timeunits_declaration);
    ast_node_free(program_declaration->non_port_program_item_list);
    ast_node_free(program_declaration->program_ansi_header);
    ast_node_free(program_declaration->program_item_list);
    ast_node_free(program_declaration->block_end_identifier);
    ast_node_free(program_declaration->program_nonansi_header);
}
