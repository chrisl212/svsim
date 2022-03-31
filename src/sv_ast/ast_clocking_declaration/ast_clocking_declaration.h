#ifndef AST_CLOCKING_DECLARATION_H
#define AST_CLOCKING_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *block_end_identifier;
    ast_node_t *clocking_item_list;
    ast_node_t *clocking_event;
} ast_clocking_declaration_t;

ast_node_t* ast_clocking_declaration_new(ast_node_t *identifier, ast_node_t *block_end_identifier, ast_node_t *clocking_item_list, ast_node_t *clocking_event);

#endif
