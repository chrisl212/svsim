#ifndef AST_CONFIG_DECLARATION_H
#define AST_CONFIG_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *config_rule_statement_list;
    ast_node_t *identifier;
    ast_node_t *design_statement;
    ast_node_t *block_end_identifier;
    ast_node_t *local_parameter_declaration_list;
} ast_config_declaration_t;

ast_node_t* ast_config_declaration_new(ast_node_t *config_rule_statement_list, ast_node_t *identifier, ast_node_t *design_statement, ast_node_t *block_end_identifier, ast_node_t *local_parameter_declaration_list);

#endif
