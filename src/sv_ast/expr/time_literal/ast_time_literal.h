#ifndef AST_TIME_LITERAL_H
#define AST_TIME_LITERAL_H

#include "sv_ast/ast_node.h"

typedef enum {
    AST_TIME_UNIT_S,
    AST_TIME_UNIT_MS,
    AST_TIME_UNIT_US,
    AST_TIME_UNIT_NS,
    AST_TIME_UNIT_PS,
    AST_TIME_UNIT_FS
} ast_time_unit_t;

typedef struct {
    ast_node_t          super;
    double              value;
    ast_time_unit_t     unit;
} ast_time_literal_t;

ast_time_literal_t* ast_time_literal_new(double value, ast_time_unit_t unit);

#endif
