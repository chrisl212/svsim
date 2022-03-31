#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_default_skew_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_default_skew_free(ast_node_t *node);

ast_node_t* ast_default_skew_new(ast_node_t *clocking_skew0, ast_node_t *clocking_skew1, ast_node_t *clocking_skew) {
    ast_default_skew_t *default_skew = calloc(1, sizeof(*default_skew));

    default_skew->super.print = _ast_default_skew_print;
    default_skew->super.free = _ast_default_skew_free;

    default_skew->clocking_skew0 = clocking_skew0;
    default_skew->clocking_skew1 = clocking_skew1;
    default_skew->clocking_skew = clocking_skew;

    return (ast_node_t *)default_skew;
}

static void _ast_default_skew_print(ast_node_t *node, int indent, int indent_incr) {
    ast_default_skew_t *default_skew = (ast_default_skew_t *)node;

    ast_node_print(default_skew->clocking_skew0, indent, indent_incr);
    ast_node_print(default_skew->clocking_skew1, indent, indent_incr);
    ast_node_print(default_skew->clocking_skew, indent, indent_incr);
}

static void _ast_default_skew_free(ast_node_t *node) {
    ast_default_skew_t *default_skew = (ast_default_skew_t *)node;

    ast_node_free(default_skew->clocking_skew0);
    ast_node_free(default_skew->clocking_skew1);
    ast_node_free(default_skew->clocking_skew);
}
