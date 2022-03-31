#ifndef AST_MODPORT_ITEM_H
#define AST_MODPORT_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *modport_ports_declaration_list;
} ast_modport_item_t;

ast_node_t* ast_modport_item_new(ast_node_t *identifier, ast_node_t *modport_ports_declaration_list);

#endif
