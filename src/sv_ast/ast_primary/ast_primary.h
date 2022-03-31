#ifndef AST_PRIMARY_H
#define AST_PRIMARY_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *let_expression;
    ast_node_t *ps_identifier;
    ast_node_t *streaming_concatenation;
    ast_node_t *sequence_method_call;
    ast_node_t *casting_type;
    ast_node_t *expression;
    ast_node_t *primary_literal;
    ast_node_t *part_select_range;
    ast_node_t *multiple_concatenation;
    ast_node_t *hierarchical_identifier;
    ast_node_t *assignment_pattern_expression;
    ast_node_t *mintypmax_expression;
    ast_node_t *concatenation;
    ast_node_t *subroutine_call;
} ast_primary_t;

ast_node_t* ast_primary_new(ast_node_t *let_expression, ast_node_t *ps_identifier, ast_node_t *streaming_concatenation, ast_node_t *sequence_method_call, ast_node_t *casting_type, ast_node_t *expression, ast_node_t *primary_literal, ast_node_t *part_select_range, ast_node_t *multiple_concatenation, ast_node_t *hierarchical_identifier, ast_node_t *assignment_pattern_expression, ast_node_t *mintypmax_expression, ast_node_t *concatenation, ast_node_t *subroutine_call);

#endif
