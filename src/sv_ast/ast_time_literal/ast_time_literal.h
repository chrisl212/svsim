#ifndef AST_TIME_LITERAL_H
#define AST_TIME_LITERAL_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_time_unit/ast_time_unit.h"

typedef struct {
    ast_node_t super;
    ast_node_t *unsigned_number;
    ast_time_unit_t time_unit;
    ast_node_t *fixed_point_number;
} ast_time_literal_t;

ast_node_t* ast_time_literal_new(ast_node_t *unsigned_number, ast_time_unit_t time_unit, ast_node_t *fixed_point_number);

#endif
