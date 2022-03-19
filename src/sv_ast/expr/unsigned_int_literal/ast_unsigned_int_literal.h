#ifndef AST_UNSIGNED_INT_LITERAL_H
#define AST_UNSIGNED_INT_LITERAL_H

#include "sv_ast/ast_node.h"

typedef struct {
    ast_node_t   super;
    unsigned int value;
} ast_unsigned_int_literal_t;

ast_unsigned_int_literal_t* ast_unsigned_int_literal_new(unsigned int value);

#endif
