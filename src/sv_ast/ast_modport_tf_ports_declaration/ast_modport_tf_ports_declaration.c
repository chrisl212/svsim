#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_modport_tf_ports_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_modport_tf_ports_declaration_free(ast_node_t *node);

ast_node_t* ast_modport_tf_ports_declaration_new(ast_node_t *modport_tf_port, ast_node_t *modport_tf_port_list) {
    ast_modport_tf_ports_declaration_t *modport_tf_ports_declaration = calloc(1, sizeof(*modport_tf_ports_declaration));

    modport_tf_ports_declaration->super.print = _ast_modport_tf_ports_declaration_print;
    modport_tf_ports_declaration->super.free = _ast_modport_tf_ports_declaration_free;

    modport_tf_ports_declaration->modport_tf_port = modport_tf_port;
    modport_tf_ports_declaration->modport_tf_port_list = modport_tf_port_list;

    return (ast_node_t *)modport_tf_ports_declaration;
}

static void _ast_modport_tf_ports_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_modport_tf_ports_declaration_t *modport_tf_ports_declaration = (ast_modport_tf_ports_declaration_t *)node;

    ast_node_print(modport_tf_ports_declaration->modport_tf_port, indent, indent_incr);
    ast_node_print(modport_tf_ports_declaration->modport_tf_port_list, indent, indent_incr);
}

static void _ast_modport_tf_ports_declaration_free(ast_node_t *node) {
    ast_modport_tf_ports_declaration_t *modport_tf_ports_declaration = (ast_modport_tf_ports_declaration_t *)node;

    ast_node_free(modport_tf_ports_declaration->modport_tf_port);
    ast_node_free(modport_tf_ports_declaration->modport_tf_port_list);
}
