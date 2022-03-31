#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_cond_predicate_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_cond_predicate_free(ast_node_t *node);

ast_node_t* ast_cond_predicate_new(ast_node_t *expression_or_cond_pattern, ast_node_t *expression_or_cond_pattern0, ast_node_t *expression_or_cond_pattern1) {
    ast_cond_predicate_t *cond_predicate = calloc(1, sizeof(*cond_predicate));

    cond_predicate->super.print = _ast_cond_predicate_print;
    cond_predicate->super.free = _ast_cond_predicate_free;

    cond_predicate->expression_or_cond_pattern = expression_or_cond_pattern;
    cond_predicate->expression_or_cond_pattern0 = expression_or_cond_pattern0;
    cond_predicate->expression_or_cond_pattern1 = expression_or_cond_pattern1;

    return (ast_node_t *)cond_predicate;
}

static void _ast_cond_predicate_print(ast_node_t *node, int indent, int indent_incr) {
    ast_cond_predicate_t *cond_predicate = (ast_cond_predicate_t *)node;

    ast_node_print(cond_predicate->expression_or_cond_pattern, indent, indent_incr);
    ast_node_print(cond_predicate->expression_or_cond_pattern0, indent, indent_incr);
    ast_node_print(cond_predicate->expression_or_cond_pattern1, indent, indent_incr);
}

static void _ast_cond_predicate_free(ast_node_t *node) {
    ast_cond_predicate_t *cond_predicate = (ast_cond_predicate_t *)node;

    ast_node_free(cond_predicate->expression_or_cond_pattern);
    ast_node_free(cond_predicate->expression_or_cond_pattern0);
    ast_node_free(cond_predicate->expression_or_cond_pattern1);
}
