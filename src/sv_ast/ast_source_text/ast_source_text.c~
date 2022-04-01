#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_source_text_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_source_text_free(ast_node_t *node);

ast_node_t* ast_source_text_new(ast_node_t *timeunits_declaration, ast_node_t *description_list) {
    ast_source_text_t *source_text = calloc(1, sizeof(*source_text));

    source_text->super.print = _ast_source_text_print;
    source_text->super.free = _ast_source_text_free;

    source_text->timeunits_declaration = timeunits_declaration;
    source_text->description_list = description_list;

    return (ast_node_t *)source_text;
}

static void _ast_source_text_print(ast_node_t *node, int indent, int indent_incr) {
    ast_source_text_t *source_text = (ast_source_text_t *)node;

    ast_node_print(source_text->timeunits_declaration, indent, indent_incr);
    ast_node_print(source_text->description_list, indent, indent_incr);
}

static void _ast_source_text_free(ast_node_t *node) {
    ast_source_text_t *source_text = (ast_source_text_t *)node;

    ast_node_free(source_text->timeunits_declaration);
    ast_node_free(source_text->description_list);
}
