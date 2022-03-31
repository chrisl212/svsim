#ifndef AST_PROPERTY_DECLARATION_H
#define AST_PROPERTY_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *property_port_list;
    ast_node_t *property_spec;
    ast_node_t *assertion_variable_declaration_list;
    ast_node_t *block_end_identifier;
} ast_property_declaration_t;

ast_node_t* ast_property_declaration_new(ast_node_t *identifier, ast_node_t *property_port_list, ast_node_t *property_spec, ast_node_t *assertion_variable_declaration_list, ast_node_t *block_end_identifier);

#endif
