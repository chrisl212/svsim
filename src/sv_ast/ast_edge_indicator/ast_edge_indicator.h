#ifndef AST_EDGE_INDICATOR_H
#define AST_EDGE_INDICATOR_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *edge_symbol;
    ast_node_t *level_symbol0;
    ast_node_t *level_symbol1;
} ast_edge_indicator_t;

ast_node_t* ast_edge_indicator_new(ast_node_t *edge_symbol, ast_node_t *level_symbol0, ast_node_t *level_symbol1);

#endif
