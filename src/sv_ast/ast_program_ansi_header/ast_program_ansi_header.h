#ifndef AST_PROGRAM_ANSI_HEADER_H
#define AST_PROGRAM_ANSI_HEADER_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_lifetime/ast_lifetime.h"

typedef struct {
    ast_node_t super;
    ast_node_t *package_import_declaration_list;
    ast_lifetime_t lifetime;
    ast_node_t *parameter_port_list;
    ast_node_t *identifier;
    ast_node_t *port_declaration_list;
} ast_program_ansi_header_t;

ast_node_t* ast_program_ansi_header_new(ast_node_t *package_import_declaration_list, ast_lifetime_t lifetime, ast_node_t *parameter_port_list, ast_node_t *identifier, ast_node_t *port_declaration_list);

#endif
