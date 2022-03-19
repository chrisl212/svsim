#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "sv_ast/general/attr/ast_attr_inst_list.h"
#include "ast_package.h"

static void _ast_package_print(ast_node_t *node);
static void _ast_package_free(ast_node_t *node);

ast_package_t* ast_package_new(ast_node_list_t *      attribute_instance_list,
                               ast_lifetime_t         lifetime,
                               ast_identifier_t *     package_identifier,
                               ast_timeunits_decl_t * timeunits_decl,
                               ast_node_list_t *      package_item_list,
                               ast_identifier_t *     closing_identifier) {

    ast_package_t *pkg           = calloc(1, sizeof(*pkg));

    pkg->super.print             = _ast_package_print;
    pkg->super.free              = _ast_package_free;

    pkg->attribute_instance_list = attribute_instance_list;
    pkg->lifetime                = lifetime;
    pkg->package_identifier      = package_identifier;
    pkg->timeunits_decl          = timeunits_decl;
    pkg->package_item_list       = package_item_list;

    if (closing_identifier && strcmp(package_identifier->identifier, closing_identifier->identifier)) {
        fprintf(stderr, "ERROR: mismatch on package identifiers, %s != %s\n", package_identifier->identifier, closing_identifier->identifier);
        exit(-1);
    }
    ast_node_free((ast_node_t *)closing_identifier);

    return pkg;
}

static void _ast_package_print(ast_node_t *node) {
    ast_package_t *pkg = (ast_package_t *)node;

    printf("\n");
    ast_attr_inst_list_print(pkg->attribute_instance_list);
    printf("\n");
    ast_lifetime_print(pkg->lifetime);
    printf("package ");
    ast_node_print((ast_node_t *)pkg->package_identifier);
    printf(";");
    ast_node_print((ast_node_t *)pkg->timeunits_decl);
    ast_node_print((ast_node_t *)pkg->package_item_list);
    printf("\nendpackage : ");
    ast_node_print((ast_node_t *)pkg->package_identifier);
    printf("\n");
}

static void _ast_package_free(ast_node_t *node) {
    ast_package_t *pkg = (ast_package_t *)node;

    ast_node_free((ast_node_t *)pkg->attribute_instance_list);
    ast_node_free((ast_node_t *)pkg->package_identifier);
    ast_node_free((ast_node_t *)pkg->timeunits_decl);
    ast_node_free((ast_node_t *)pkg->package_item_list);
}

