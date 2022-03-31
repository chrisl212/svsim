#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_config_rule_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_config_rule_statement_free(ast_node_t *node);

ast_node_t* ast_config_rule_statement_new(ast_default_clause_t default_clause, ast_node_t *inst_clause, ast_node_t *liblist_clause, ast_node_t *use_clause, ast_node_t *cell_clause) {
    ast_config_rule_statement_t *config_rule_statement = calloc(1, sizeof(*config_rule_statement));

    config_rule_statement->super.print = _ast_config_rule_statement_print;
    config_rule_statement->super.free = _ast_config_rule_statement_free;

    config_rule_statement->default_clause = default_clause;
    config_rule_statement->inst_clause = inst_clause;
    config_rule_statement->liblist_clause = liblist_clause;
    config_rule_statement->use_clause = use_clause;
    config_rule_statement->cell_clause = cell_clause;

    return (ast_node_t *)config_rule_statement;
}

static void _ast_config_rule_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_config_rule_statement_t *config_rule_statement = (ast_config_rule_statement_t *)node;

    ast_default_clause_print(config_rule_statement->default_clause);
    ast_node_print(config_rule_statement->inst_clause, indent, indent_incr);
    ast_node_print(config_rule_statement->liblist_clause, indent, indent_incr);
    ast_node_print(config_rule_statement->use_clause, indent, indent_incr);
    ast_node_print(config_rule_statement->cell_clause, indent, indent_incr);
}

static void _ast_config_rule_statement_free(ast_node_t *node) {
    ast_config_rule_statement_t *config_rule_statement = (ast_config_rule_statement_t *)node;

    ast_node_free(config_rule_statement->inst_clause);
    ast_node_free(config_rule_statement->liblist_clause);
    ast_node_free(config_rule_statement->use_clause);
    ast_node_free(config_rule_statement->cell_clause);
}
