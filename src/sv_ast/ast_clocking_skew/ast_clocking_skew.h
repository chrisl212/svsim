#ifndef AST_CLOCKING_SKEW_H
#define AST_CLOCKING_SKEW_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_edge_identifier/ast_edge_identifier.h"

typedef struct {
    ast_node_t super;
    ast_node_t *delay_control;
    ast_edge_identifier_t edge_identifier;
} ast_clocking_skew_t;

ast_node_t* ast_clocking_skew_new(ast_node_t *delay_control, ast_edge_identifier_t edge_identifier);

#endif
