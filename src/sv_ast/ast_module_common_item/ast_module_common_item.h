#ifndef AST_MODULE_COMMON_ITEM_H
#define AST_MODULE_COMMON_ITEM_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_always_keyword/ast_always_keyword.h"

typedef struct {
    ast_node_t super;
    ast_node_t *final_construct;
    ast_always_keyword_t always_keyword;
    ast_node_t *statement;
    ast_node_t *assertion_item;
    ast_node_t *bind_directive;
    ast_node_t *loop_generate_construct;
    ast_node_t *module_or_generate_item_declaration;
    ast_node_t *conditional_generate_construct;
    ast_node_t *continuous_assign;
    ast_node_t *initial_construct;
    ast_node_t *generic_instantiation;
    ast_node_t *net_alias;
} ast_module_common_item_t;

ast_node_t* ast_module_common_item_new(ast_node_t *final_construct, ast_always_keyword_t always_keyword, ast_node_t *statement, ast_node_t *assertion_item, ast_node_t *bind_directive, ast_node_t *loop_generate_construct, ast_node_t *module_or_generate_item_declaration, ast_node_t *conditional_generate_construct, ast_node_t *continuous_assign, ast_node_t *initial_construct, ast_node_t *generic_instantiation, ast_node_t *net_alias);

#endif
