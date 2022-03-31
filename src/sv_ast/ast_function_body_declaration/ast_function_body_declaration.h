#ifndef AST_FUNCTION_BODY_DECLARATION_H
#define AST_FUNCTION_BODY_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *statement_list;
    ast_node_t *tf_port_list;
    ast_node_t *tf_item_declaration_list;
    ast_node_t *function_type_name;
    ast_node_t *block_item_declaration_list;
    ast_node_t *function_block_end_identifier;
} ast_function_body_declaration_t;

ast_node_t* ast_function_body_declaration_new(ast_node_t *statement_list, ast_node_t *tf_port_list, ast_node_t *tf_item_declaration_list, ast_node_t *function_type_name, ast_node_t *block_item_declaration_list, ast_node_t *function_block_end_identifier);

#endif
