#ifndef AST_CASE_GENERATE_CONSTRUCT_H
#define AST_CASE_GENERATE_CONSTRUCT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *case_generate_item_list;
    ast_node_t *expression;
} ast_case_generate_construct_t;

ast_node_t* ast_case_generate_construct_new(ast_node_t *case_generate_item_list, ast_node_t *expression);

#endif
