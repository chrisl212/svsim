#ifndef AST_PACKAGE_DECLARATION_H
#define AST_PACKAGE_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t super;
    ast_node_t *timeunits_declaration;
    ast_lifetime_t lifetime;
    ast_node_t *identifier;
    ast_node_t *block_end_identifier;
    ast_node_t *package_item_list;
} ast_package_declaration_t;

ast_node_t* ast_package_declaration_new(ast_node_t *timeunits_declaration, ast_lifetime_t lifetime, ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *package_item_list);

#endif
