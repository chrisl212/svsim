#ifndef AST_EVENT_EXPRESSION_H
#define AST_EVENT_EXPRESSION_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_edge_identifier/ast_edge_identifier.h"

typedef struct {
    ast_node_t super;
    ast_node_t *event_expression1;
    ast_node_t *expression0;
    ast_edge_identifier_t edge_identifier;
    ast_node_t *expression;
    ast_node_t *event_expression0;
    ast_node_t *expression1;
} ast_event_expression_t;

ast_node_t* ast_event_expression_new(ast_node_t *event_expression1, ast_node_t *expression0, ast_edge_identifier_t edge_identifier, ast_node_t *expression, ast_node_t *event_expression0, ast_node_t *expression1);

#endif
