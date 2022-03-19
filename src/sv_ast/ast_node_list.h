#ifndef AST_NODE_LIST_H
#define AST_NODE_LIST_H

#include "ast_node.h"

typedef struct _ast_node_list_item {
    ast_node_t *node;
    struct _ast_node_list_item *next;
} ast_node_list_item_t;

typedef struct _ast_node_list {
    ast_node_t super;
    ast_node_list_item_t *first;
    ast_node_list_item_t *last;
    int len;
} ast_node_list_t;

ast_node_list_t* ast_node_list_new(void);
void             ast_node_list_append(ast_node_list_t *list, ast_node_t *node);

#endif
