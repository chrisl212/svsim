#ifndef AST_UDP_DECLARATION_H
#define AST_UDP_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *udp_ansi_declaration;
    ast_node_t *udp_nonansi_declaration;
    ast_node_t *udp_body;
    ast_node_t *identifier;
    ast_node_t *block_end_identifier;
    ast_node_t *udp_port_declaration_list;
} ast_udp_declaration_t;

ast_node_t* ast_udp_declaration_new(ast_node_t *udp_ansi_declaration, ast_node_t *udp_nonansi_declaration, ast_node_t *udp_body, ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *udp_port_declaration_list);

#endif
