#ifndef AST_LET_DECLARATION_H
#define AST_LET_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
    ast_node_t *let_port_list;
} ast_let_declaration_t;

ast_node_t* ast_let_declaration_new(ast_node_t *identifier, ast_node_t *expression, ast_node_t *let_port_list);

#endif
