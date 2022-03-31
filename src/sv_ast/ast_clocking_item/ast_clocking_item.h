#ifndef AST_CLOCKING_ITEM_H
#define AST_CLOCKING_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *default_skew;
    ast_node_t *clocking_direction;
    ast_node_t *clocking_decl_assign_list;
    ast_node_t *assertion_item_declaration;
} ast_clocking_item_t;

ast_node_t* ast_clocking_item_new(ast_node_t *default_skew, ast_node_t *clocking_direction, ast_node_t *clocking_decl_assign_list, ast_node_t *assertion_item_declaration);

#endif
