#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_modport_simple_port_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_modport_simple_port_free(ast_node_t *node);

ast_node_t* ast_modport_simple_port_new(ast_node_t *identifier, ast_node_t *expression) {
    ast_modport_simple_port_t *modport_simple_port = calloc(1, sizeof(*modport_simple_port));

    modport_simple_port->super.print = _ast_modport_simple_port_print;
    modport_simple_port->super.free = _ast_modport_simple_port_free;

    modport_simple_port->identifier = identifier;
    modport_simple_port->expression = expression;

    return (ast_node_t *)modport_simple_port;
}

static void _ast_modport_simple_port_print(ast_node_t *node, int indent, int indent_incr) {
    ast_modport_simple_port_t *modport_simple_port = (ast_modport_simple_port_t *)node;

    ast_node_print(modport_simple_port->identifier, indent, indent_incr);
    ast_node_print(modport_simple_port->expression, indent, indent_incr);
}

static void _ast_modport_simple_port_free(ast_node_t *node) {
    ast_modport_simple_port_t *modport_simple_port = (ast_modport_simple_port_t *)node;

    ast_node_free(modport_simple_port->identifier);
    ast_node_free(modport_simple_port->expression);
}
