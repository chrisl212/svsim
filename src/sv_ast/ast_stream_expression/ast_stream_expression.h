#ifndef AST_STREAM_EXPRESSION_H
#define AST_STREAM_EXPRESSION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression;
    ast_node_t *part_select_range;
} ast_stream_expression_t;

ast_node_t* ast_stream_expression_new(ast_node_t *expression, ast_node_t *part_select_range);

#endif
