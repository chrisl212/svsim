#ifndef AST_IDENTIFIER_H
#define AST_IDENTIFIER_H

typedef struct _ast_node ast_node_t;

typedef struct {
    ast_node_t super;
    char       *identifier;
} ast_identifier_t;

ast_node_t* ast_identifier_new(char *identifier);

#endif
