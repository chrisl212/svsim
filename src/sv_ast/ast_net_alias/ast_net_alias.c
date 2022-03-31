#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_net_alias_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_net_alias_free(ast_node_t *node);

ast_node_t* ast_net_alias_new(ast_node_t *lvalue1, ast_node_t *lvalue0, ast_node_t *lvalue_list) {
    ast_net_alias_t *net_alias = calloc(1, sizeof(*net_alias));

    net_alias->super.print = _ast_net_alias_print;
    net_alias->super.free = _ast_net_alias_free;

    net_alias->lvalue1 = lvalue1;
    net_alias->lvalue0 = lvalue0;
    net_alias->lvalue_list = lvalue_list;

    return (ast_node_t *)net_alias;
}

static void _ast_net_alias_print(ast_node_t *node, int indent, int indent_incr) {
    ast_net_alias_t *net_alias = (ast_net_alias_t *)node;

    ast_node_print(net_alias->lvalue1, indent, indent_incr);
    ast_node_print(net_alias->lvalue0, indent, indent_incr);
    ast_node_print(net_alias->lvalue_list, indent, indent_incr);
}

static void _ast_net_alias_free(ast_node_t *node) {
    ast_net_alias_t *net_alias = (ast_net_alias_t *)node;

    ast_node_free(net_alias->lvalue1);
    ast_node_free(net_alias->lvalue0);
    ast_node_free(net_alias->lvalue_list);
}
