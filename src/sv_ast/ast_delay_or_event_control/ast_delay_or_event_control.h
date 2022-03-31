#ifndef AST_DELAY_OR_EVENT_CONTROL_H
#define AST_DELAY_OR_EVENT_CONTROL_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *delay_control;
    ast_node_t *event_control;
    ast_node_t *expression;
} ast_delay_or_event_control_t;

ast_node_t* ast_delay_or_event_control_new(ast_node_t *delay_control, ast_node_t *event_control, ast_node_t *expression);

#endif
