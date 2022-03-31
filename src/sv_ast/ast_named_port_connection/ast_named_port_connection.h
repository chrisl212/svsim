#ifndef AST_NAMED_PORT_CONNECTION_H
#define AST_NAMED_PORT_CONNECTION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
} ast_named_port_connection_t;

ast_node_t* ast_named_port_connection_new(ast_node_t *identifier, ast_node_t *expression);

#endif
