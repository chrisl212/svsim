#ifndef AST_CASE_ITEM_H
#define AST_CASE_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *expression_list;
    ast_node_t *statement;
} ast_case_item_t;

ast_node_t* ast_case_item_new(ast_node_t *expression_list, ast_node_t *statement);

#endif
