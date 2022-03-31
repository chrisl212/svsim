#ifndef AST_GENERATE_BLOCK_H
#define AST_GENERATE_BLOCK_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier1;
    ast_node_t *generate_item_list;
    ast_node_t *identifier;
    ast_node_t *generate_item;
    ast_node_t *block_end_identifier;
    ast_node_t *identifier0;
} ast_generate_block_t;

ast_node_t* ast_generate_block_new(ast_node_t *identifier1, ast_node_t *generate_item_list, ast_node_t *identifier, ast_node_t *generate_item, ast_node_t *block_end_identifier, ast_node_t *identifier0);

#endif
