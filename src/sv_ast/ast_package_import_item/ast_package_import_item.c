#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"
#include "ast_package_import_item.h"

static void _ast_package_import_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_package_import_item_free(ast_node_t *node);

ast_node_t* ast_package_import_item_new(ast_node_t *identifier, char wildcard) {
    ast_package_import_item_t *package_import_item = calloc(1, sizeof(*package_import_item));

    package_import_item->super.print = _ast_package_import_item_print;
    package_import_item->super.free = _ast_package_import_item_free;

    package_import_item->identifier = identifier;
    package_import_item->wildcard = wildcard;

    return (ast_node_t *)package_import_item;
}

static void _ast_package_import_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_package_import_item_t *package_import_item = (ast_package_import_item_t *)node;

    ast_node_print(package_import_item->identifier, indent, indent_incr);
    if (package_import_item->wildcard) {
        printf("*");
    }
}

static void _ast_package_import_item_free(ast_node_t *node) {
    ast_package_import_item_t *package_import_item = (ast_package_import_item_t *)node;

    ast_node_free(package_import_item->identifier);
}

