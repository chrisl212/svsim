#include <stdlib.h>
#include <stdio.h>
#include "ast_time_literal.h"

static void _ast_time_literal_print(ast_node_t *node);
static const char* _unit_to_str(ast_time_unit_t unit);

ast_time_literal_t* ast_time_literal_new(double value, ast_time_unit_t unit) {
    ast_time_literal_t *lit = calloc(1, sizeof(*lit));

    lit->super.print = _ast_time_literal_print;
    lit->value = value;
    lit->unit = unit;

    return lit;
}

static void _ast_time_literal_print(ast_node_t *node) {
    ast_time_literal_t *lit = (ast_time_literal_t *)node;

    printf("%.0f%s", lit->value, _unit_to_str(lit->unit));
}

static const char* _unit_to_str(ast_time_unit_t unit) {
    switch (unit) {
        case AST_TIME_UNIT_S:  return "s";
        case AST_TIME_UNIT_MS: return "ms";
        case AST_TIME_UNIT_US: return "us";
        case AST_TIME_UNIT_NS: return "ns";
        case AST_TIME_UNIT_PS: return "ps";
        case AST_TIME_UNIT_FS: return "fs";
    }
    return "XX";
}
