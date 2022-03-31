#ifndef AST_DIST_ITEM_H
#define AST_DIST_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *dist_weight;
    ast_node_t *value_range;
} ast_dist_item_t;

ast_node_t* ast_dist_item_new(ast_node_t *dist_weight, ast_node_t *value_range);

#endif
