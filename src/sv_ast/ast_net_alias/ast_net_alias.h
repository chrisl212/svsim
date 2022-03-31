#ifndef AST_NET_ALIAS_H
#define AST_NET_ALIAS_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *lvalue1;
    ast_node_t *lvalue0;
    ast_node_t *lvalue_list;
} ast_net_alias_t;

ast_node_t* ast_net_alias_new(ast_node_t *lvalue1, ast_node_t *lvalue0, ast_node_t *lvalue_list);

#endif
