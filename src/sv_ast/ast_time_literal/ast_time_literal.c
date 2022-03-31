#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_time_literal_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_time_literal_free(ast_node_t *node);

ast_node_t* ast_time_literal_new(ast_node_t *unsigned_number, ast_time_unit_t time_unit, ast_node_t *fixed_point_number) {
    ast_time_literal_t *time_literal = calloc(1, sizeof(*time_literal));

    time_literal->super.print = _ast_time_literal_print;
    time_literal->super.free = _ast_time_literal_free;

    time_literal->unsigned_number = unsigned_number;
    time_literal->time_unit = time_unit;
    time_literal->fixed_point_number = fixed_point_number;

    return (ast_node_t *)time_literal;
}

static void _ast_time_literal_print(ast_node_t *node, int indent, int indent_incr) {
    ast_time_literal_t *time_literal = (ast_time_literal_t *)node;

    ast_node_print(time_literal->unsigned_number, indent, indent_incr);
    ast_time_unit_print(time_literal->time_unit);
    ast_node_print(time_literal->fixed_point_number, indent, indent_incr);
}

static void _ast_time_literal_free(ast_node_t *node) {
    ast_time_literal_t *time_literal = (ast_time_literal_t *)node;

    ast_node_free(time_literal->unsigned_number);
    ast_node_free(time_literal->fixed_point_number);
}
