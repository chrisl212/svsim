#ifndef AST_PS_IDENTIFIER_H
#define AST_PS_IDENTIFIER_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *scope;
    ast_node_t *identifier;
} ast_ps_identifier_t;

ast_node_t* ast_ps_identifier_new(ast_node_t *scope, ast_node_t *identifier);

#endif
