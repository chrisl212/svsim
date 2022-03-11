#ifndef AST_NODE_H
#define AST_NODE_H

struct _ast_node_list;

typedef struct _ast_node {
    struct _ast_node_list *children;
    void (*print)(struct _ast_node *node);
    void (*free)(struct _ast_node *node);
} ast_node_t;

ast_node_t* ast_node_new(void);
void ast_node_print(ast_node_t *node);
void ast_node_free(ast_node_t *node);

#endif
