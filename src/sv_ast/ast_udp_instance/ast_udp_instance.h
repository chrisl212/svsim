#ifndef AST_UDP_INSTANCE_H
#define AST_UDP_INSTANCE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *output_terminal;
    ast_node_t *input_terminal;
    ast_node_t *input_terminal1;
    ast_node_t *name_of_instance;
    ast_node_t *input_terminal0;
} ast_udp_instance_t;

ast_node_t* ast_udp_instance_new(ast_node_t *output_terminal, ast_node_t *input_terminal, ast_node_t *input_terminal1, ast_node_t *name_of_instance, ast_node_t *input_terminal0);

#endif
