#ifndef AST_STATEMENT_H
#define AST_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *statement_item;
} ast_statement_t;

ast_node_t* ast_statement_new(ast_node_t *identifier, ast_node_t *statement_item);

#endif
