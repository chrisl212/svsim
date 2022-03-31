#ifndef AST_LOOP_GENERATE_CONSTRUCT_H
#define AST_LOOP_GENERATE_CONSTRUCT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *generate_block;
    ast_node_t *genvar_initialization;
    ast_node_t *expression;
    ast_node_t *genvar_iteration;
} ast_loop_generate_construct_t;

ast_node_t* ast_loop_generate_construct_new(ast_node_t *generate_block, ast_node_t *genvar_initialization, ast_node_t *expression, ast_node_t *genvar_iteration);

#endif
