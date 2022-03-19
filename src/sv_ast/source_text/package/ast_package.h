#ifndef AST_PACKAGE_H
#define AST_PACKAGE_H

#include "sv_ast/ast.h"
#include "sv_ast/ast_node.h"
#include "sv_ast/ast_node_list.h"
#include "sv_ast/general/identifier/ast_identifier.h"
#include "sv_ast/source_text/timeunits_decl/ast_timeunits_decl.h"
#include "sv_ast/decl/lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t                  super;
    ast_node_list_t *           attribute_instance_list;
    ast_lifetime_t              lifetime;
    ast_identifier_t *          package_identifier;
    ast_timeunits_decl_t *      timeunits_decl;
    ast_node_list_t *           package_item_list;
} ast_package_t;

ast_package_t* ast_package_new(ast_node_list_t *      attribute_instance_list,
                               ast_lifetime_t         lifetime,
                               ast_identifier_t *     package_identifier,
                               ast_timeunits_decl_t * timeunits_decl,
                               ast_node_list_t *      package_item_list,
                               ast_identifier_t *     closing_identifier);

#endif
