#ifndef AST_PAR_BLOCK_H
#define AST_PAR_BLOCK_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_join_keyword/ast_join_keyword.h"

typedef struct {
    ast_node_t super;
    ast_node_t *statement_list;
    ast_join_keyword_t join_keyword;
    ast_node_t *block_end_identifier0;
    ast_node_t *block_end_identifier1;
    ast_node_t *block_item_declaration_list;
} ast_par_block_t;

ast_node_t* ast_par_block_new(ast_node_t *statement_list, ast_join_keyword_t join_keyword, ast_node_t *block_end_identifier0, ast_node_t *block_end_identifier1, ast_node_t *block_item_declaration_list);

#endif
