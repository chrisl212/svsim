#ifndef AST_OVERLOAD_DECLARATION_H
#define AST_OVERLOAD_DECLARATION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_overload_operator/ast_overload_operator.h"

typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *data_type;
    ast_node_t *overload_proto_formals;
    ast_overload_operator_t overload_operator;
} ast_overload_declaration_t;

ast_node_t* ast_overload_declaration_new(ast_node_t *identifier, ast_node_t *data_type, ast_node_t *overload_proto_formals, ast_overload_operator_t overload_operator);

#endif
