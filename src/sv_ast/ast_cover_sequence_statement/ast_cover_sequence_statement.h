#ifndef AST_COVER_SEQUENCE_STATEMENT_H
#define AST_COVER_SEQUENCE_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *statement;
    ast_node_t *expression_or_dist;
    ast_node_t *sequence_expr;
    ast_node_t *clocking_event;
} ast_cover_sequence_statement_t;

ast_node_t* ast_cover_sequence_statement_new(ast_node_t *statement, ast_node_t *expression_or_dist, ast_node_t *sequence_expr, ast_node_t *clocking_event);

#endif
