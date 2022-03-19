#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "sv_ast/general/attr/ast_attr_inst_list.h"
#include "ast_module.h"

static void _ast_module_print(ast_node_t *node);
static void _ast_module_free(ast_node_t *node);

ast_module_t* ast_module_new(ast_node_list_t *      attribute_instance_list,
                             ast_lifetime_t         lifetime,
                             ast_identifier_t *     module_identifier,
                             ast_node_list_t *      pkg_import_decl_list,
                             ast_node_list_t *      parameter_port_list,
                             ast_node_list_t *      port_list,
                             ast_timeunits_decl_t * timeunits_decl,
                             ast_node_list_t *      module_item_list,
                             ast_identifier_t *     closing_identifier) {

    ast_module_t *mod            = calloc(1, sizeof(*mod));

    mod->super.print             = _ast_module_print;
    mod->super.free              = _ast_module_free;

    mod->attribute_instance_list = attribute_instance_list;
    mod->lifetime                = lifetime;
    mod->module_identifier       = module_identifier;
    mod->pkg_import_decl_list    = pkg_import_decl_list;
    mod->parameter_port_list     = parameter_port_list;
    mod->port_list               = port_list;
    mod->timeunits_decl          = timeunits_decl;
    mod->module_item_list        = module_item_list;

    if (closing_identifier && strcmp(module_identifier->identifier, closing_identifier->identifier)) {
        fprintf(stderr, "ERROR: mismatch on module identifiers, %s != %s\n", module_identifier->identifier, closing_identifier->identifier);
        exit(-1);
    }
    ast_node_free((ast_node_t *)closing_identifier);

    return mod;
}

static void _ast_module_print(ast_node_t *node) {
    ast_module_t *mod = (ast_module_t *)node;
    ast_node_list_item_t *port = mod->port_list->first;

    printf("\n");
    ast_attr_inst_list_print(mod->attribute_instance_list);
    printf("\n");
    ast_lifetime_print(mod->lifetime);
    printf("module ");
    ast_node_print((ast_node_t *)mod->module_identifier);
    ast_node_print((ast_node_t *)mod->pkg_import_decl_list);
    ast_node_print((ast_node_t *)mod->parameter_port_list);

    printf("(\n  ");
    for (; port != NULL; port = port->next) {
        ast_node_print((ast_node_t *)port->node);
        if (port->next) {
            printf(", ");
        }
    }
    printf("\n);\n");

    ast_node_print((ast_node_t *)mod->timeunits_decl);
    ast_node_print((ast_node_t *)mod->module_item_list);
    printf("\nendmodule : ");
    ast_node_print((ast_node_t *)mod->module_identifier);
    printf("\n");
}

static void _ast_module_free(ast_node_t *node) {
    ast_module_t *mod = (ast_module_t *)node;

    ast_node_free((ast_node_t *)mod->attribute_instance_list);
    ast_node_free((ast_node_t *)mod->module_identifier);
    ast_node_free((ast_node_t *)mod->pkg_import_decl_list);
    ast_node_free((ast_node_t *)mod->parameter_port_list);
    ast_node_free((ast_node_t *)mod->port_list);
    ast_node_free((ast_node_t *)mod->timeunits_decl);
    ast_node_free((ast_node_t *)mod->module_item_list);
}

