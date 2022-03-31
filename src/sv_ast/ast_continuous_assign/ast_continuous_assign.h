#ifndef AST_CONTINUOUS_ASSIGN_H
#define AST_CONTINUOUS_ASSIGN_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *delay_control;
    ast_node_t *variable_assignment_list;
} ast_continuous_assign_t;

ast_node_t* ast_continuous_assign_new(ast_node_t *delay_control, ast_node_t *variable_assignment_list);

#endif
