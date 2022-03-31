#ifndef AST_CONDITIONAL_STATEMENT_H
#define AST_CONDITIONAL_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *else_if_list;
    ast_node_t *statement;
    ast_node_t *cond_predicate;
    ast_node_t *unique_priority;
    ast_node_t *statement0;
    ast_node_t *statement1;
} ast_conditional_statement_t;

ast_node_t* ast_conditional_statement_new(ast_node_t *else_if_list, ast_node_t *statement, ast_node_t *cond_predicate, ast_node_t *unique_priority, ast_node_t *statement0, ast_node_t *statement1);

#endif
