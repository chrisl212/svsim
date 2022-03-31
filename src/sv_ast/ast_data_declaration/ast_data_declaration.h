#ifndef AST_DATA_DECLARATION_H
#define AST_DATA_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *variable_decl_assignment_list;
    ast_node_t *method_variable_qualifier_list;
    ast_node_t *variable_qualifier_list;
    ast_node_t *data_type;
    ast_node_t *type_declaration;
    ast_node_t *package_import_declaration;
} ast_data_declaration_t;

ast_node_t* ast_data_declaration_new(ast_node_t *variable_decl_assignment_list, ast_node_t *method_variable_qualifier_list, ast_node_t *variable_qualifier_list, ast_node_t *data_type, ast_node_t *type_declaration, ast_node_t *package_import_declaration);

#endif
