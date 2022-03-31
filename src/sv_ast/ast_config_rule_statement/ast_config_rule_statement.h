#ifndef AST_CONFIG_RULE_STATEMENT_H
#define AST_CONFIG_RULE_STATEMENT_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_default_clause/ast_default_clause.h"

typedef struct {
    ast_node_t super;
    ast_default_clause_t default_clause;
    ast_node_t *inst_clause;
    ast_node_t *liblist_clause;
    ast_node_t *use_clause;
    ast_node_t *cell_clause;
} ast_config_rule_statement_t;

ast_node_t* ast_config_rule_statement_new(ast_default_clause_t default_clause, ast_node_t *inst_clause, ast_node_t *liblist_clause, ast_node_t *use_clause, ast_node_t *cell_clause);

#endif
