#ifndef AST_UDP_ANSI_DECLARATION_H
#define AST_UDP_ANSI_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *udp_declaration_port_list;
} ast_udp_ansi_declaration_t;

ast_node_t* ast_udp_ansi_declaration_new(ast_node_t *identifier, ast_node_t *udp_declaration_port_list);

#endif
