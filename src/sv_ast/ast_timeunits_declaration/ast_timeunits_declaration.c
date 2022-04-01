#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_timeunits_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_timeunits_declaration_free(ast_node_t *node);

ast_node_t* ast_timeunits_declaration_new(ast_node_t *time_unit, ast_node_t *time_precision) {
    ast_timeunits_declaration_t *timeunits_declaration = calloc(1, sizeof(*timeunits_declaration));

    timeunits_declaration->super.print = _ast_timeunits_declaration_print;
    timeunits_declaration->super.free = _ast_timeunits_declaration_free;

    timeunits_declaration->time_unit = time_unit;
    timeunits_declaration->time_precision = time_precision;

    return (ast_node_t *)timeunits_declaration;
}

static void _ast_timeunits_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_timeunits_declaration_t *timeunits_declaration = (ast_timeunits_declaration_t *)node;

    if (timeunits_declaration->time_unit) {
        printf("timeunit ");
        ast_node_print(timeunits_declaration->time_unit, indent, indent_incr);
        printf(" / ");
        ast_node_print(timeunits_declaration->time_precision, indent, indent_incr);
    } else {
        printf("timeprecision ");
        ast_node_print(timeunits_declaration->time_precision, indent, indent_incr);
    }
    printf(";");
}

static void _ast_timeunits_declaration_free(ast_node_t *node) {
    ast_timeunits_declaration_t *timeunits_declaration = (ast_timeunits_declaration_t *)node;

    ast_node_free(timeunits_declaration->time_unit);
    ast_node_free(timeunits_declaration->time_precision);
}
