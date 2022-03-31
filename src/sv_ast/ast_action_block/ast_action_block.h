#ifndef AST_ACTION_BLOCK_H
#define AST_ACTION_BLOCK_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *statement1;
    ast_node_t *statement;
    ast_node_t *statement0;
} ast_action_block_t;

ast_node_t* ast_action_block_new(ast_node_t *statement1, ast_node_t *statement, ast_node_t *statement0);

#endif
