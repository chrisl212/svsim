#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_named_port_connection_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_named_port_connection_free(ast_node_t *node);

ast_node_t* ast_named_port_connection_new(ast_node_t *identifier, ast_node_t *expression) {
    ast_named_port_connection_t *named_port_connection = calloc(1, sizeof(*named_port_connection));

    named_port_connection->super.print = _ast_named_port_connection_print;
    named_port_connection->super.free = _ast_named_port_connection_free;

    named_port_connection->identifier = identifier;
    named_port_connection->expression = expression;

    return (ast_node_t *)named_port_connection;
}

static void _ast_named_port_connection_print(ast_node_t *node, int indent, int indent_incr) {
    ast_named_port_connection_t *named_port_connection = (ast_named_port_connection_t *)node;

    ast_node_print(named_port_connection->identifier, indent, indent_incr);
    ast_node_print(named_port_connection->expression, indent, indent_incr);
}

static void _ast_named_port_connection_free(ast_node_t *node) {
    ast_named_port_connection_t *named_port_connection = (ast_named_port_connection_t *)node;

    ast_node_free(named_port_connection->identifier);
    ast_node_free(named_port_connection->expression);
}
