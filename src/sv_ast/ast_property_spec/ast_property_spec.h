#ifndef AST_PROPERTY_SPEC_H
#define AST_PROPERTY_SPEC_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression_or_dist;
    ast_node_t *property_expr;
    ast_node_t *clocking_event;
} ast_property_spec_t;

ast_node_t* ast_property_spec_new(ast_node_t *expression_or_dist, ast_node_t *property_expr, ast_node_t *clocking_event);

#endif
