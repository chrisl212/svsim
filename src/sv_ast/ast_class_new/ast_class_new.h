#ifndef AST_CLASS_NEW_H
#define AST_CLASS_NEW_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *class_scope;
    ast_node_t *expression;
    ast_node_t *argument_list;
} ast_class_new_t;

ast_node_t* ast_class_new_new(ast_node_t *class_scope, ast_node_t *expression, ast_node_t *argument_list);

#endif
