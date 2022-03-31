#ifndef AST_ASSERTION_VARIABLE_DECLARATION_H
#define AST_ASSERTION_VARIABLE_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *data_type;
    ast_node_t *variable_decl_assignment_list;
} ast_assertion_variable_declaration_t;

ast_node_t* ast_assertion_variable_declaration_new(ast_node_t *data_type, ast_node_t *variable_decl_assignment_list);

#endif
