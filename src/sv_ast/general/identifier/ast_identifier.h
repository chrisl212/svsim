#ifndef AST_IDENTIFIER_H
#define AST_IDENTIFIER_H

#include "sv_ast/ast_node.h"

typedef struct {
    ast_node_t super;
    char *     identifier;
} ast_identifier_t;

ast_identifier_t* ast_identifier_new(char *identifier);

#endif
