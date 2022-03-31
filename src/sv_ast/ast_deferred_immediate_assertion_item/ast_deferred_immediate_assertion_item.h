#ifndef AST_DEFERRED_IMMEDIATE_ASSERTION_ITEM_H
#define AST_DEFERRED_IMMEDIATE_ASSERTION_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *deferred_immediate_assertion_statement;
} ast_deferred_immediate_assertion_item_t;

ast_node_t* ast_deferred_immediate_assertion_item_new(ast_node_t *identifier, ast_node_t *deferred_immediate_assertion_statement);

#endif
