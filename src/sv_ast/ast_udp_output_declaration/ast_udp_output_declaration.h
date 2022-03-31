#ifndef AST_UDP_OUTPUT_DECLARATION_H
#define AST_UDP_OUTPUT_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
} ast_udp_output_declaration_t;

ast_node_t* ast_udp_output_declaration_new(ast_node_t *identifier, ast_node_t *expression);

#endif
