#ifndef AST_TASK_PROTOTYPE_H
#define AST_TASK_PROTOTYPE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *ps_or_hierarchical_identifier;
    ast_node_t *tf_port_list;
} ast_task_prototype_t;

ast_node_t* ast_task_prototype_new(ast_node_t *ps_or_hierarchical_identifier, ast_node_t *tf_port_list);

#endif
