#ifndef AST_TIMEUNITS_DECL_H
#define AST_TIMEUNITS_DECL_H

#include "sv_ast/ast_node.h"
#include "sv_ast/expr/time_literal/ast_time_literal.h"

typedef struct {
    ast_node_t          super;
    ast_time_literal_t *time_unit;
    ast_time_literal_t *time_precision;
} ast_timeunits_decl_t;

ast_timeunits_decl_t* ast_timeunits_decl_new(ast_time_literal_t *time_unit,
                                             ast_time_literal_t *time_precision);

#endif
