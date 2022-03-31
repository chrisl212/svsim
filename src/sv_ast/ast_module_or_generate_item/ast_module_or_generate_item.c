#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_module_or_generate_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_module_or_generate_item_free(ast_node_t *node);

ast_node_t* ast_module_or_generate_item_new(ast_node_t *checker_or_generate_item_declaration, ast_node_t *covered, ast_node_t *udp_instantiation, ast_node_t *in, ast_node_t *module_common_item, ast_node_t *gate_instantiation, ast_node_t *below, ast_node_t *parameter_override) {
    ast_module_or_generate_item_t *module_or_generate_item = calloc(1, sizeof(*module_or_generate_item));

    module_or_generate_item->super.print = _ast_module_or_generate_item_print;
    module_or_generate_item->super.free = _ast_module_or_generate_item_free;

    module_or_generate_item->checker_or_generate_item_declaration = checker_or_generate_item_declaration;
    module_or_generate_item->covered = covered;
    module_or_generate_item->udp_instantiation = udp_instantiation;
    module_or_generate_item->in = in;
    module_or_generate_item->module_common_item = module_common_item;
    module_or_generate_item->gate_instantiation = gate_instantiation;
    module_or_generate_item->below = below;
    module_or_generate_item->parameter_override = parameter_override;

    return (ast_node_t *)module_or_generate_item;
}

static void _ast_module_or_generate_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_module_or_generate_item_t *module_or_generate_item = (ast_module_or_generate_item_t *)node;

    ast_node_print(module_or_generate_item->checker_or_generate_item_declaration, indent, indent_incr);
    ast_node_print(module_or_generate_item->covered, indent, indent_incr);
    ast_node_print(module_or_generate_item->udp_instantiation, indent, indent_incr);
    ast_node_print(module_or_generate_item->in, indent, indent_incr);
    ast_node_print(module_or_generate_item->module_common_item, indent, indent_incr);
    ast_node_print(module_or_generate_item->gate_instantiation, indent, indent_incr);
    ast_node_print(module_or_generate_item->below, indent, indent_incr);
    ast_node_print(module_or_generate_item->parameter_override, indent, indent_incr);
}

static void _ast_module_or_generate_item_free(ast_node_t *node) {
    ast_module_or_generate_item_t *module_or_generate_item = (ast_module_or_generate_item_t *)node;

    ast_node_free(module_or_generate_item->checker_or_generate_item_declaration);
    ast_node_free(module_or_generate_item->covered);
    ast_node_free(module_or_generate_item->udp_instantiation);
    ast_node_free(module_or_generate_item->in);
    ast_node_free(module_or_generate_item->module_common_item);
    ast_node_free(module_or_generate_item->gate_instantiation);
    ast_node_free(module_or_generate_item->below);
    ast_node_free(module_or_generate_item->parameter_override);
}
