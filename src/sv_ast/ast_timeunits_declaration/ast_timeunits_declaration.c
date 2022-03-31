#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_timeunits_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_timeunits_declaration_free(ast_node_t *node);

ast_node_t* ast_timeunits_declaration_new(ast_node_t *time_literal1, ast_node_t *time_literal, ast_node_t *time_literal0) {
    ast_timeunits_declaration_t *timeunits_declaration = calloc(1, sizeof(*timeunits_declaration));

    timeunits_declaration->super.print = _ast_timeunits_declaration_print;
    timeunits_declaration->super.free = _ast_timeunits_declaration_free;

    timeunits_declaration->time_literal1 = time_literal1;
    timeunits_declaration->time_literal = time_literal;
    timeunits_declaration->time_literal0 = time_literal0;

    return (ast_node_t *)timeunits_declaration;
}

static void _ast_timeunits_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_timeunits_declaration_t *timeunits_declaration = (ast_timeunits_declaration_t *)node;

    ast_node_print(timeunits_declaration->time_literal1, indent, indent_incr);
    ast_node_print(timeunits_declaration->time_literal, indent, indent_incr);
    ast_node_print(timeunits_declaration->time_literal0, indent, indent_incr);
}

static void _ast_timeunits_declaration_free(ast_node_t *node) {
    ast_timeunits_declaration_t *timeunits_declaration = (ast_timeunits_declaration_t *)node;

    ast_node_free(timeunits_declaration->time_literal1);
    ast_node_free(timeunits_declaration->time_literal);
    ast_node_free(timeunits_declaration->time_literal0);
}
