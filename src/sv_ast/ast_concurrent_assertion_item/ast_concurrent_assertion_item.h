#ifndef AST_CONCURRENT_ASSERTION_ITEM_H
#define AST_CONCURRENT_ASSERTION_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *concurrent_assertion_statement;
    ast_node_t *checker_instantiation;
} ast_concurrent_assertion_item_t;

ast_node_t* ast_concurrent_assertion_item_new(ast_node_t *identifier, ast_node_t *concurrent_assertion_statement, ast_node_t *checker_instantiation);

#endif
