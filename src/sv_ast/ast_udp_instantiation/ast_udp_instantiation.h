#ifndef AST_UDP_INSTANTIATION_H
#define AST_UDP_INSTANTIATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *delay2;
    ast_node_t *drive_strength;
    ast_node_t *udp_instance_list;
} ast_udp_instantiation_t;

ast_node_t* ast_udp_instantiation_new(ast_node_t *identifier, ast_node_t *delay2, ast_node_t *drive_strength, ast_node_t *udp_instance_list);

#endif
