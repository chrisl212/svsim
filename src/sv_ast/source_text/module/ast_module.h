#ifndef AST_MODULE_H
#define AST_MODULE_H

#include "sv_ast/ast.h"
#include "sv_ast/ast_node.h"
#include "sv_ast/ast_node_list.h"
#include "sv_ast/source_text/timeunits_decl/ast_timeunits_decl.h"
#include "sv_ast/decl/lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t                  super;
    ast_node_list_t *           attribute_instance_list;
    ast_lifetime_t              lifetime;
    ast_identifier_t            module_identifier;
    ast_node_list_t *           pkg_import_decl_list;
    ast_node_list_t *           parameter_port_list;
    ast_node_list_t *           port_list;
    ast_timeunits_decl_t *      timeunits_decl;
    ast_node_list_t *           module_item_list;
} ast_module_t;

ast_module_t* ast_module_new(ast_node_list_t *      attribute_instance_list,
                             ast_lifetime_t         lifetime,
                             ast_identifier_t       module_identifier,
                             ast_node_list_t *      pkg_import_decl_list,
                             ast_node_list_t *      parameter_port_list,
                             ast_node_list_t *      port_list,
                             ast_timeunits_decl_t * timeunits_decl,
                             ast_node_list_t *      module_item_list,
                             ast_identifier_t       closing_identifier);

#endif
