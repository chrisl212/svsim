#ifndef AST_LOOP_STATEMENT_H
#define AST_LOOP_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier_list;
    ast_node_t *statement;
    ast_node_t *identifier;
    ast_node_t *expression;
    ast_node_t *for_step;
    ast_node_t *for_initialization;
} ast_loop_statement_t;

ast_node_t* ast_loop_statement_new(ast_node_t *identifier_list, ast_node_t *statement, ast_node_t *identifier, ast_node_t *expression, ast_node_t *for_step, ast_node_t *for_initialization);

#endif
