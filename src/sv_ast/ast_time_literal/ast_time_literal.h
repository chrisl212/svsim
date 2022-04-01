#ifndef AST_TIME_LITERAL_H
#define AST_TIME_LITERAL_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_time_unit/ast_time_unit.h"

typedef struct {
    ast_node_t super;
    double literal;
    ast_time_unit_t time_unit;
} ast_time_literal_t;

ast_node_t* ast_time_literal_new(double literal, ast_time_unit_t time_unit);

#endif
