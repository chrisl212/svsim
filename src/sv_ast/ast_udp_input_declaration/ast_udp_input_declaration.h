#ifndef AST_UDP_INPUT_DECLARATION_H
#define AST_UDP_INPUT_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier_list;
    ast_node_t *identifier;
} ast_udp_input_declaration_t;

ast_node_t* ast_udp_input_declaration_new(ast_node_t *identifier_list, ast_node_t *identifier);

#endif
