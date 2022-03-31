#ifndef AST_TIMEUNITS_DECLARATION_H
#define AST_TIMEUNITS_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *time_literal1;
    ast_node_t *time_literal;
    ast_node_t *time_literal0;
} ast_timeunits_declaration_t;

ast_node_t* ast_timeunits_declaration_new(ast_node_t *time_literal1, ast_node_t *time_literal, ast_node_t *time_literal0);

#endif
