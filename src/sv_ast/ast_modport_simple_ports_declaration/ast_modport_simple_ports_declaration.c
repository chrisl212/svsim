#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_modport_simple_ports_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_modport_simple_ports_declaration_free(ast_node_t *node);

ast_node_t* ast_modport_simple_ports_declaration_new(ast_node_t *modport_simple_port, ast_port_direction_t port_direction) {
    ast_modport_simple_ports_declaration_t *modport_simple_ports_declaration = calloc(1, sizeof(*modport_simple_ports_declaration));

    modport_simple_ports_declaration->super.print = _ast_modport_simple_ports_declaration_print;
    modport_simple_ports_declaration->super.free = _ast_modport_simple_ports_declaration_free;

    modport_simple_ports_declaration->modport_simple_port = modport_simple_port;
    modport_simple_ports_declaration->port_direction = port_direction;

    return (ast_node_t *)modport_simple_ports_declaration;
}

static void _ast_modport_simple_ports_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_modport_simple_ports_declaration_t *modport_simple_ports_declaration = (ast_modport_simple_ports_declaration_t *)node;

    ast_node_print(modport_simple_ports_declaration->modport_simple_port, indent, indent_incr);
    ast_port_direction_print(modport_simple_ports_declaration->port_direction);
}

static void _ast_modport_simple_ports_declaration_free(ast_node_t *node) {
    ast_modport_simple_ports_declaration_t *modport_simple_ports_declaration = (ast_modport_simple_ports_declaration_t *)node;

    ast_node_free(modport_simple_ports_declaration->modport_simple_port);
}
