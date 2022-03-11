#ifndef AST_STRING_LITERAL_H
#define AST_STRING_LITERAL_H

#include "sv_ast/ast_node.h"

typedef struct {
    ast_node_t super;
    char       *value;
} ast_string_literal_t;

ast_string_literal_t* ast_string_literal_new(char *value);

#endif
