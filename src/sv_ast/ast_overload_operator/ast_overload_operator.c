#include <stdio.h>
#include "ast_overload_operator.h"

void ast_overload_operator_print(ast_overload_operator_t overload_operator) {
    const char *val;

    switch (overload_operator) {
        case AST_OVERLOAD_OPERATOR_TOK_PLUS: val = "tok_plus"; break;
        case AST_OVERLOAD_OPERATOR_TOK_INC: val = "tok_inc"; break;
        case AST_OVERLOAD_OPERATOR_TOK_PWR: val = "tok_pwr"; break;
        case AST_OVERLOAD_OPERATOR_TOK_EQ: val = "tok_eq"; break;
        case AST_OVERLOAD_OPERATOR_TOK_LOG_GT: val = "tok_log_gt"; break;
        case AST_OVERLOAD_OPERATOR_TOK_MINUS: val = "tok_minus"; break;
        case AST_OVERLOAD_OPERATOR_TOK_LOG_LT: val = "tok_log_lt"; break;
        case AST_OVERLOAD_OPERATOR_TOK_MUL: val = "tok_mul"; break;
        case AST_OVERLOAD_OPERATOR_TOK_LOG_LEQ: val = "tok_log_leq"; break;
        case AST_OVERLOAD_OPERATOR_TOK_MOD: val = "tok_mod"; break;
        case AST_OVERLOAD_OPERATOR_TOK_LOG_GEQ: val = "tok_log_geq"; break;
        case AST_OVERLOAD_OPERATOR_TOK_LOG_NEQ: val = "tok_log_neq"; break;
        case AST_OVERLOAD_OPERATOR_TOK_DIV: val = "tok_div"; break;
        case AST_OVERLOAD_OPERATOR_TOK_LOG_EQ: val = "tok_log_eq"; break;
        case AST_OVERLOAD_OPERATOR_TOK_DEC: val = "tok_dec"; break;
    }

    printf("%s", val);
}
