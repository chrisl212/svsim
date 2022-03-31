#ifndef AST_INOUT_DECLARATION_H
#define AST_INOUT_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *net_port_type;
    ast_node_t *port_identifier_list;
} ast_inout_declaration_t;

ast_node_t* ast_inout_declaration_new(ast_node_t *net_port_type, ast_node_t *port_identifier_list);

#endif
