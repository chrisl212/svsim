#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_config_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_config_declaration_free(ast_node_t *node);

ast_node_t* ast_config_declaration_new(ast_node_t *config_rule_statement_list, ast_node_t *identifier, ast_node_t *design_statement, ast_node_t *block_end_identifier, ast_node_t *local_parameter_declaration_list) {
    ast_config_declaration_t *config_declaration = calloc(1, sizeof(*config_declaration));

    config_declaration->super.print = _ast_config_declaration_print;
    config_declaration->super.free = _ast_config_declaration_free;

    config_declaration->config_rule_statement_list = config_rule_statement_list;
    config_declaration->identifier = identifier;
    config_declaration->design_statement = design_statement;
    config_declaration->block_end_identifier = block_end_identifier;
    config_declaration->local_parameter_declaration_list = local_parameter_declaration_list;

    return (ast_node_t *)config_declaration;
}

static void _ast_config_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_config_declaration_t *config_declaration = (ast_config_declaration_t *)node;

    ast_node_print(config_declaration->config_rule_statement_list, indent, indent_incr);
    ast_node_print(config_declaration->identifier, indent, indent_incr);
    ast_node_print(config_declaration->design_statement, indent, indent_incr);
    ast_node_print(config_declaration->block_end_identifier, indent, indent_incr);
    ast_node_print(config_declaration->local_parameter_declaration_list, indent, indent_incr);
}

static void _ast_config_declaration_free(ast_node_t *node) {
    ast_config_declaration_t *config_declaration = (ast_config_declaration_t *)node;

    ast_node_free(config_declaration->config_rule_statement_list);
    ast_node_free(config_declaration->identifier);
    ast_node_free(config_declaration->design_statement);
    ast_node_free(config_declaration->block_end_identifier);
    ast_node_free(config_declaration->local_parameter_declaration_list);
}
