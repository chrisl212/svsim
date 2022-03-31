#ifndef AST_ASSUME_PROPERTY_STATEMENT_H
#define AST_ASSUME_PROPERTY_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *action_block;
    ast_node_t *property_spec;
} ast_assume_property_statement_t;

ast_node_t* ast_assume_property_statement_new(ast_node_t *action_block, ast_node_t *property_spec);

#endif
