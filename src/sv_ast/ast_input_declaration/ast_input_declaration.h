#ifndef AST_INPUT_DECLARATION_H
#define AST_INPUT_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *net_port_type;
    ast_node_t *variable_identifier_list;
    ast_node_t *port_identifier_list;
    ast_node_t *variable_port_type;
} ast_input_declaration_t;

ast_node_t* ast_input_declaration_new(ast_node_t *net_port_type, ast_node_t *variable_identifier_list, ast_node_t *port_identifier_list, ast_node_t *variable_port_type);

#endif
