#ifndef AST_PROPERTY_CASE_ITEM_H
#define AST_PROPERTY_CASE_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *property_expr;
    ast_node_t *expression_or_dist_list;
} ast_property_case_item_t;

ast_node_t* ast_property_case_item_new(ast_node_t *property_expr, ast_node_t *expression_or_dist_list);

#endif
