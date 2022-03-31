#ifndef AST_CLASS_SCOPE_H
#define AST_CLASS_SCOPE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *parameter_value_assignment;
    ast_node_t *ps_identifier_tok;
} ast_class_scope_t;

ast_node_t* ast_class_scope_new(ast_node_t *identifier, ast_node_t *parameter_value_assignment, ast_node_t *ps_identifier_tok);

#endif
