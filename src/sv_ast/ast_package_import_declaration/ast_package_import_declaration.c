#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"
#include "ast_package_import_declaration.h"

static void _ast_package_import_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_package_import_declaration_free(ast_node_t *node);

ast_node_t* ast_package_import_declaration_new(ast_node_t *package_import_item_list) {
    ast_package_import_declaration_t *package_import_declaration = calloc(1, sizeof(*package_import_declaration));

    package_import_declaration->super.print = _ast_package_import_declaration_print;
    package_import_declaration->super.free = _ast_package_import_declaration_free;

    package_import_declaration->package_import_item_list = package_import_item_list;

    return (ast_node_t *)package_import_declaration;
}

static void _ast_package_import_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_package_import_declaration_t *package_import_declaration = (ast_package_import_declaration_t *)node;

    printf("import ");
    ast_node_print(package_import_declaration->package_import_item_list, indent, indent_incr);
    printf(";");
}

static void _ast_package_import_declaration_free(ast_node_t *node) {
    ast_package_import_declaration_t *package_import_declaration = (ast_package_import_declaration_t *)node;

    ast_node_free(package_import_declaration->package_import_item_list);
}

