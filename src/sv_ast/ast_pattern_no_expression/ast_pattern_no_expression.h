#ifndef AST_PATTERN_NO_EXPRESSION_H
#define AST_PATTERN_NO_EXPRESSION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *covered;
    ast_node_t *in;
    ast_node_t *identifier;
    ast_node_t *expression0;
    ast_node_t *identifier_pattern_list;
    ast_node_t *variant;
    ast_node_t *expression1;
    ast_node_t *pattern_list;
} ast_pattern_no_expression_t;

ast_node_t* ast_pattern_no_expression_new(ast_node_t *covered, ast_node_t *in, ast_node_t *identifier, ast_node_t *expression0, ast_node_t *identifier_pattern_list, ast_node_t *variant, ast_node_t *expression1, ast_node_t *pattern_list);

#endif
