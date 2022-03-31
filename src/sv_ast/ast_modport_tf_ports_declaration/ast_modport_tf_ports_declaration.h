#ifndef AST_MODPORT_TF_PORTS_DECLARATION_H
#define AST_MODPORT_TF_PORTS_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *modport_tf_port;
    ast_node_t *modport_tf_port_list;
} ast_modport_tf_ports_declaration_t;

ast_node_t* ast_modport_tf_ports_declaration_new(ast_node_t *modport_tf_port, ast_node_t *modport_tf_port_list);

#endif
