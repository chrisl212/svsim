#ifndef AST_MODPORT_SIMPLE_PORT_H
#define AST_MODPORT_SIMPLE_PORT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
} ast_modport_simple_port_t;

ast_node_t* ast_modport_simple_port_new(ast_node_t *identifier, ast_node_t *expression);

#endif
