#ifndef AST_NODE_H
#define AST_NODE_H

struct _ast_node_list;

typedef struct _ast_node {
    struct _ast_node_list *children;
    void (*print)(struct _ast_node *node, int indent, int indent_incr);
    void (*free)(struct _ast_node *node);
    char *indent;
    char *next_indent;
} ast_node_t;

ast_node_t* ast_node_new(void);
char* ast_node_gen_indent(int indent);
void ast_node_print(ast_node_t *node, int indent, int indent_incr);
void ast_node_free(ast_node_t *node);

#endif
