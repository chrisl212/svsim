#ifndef AST_WAIT_STATEMENT_H
#define AST_WAIT_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *action_block;
    ast_node_t *expression;
    ast_node_t *hierarchical_identifier_list;
    ast_node_t *statement;
} ast_wait_statement_t;

ast_node_t* ast_wait_statement_new(ast_node_t *action_block, ast_node_t *expression, ast_node_t *hierarchical_identifier_list, ast_node_t *statement);

#endif
