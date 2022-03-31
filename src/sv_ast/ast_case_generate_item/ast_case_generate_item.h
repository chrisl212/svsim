#ifndef AST_CASE_GENERATE_ITEM_H
#define AST_CASE_GENERATE_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression_list;
    ast_node_t *generate_block;
} ast_case_generate_item_t;

ast_node_t* ast_case_generate_item_new(ast_node_t *expression_list, ast_node_t *generate_block);

#endif
