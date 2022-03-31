#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_case_statement_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_case_statement_free(ast_node_t *node);

ast_node_t* ast_case_statement_new(ast_node_t *case_inside_item_list, ast_node_t *case_pattern_item_list, ast_node_t *expression, ast_node_t *unique_priority, ast_case_keyword_t case_keyword, ast_node_t *case_item_list) {
    ast_case_statement_t *case_statement = calloc(1, sizeof(*case_statement));

    case_statement->super.print = _ast_case_statement_print;
    case_statement->super.free = _ast_case_statement_free;

    case_statement->case_inside_item_list = case_inside_item_list;
    case_statement->case_pattern_item_list = case_pattern_item_list;
    case_statement->expression = expression;
    case_statement->unique_priority = unique_priority;
    case_statement->case_keyword = case_keyword;
    case_statement->case_item_list = case_item_list;

    return (ast_node_t *)case_statement;
}

static void _ast_case_statement_print(ast_node_t *node, int indent, int indent_incr) {
    ast_case_statement_t *case_statement = (ast_case_statement_t *)node;

    ast_node_print(case_statement->case_inside_item_list, indent, indent_incr);
    ast_node_print(case_statement->case_pattern_item_list, indent, indent_incr);
    ast_node_print(case_statement->expression, indent, indent_incr);
    ast_node_print(case_statement->unique_priority, indent, indent_incr);
    ast_case_keyword_print(case_statement->case_keyword);
    ast_node_print(case_statement->case_item_list, indent, indent_incr);
}

static void _ast_case_statement_free(ast_node_t *node) {
    ast_case_statement_t *case_statement = (ast_case_statement_t *)node;

    ast_node_free(case_statement->case_inside_item_list);
    ast_node_free(case_statement->case_pattern_item_list);
    ast_node_free(case_statement->expression);
    ast_node_free(case_statement->unique_priority);
    ast_node_free(case_statement->case_item_list);
}
