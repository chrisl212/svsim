#ifndef AST_LOCAL_PARAMETER_DECLARATION_H
#define AST_LOCAL_PARAMETER_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *data_type;
    ast_node_t *param_assignment_list;
    ast_node_t *type_assignment_list;
} ast_local_parameter_declaration_t;

ast_node_t* ast_local_parameter_declaration_new(ast_node_t *data_type, ast_node_t *param_assignment_list, ast_node_t *type_assignment_list);

#endif
