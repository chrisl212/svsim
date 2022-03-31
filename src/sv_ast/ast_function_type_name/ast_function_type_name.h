#ifndef AST_FUNCTION_TYPE_NAME_H
#define AST_FUNCTION_TYPE_NAME_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *ps_or_hierarchical_identifier;
    ast_node_t *ps_identifier_tok;
    ast_node_t *function_data_type;
} ast_function_type_name_t;

ast_node_t* ast_function_type_name_new(ast_node_t *ps_or_hierarchical_identifier, ast_node_t *ps_identifier_tok, ast_node_t *function_data_type);

#endif
