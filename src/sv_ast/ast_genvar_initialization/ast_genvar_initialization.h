#ifndef AST_GENVAR_INITIALIZATION_H
#define AST_GENVAR_INITIALIZATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *expression;
} ast_genvar_initialization_t;

ast_node_t* ast_genvar_initialization_new(ast_node_t *identifier, ast_node_t *expression);

#endif
