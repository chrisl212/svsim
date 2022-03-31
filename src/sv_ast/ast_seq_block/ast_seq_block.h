#ifndef AST_SEQ_BLOCK_H
#define AST_SEQ_BLOCK_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *statement_list;
    ast_node_t *block_end_identifier1;
    ast_node_t *block_item_declaration_list;
    ast_node_t *block_end_identifier0;
} ast_seq_block_t;

ast_node_t* ast_seq_block_new(ast_node_t *statement_list, ast_node_t *block_end_identifier1, ast_node_t *block_item_declaration_list, ast_node_t *block_end_identifier0);

#endif
