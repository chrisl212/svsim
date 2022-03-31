#ifndef AST_PROPERTY_EXPR_H
#define AST_PROPERTY_EXPR_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *clocking_event;
    ast_node_t *property_expr1;
    ast_node_t *property_expr0;
    ast_node_t *property_instance;
    ast_node_t *expression;
    ast_node_t *part_select_range;
    ast_node_t *expression_or_dist;
    ast_node_t *sequence_expr;
    ast_node_t *property_case_item_list;
} ast_property_expr_t;

ast_node_t* ast_property_expr_new(ast_node_t *clocking_event, ast_node_t *property_expr1, ast_node_t *property_expr0, ast_node_t *property_instance, ast_node_t *expression, ast_node_t *part_select_range, ast_node_t *expression_or_dist, ast_node_t *sequence_expr, ast_node_t *property_case_item_list);

#endif
