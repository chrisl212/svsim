#ifndef AST_CLASS_PROPERTY_H
#define AST_CLASS_PROPERTY_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *verify;
    ast_node_t *modifiers;
    ast_node_t *data_declaration;
    ast_node_t *correct;
    ast_node_t *only;
} ast_class_property_t;

ast_node_t* ast_class_property_new(ast_node_t *verify, ast_node_t *modifiers, ast_node_t *data_declaration, ast_node_t *correct, ast_node_t *only);

#endif
