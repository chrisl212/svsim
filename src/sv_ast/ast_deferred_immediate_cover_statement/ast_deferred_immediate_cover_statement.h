#ifndef AST_DEFERRED_IMMEDIATE_COVER_STATEMENT_H
#define AST_DEFERRED_IMMEDIATE_COVER_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression;
    ast_node_t *statement;
} ast_deferred_immediate_cover_statement_t;

ast_node_t* ast_deferred_immediate_cover_statement_new(ast_node_t *expression, ast_node_t *statement);

#endif
