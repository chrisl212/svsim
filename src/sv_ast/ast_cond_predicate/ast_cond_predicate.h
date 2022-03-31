#ifndef AST_COND_PREDICATE_H
#define AST_COND_PREDICATE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression_or_cond_pattern;
    ast_node_t *expression_or_cond_pattern0;
    ast_node_t *expression_or_cond_pattern1;
} ast_cond_predicate_t;

ast_node_t* ast_cond_predicate_new(ast_node_t *expression_or_cond_pattern, ast_node_t *expression_or_cond_pattern0, ast_node_t *expression_or_cond_pattern1);

#endif
