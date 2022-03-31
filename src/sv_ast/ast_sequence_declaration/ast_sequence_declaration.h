#ifndef AST_SEQUENCE_DECLARATION_H
#define AST_SEQUENCE_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *assertion_variable_declaration_list;
    ast_node_t *sequence_expr;
    ast_node_t *block_end_identifier;
    ast_node_t *sequence_port_list;
} ast_sequence_declaration_t;

ast_node_t* ast_sequence_declaration_new(ast_node_t *identifier, ast_node_t *assertion_variable_declaration_list, ast_node_t *sequence_expr, ast_node_t *block_end_identifier, ast_node_t *sequence_port_list);

#endif
