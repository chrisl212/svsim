#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_procedural_timing_control_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_procedural_timing_control_statement_free(ast_node_t *node);

ast_node_t* ast_procedural_timing_control_statement_new(ast_node_t *statement, ast_node_t *procedural_timing_control) {
    ast_procedural_timing_control_statement_t *procedural_timing_control_statement = calloc(1, sizeof(*procedural_timing_control_statement));

    procedural_timing_control_statement->super.print = _ast_procedural_timing_control_statement_print;
    procedural_timing_control_statement->super.free = _ast_procedural_timing_control_statement_free;

    procedural_timing_control_statement->statement = statement;
    procedural_timing_control_statement->procedural_timing_control = procedural_timing_control;

    return (ast_node_t *)procedural_timing_control_statement;
}

static void _ast_procedural_timing_control_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_procedural_timing_control_statement_t *procedural_timing_control_statement = (ast_procedural_timing_control_statement_t *)node;

    ast_node_print(procedural_timing_control_statement->statement, indent, indent_incr);
    ast_node_print(procedural_timing_control_statement->procedural_timing_control, indent, indent_incr);
}

static void _ast_procedural_timing_control_statement_free(ast_node_t *node) {
    ast_procedural_timing_control_statement_t *procedural_timing_control_statement = (ast_procedural_timing_control_statement_t *)node;

    ast_node_free(procedural_timing_control_statement->statement);
    ast_node_free(procedural_timing_control_statement->procedural_timing_control);
}
