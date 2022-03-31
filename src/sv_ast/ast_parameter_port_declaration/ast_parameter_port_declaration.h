#ifndef AST_PARAMETER_PORT_DECLARATION_H
#define AST_PARAMETER_PORT_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *dont;
    ast_node_t *multiple;
    ast_node_t *parameter_declaration;
    ast_node_t *support;
    ast_node_t *type_assignment;
    ast_node_t *data_type_or_param;
    ast_node_t *param_assignment;
    ast_node_t *local_parameter_declaration;
    ast_node_t *decls;
} ast_parameter_port_declaration_t;

ast_node_t* ast_parameter_port_declaration_new(ast_node_t *dont, ast_node_t *multiple, ast_node_t *parameter_declaration, ast_node_t *support, ast_node_t *type_assignment, ast_node_t *data_type_or_param, ast_node_t *param_assignment, ast_node_t *local_parameter_declaration, ast_node_t *decls);

#endif
