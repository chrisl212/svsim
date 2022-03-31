#ifndef AST_NET_DECLARATION_H
#define AST_NET_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_net_type/ast_net_type.h"
#include "sv_ast/ast_signing/ast_signing.h"

typedef struct {
    ast_node_t super;
    ast_node_t *identifier_unpacked_dimension_list;
    ast_net_type_t net_type;
    ast_node_t *vectored_or_scalared;
    ast_node_t *identifier;
    ast_node_t *delay3;
    ast_node_t *variable_decl_assignment_list;
    ast_node_t *drive_or_charge_strength;
    ast_signing_t signing;
    ast_node_t *delay_value;
    ast_node_t *delay_control;
    ast_node_t *data_type_no_param;
    ast_node_t *packed_dimension_list;
} ast_net_declaration_t;

ast_node_t* ast_net_declaration_new(ast_node_t *identifier_unpacked_dimension_list, ast_net_type_t net_type, ast_node_t *vectored_or_scalared, ast_node_t *identifier, ast_node_t *delay3, ast_node_t *variable_decl_assignment_list, ast_node_t *drive_or_charge_strength, ast_signing_t signing, ast_node_t *delay_value, ast_node_t *delay_control, ast_node_t *data_type_no_param, ast_node_t *packed_dimension_list);

#endif
