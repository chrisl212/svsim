#ifndef AST_CASE_STATEMENT_H
#define AST_CASE_STATEMENT_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_case_keyword/ast_case_keyword.h"

typedef struct {
    ast_node_t super;
    ast_node_t *case_inside_item_list;
    ast_node_t *case_pattern_item_list;
    ast_node_t *expression;
    ast_node_t *unique_priority;
    ast_case_keyword_t case_keyword;
    ast_node_t *case_item_list;
} ast_case_statement_t;

ast_node_t* ast_case_statement_new(ast_node_t *case_inside_item_list, ast_node_t *case_pattern_item_list, ast_node_t *expression, ast_node_t *unique_priority, ast_case_keyword_t case_keyword, ast_node_t *case_item_list);

#endif
