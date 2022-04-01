#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_time_literal_print(ast_node_t *node, int indent, int indent_incr);

ast_node_t* ast_time_literal_new(double literal, ast_time_unit_t time_unit) {
    ast_time_literal_t *time_literal = calloc(1, sizeof(*time_literal));

    time_literal->super.print = _ast_time_literal_print;

    time_literal->literal = literal;
    time_literal->time_unit = time_unit;

    return (ast_node_t *)time_literal;
}

static void _ast_time_literal_print(ast_node_t *node, int indent, int indent_incr) {
    ast_time_literal_t *time_literal = (ast_time_literal_t *)node;

    printf("%.0lf", time_literal->literal);
    ast_time_unit_print(time_literal->time_unit);
}
