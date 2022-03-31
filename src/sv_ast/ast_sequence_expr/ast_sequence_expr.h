#ifndef AST_SEQUENCE_EXPR_H
#define AST_SEQUENCE_EXPR_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *cycle_delay_range;
    ast_node_t *sequence_expr1;
    ast_node_t *covered;
    ast_node_t *sequence_instance;
    ast_node_t *expression;
    ast_node_t *sequence_abbrev;
    ast_node_t *sequence_match_item_list;
    ast_node_t *boolean_abbrev;
    ast_node_t *expression_or_dist;
    ast_node_t *under;
    ast_node_t *sequence_expr0;
    ast_node_t *clocking_event;
} ast_sequence_expr_t;

ast_node_t* ast_sequence_expr_new(ast_node_t *cycle_delay_range, ast_node_t *sequence_expr1, ast_node_t *covered, ast_node_t *sequence_instance, ast_node_t *expression, ast_node_t *sequence_abbrev, ast_node_t *sequence_match_item_list, ast_node_t *boolean_abbrev, ast_node_t *expression_or_dist, ast_node_t *under, ast_node_t *sequence_expr0, ast_node_t *clocking_event);

#endif
