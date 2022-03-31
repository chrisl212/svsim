#ifndef AST_CLASS_DECLARATION_H
#define AST_CLASS_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t super;
    ast_lifetime_t lifetime;
    ast_node_t *implements_interface;
    ast_node_t *parameter_port_list;
    ast_node_t *identifier;
    ast_node_t *block_end_identifier;
    ast_node_t *virtual;
    ast_node_t *class_item_list;
    ast_node_t *extends_class;
} ast_class_declaration_t;

ast_node_t* ast_class_declaration_new(ast_lifetime_t lifetime, ast_node_t *implements_interface, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *virtual, ast_node_t *class_item_list, ast_node_t *extends_class);

#endif
