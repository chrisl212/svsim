#ifndef AST_DEFAULT_SKEW_H
#define AST_DEFAULT_SKEW_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *clocking_skew0;
    ast_node_t *clocking_skew1;
    ast_node_t *clocking_skew;
} ast_default_skew_t;

ast_node_t* ast_default_skew_new(ast_node_t *clocking_skew0, ast_node_t *clocking_skew1, ast_node_t *clocking_skew);

#endif
