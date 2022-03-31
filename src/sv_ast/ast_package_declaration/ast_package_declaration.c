#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_package_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_package_declaration_free(ast_node_t *node);

ast_node_t* ast_package_declaration_new(ast_node_t *timeunits_declaration, ast_lifetime_t lifetime, ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *package_item_list) {
    ast_package_declaration_t *package_declaration = calloc(1, sizeof(*package_declaration));

    package_declaration->super.print = _ast_package_declaration_print;
    package_declaration->super.free = _ast_package_declaration_free;

    package_declaration->timeunits_declaration = timeunits_declaration;
    package_declaration->lifetime = lifetime;
    package_declaration->identifier = identifier;
    package_declaration->block_end_identifier = block_end_identifier;
    package_declaration->package_item_list = package_item_list;

    return (ast_node_t *)package_declaration;
}

static void _ast_package_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_package_declaration_t *package_declaration = (ast_package_declaration_t *)node;

    ast_node_print(package_declaration->timeunits_declaration, indent, indent_incr);
    ast_lifetime_print(package_declaration->lifetime);
    ast_node_print(package_declaration->identifier, indent, indent_incr);
    ast_node_print(package_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(package_declaration->package_item_list, indent, indent_incr);
}

static void _ast_package_declaration_free(ast_node_t *node) {
    ast_package_declaration_t *package_declaration = (ast_package_declaration_t *)node;

    ast_node_free(package_declaration->timeunits_declaration);
    ast_node_free(package_declaration->identifier);
    ast_node_free(package_declaration->block_end_identifier);
    ast_node_free(package_declaration->package_item_list);
}
