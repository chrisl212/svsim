#ifndef AST_SEQUENTIAL_BODY_H
#define AST_SEQUENTIAL_BODY_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *next_state;
    ast_node_t *current_state;
    ast_node_t *seq_input_list;
} ast_sequential_body_t;

ast_node_t* ast_sequential_body_new(ast_node_t *next_state, ast_node_t *current_state, ast_node_t *seq_input_list);

#endif
