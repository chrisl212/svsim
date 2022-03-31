#ifndef AST_IF_GENERATE_CONSTRUCT_H
#define AST_IF_GENERATE_CONSTRUCT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *generate_block0;
    ast_node_t *expression;
    ast_node_t *generate_block;
    ast_node_t *generate_block1;
} ast_if_generate_construct_t;

ast_node_t* ast_if_generate_construct_new(ast_node_t *generate_block0, ast_node_t *expression, ast_node_t *generate_block, ast_node_t *generate_block1);

#endif
