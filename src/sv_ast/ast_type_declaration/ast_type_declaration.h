#ifndef AST_TYPE_DECLARATION_H
#define AST_TYPE_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *data_type;
} ast_type_declaration_t;

ast_node_t* ast_type_declaration_new(ast_node_t *identifier, ast_node_t *data_type);

#endif
