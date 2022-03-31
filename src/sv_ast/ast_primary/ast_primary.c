#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_primary_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_primary_free(ast_node_t *node);

ast_node_t* ast_primary_new(ast_node_t *let_expression, ast_node_t *ps_identifier, ast_node_t *streaming_concatenation, ast_node_t *sequence_method_call, ast_node_t *casting_type, ast_node_t *expression, ast_node_t *primary_literal, ast_node_t *part_select_range, ast_node_t *multiple_concatenation, ast_node_t *hierarchical_identifier, ast_node_t *assignment_pattern_expression, ast_node_t *mintypmax_expression, ast_node_t *concatenation, ast_node_t *subroutine_call) {
    ast_primary_t *primary = calloc(1, sizeof(*primary));

    primary->super.print = _ast_primary_print;
    primary->super.free = _ast_primary_free;

    primary->let_expression = let_expression;
    primary->ps_identifier = ps_identifier;
    primary->streaming_concatenation = streaming_concatenation;
    primary->sequence_method_call = sequence_method_call;
    primary->casting_type = casting_type;
    primary->expression = expression;
    primary->primary_literal = primary_literal;
    primary->part_select_range = part_select_range;
    primary->multiple_concatenation = multiple_concatenation;
    primary->hierarchical_identifier = hierarchical_identifier;
    primary->assignment_pattern_expression = assignment_pattern_expression;
    primary->mintypmax_expression = mintypmax_expression;
    primary->concatenation = concatenation;
    primary->subroutine_call = subroutine_call;

    return (ast_node_t *)primary;
}

static void _ast_primary_print(ast_node_t *node, int indent, int indent_incr) {
    ast_primary_t *primary = (ast_primary_t *)node;

    ast_node_print(primary->let_expression, indent, indent_incr);
    ast_node_print(primary->ps_identifier, indent, indent_incr);
    ast_node_print(primary->streaming_concatenation, indent, indent_incr);
    ast_node_print(primary->sequence_method_call, indent, indent_incr);
    ast_node_print(primary->casting_type, indent, indent_incr);
    ast_node_print(primary->expression, indent, indent_incr);
    ast_node_print(primary->primary_literal, indent, indent_incr);
    ast_node_print(primary->part_select_range, indent, indent_incr);
    ast_node_print(primary->multiple_concatenation, indent, indent_incr);
    ast_node_print(primary->hierarchical_identifier, indent, indent_incr);
    ast_node_print(primary->assignment_pattern_expression, indent, indent_incr);
    ast_node_print(primary->mintypmax_expression, indent, indent_incr);
    ast_node_print(primary->concatenation, indent, indent_incr);
    ast_node_print(primary->subroutine_call, indent, indent_incr);
}

static void _ast_primary_free(ast_node_t *node) {
    ast_primary_t *primary = (ast_primary_t *)node;

    ast_node_free(primary->let_expression);
    ast_node_free(primary->ps_identifier);
    ast_node_free(primary->streaming_concatenation);
    ast_node_free(primary->sequence_method_call);
    ast_node_free(primary->casting_type);
    ast_node_free(primary->expression);
    ast_node_free(primary->primary_literal);
    ast_node_free(primary->part_select_range);
    ast_node_free(primary->multiple_concatenation);
    ast_node_free(primary->hierarchical_identifier);
    ast_node_free(primary->assignment_pattern_expression);
    ast_node_free(primary->mintypmax_expression);
    ast_node_free(primary->concatenation);
    ast_node_free(primary->subroutine_call);
}
