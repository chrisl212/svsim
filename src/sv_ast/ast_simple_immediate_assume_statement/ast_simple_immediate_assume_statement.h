#ifndef AST_SIMPLE_IMMEDIATE_ASSUME_STATEMENT_H
#define AST_SIMPLE_IMMEDIATE_ASSUME_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *action_block;
    ast_node_t *expression;
} ast_simple_immediate_assume_statement_t;

ast_node_t* ast_simple_immediate_assume_statement_new(ast_node_t *action_block, ast_node_t *expression);

#endif
