#ifndef AST_PROCEDURAL_TIMING_CONTROL_STATEMENT_H
#define AST_PROCEDURAL_TIMING_CONTROL_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *statement;
    ast_node_t *procedural_timing_control;
} ast_procedural_timing_control_statement_t;

ast_node_t* ast_procedural_timing_control_statement_new(ast_node_t *statement, ast_node_t *procedural_timing_control);

#endif
