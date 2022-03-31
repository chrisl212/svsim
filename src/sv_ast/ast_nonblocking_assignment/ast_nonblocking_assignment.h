#ifndef AST_NONBLOCKING_ASSIGNMENT_H
#define AST_NONBLOCKING_ASSIGNMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *lvalue;
    ast_node_t *expression;
    ast_node_t *delay_or_event_control;
} ast_nonblocking_assignment_t;

ast_node_t* ast_nonblocking_assignment_new(ast_node_t *lvalue, ast_node_t *expression, ast_node_t *delay_or_event_control);

#endif
