#ifndef AST_INTERFACE_DECLARATION_H
#define AST_INTERFACE_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *interface_item_list;
    ast_node_t *interface_ansi_header;
    ast_node_t *non_port_interface_item_list;
    ast_node_t *interface_non_ansi_header;
    ast_node_t *block_end_identifier;
} ast_interface_declaration_t;

ast_node_t* ast_interface_declaration_new(ast_node_t *interface_item_list, ast_node_t *interface_ansi_header, ast_node_t *non_port_interface_item_list, ast_node_t *interface_non_ansi_header, ast_node_t *block_end_identifier);

#endif
