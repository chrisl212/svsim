#include <stdio.h>
#include "ast_assignment_operator.h"

void ast_assignment_operator_print(ast_assignment_operator_t assignment_operator) {
    const char *val;

    switch (assignment_operator) {
        case AST_ASSIGNMENT_OPERATOR_TOK_SRA_EQ: val = "tok_sra_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_EQ: val = "tok_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_PLUS_EQ: val = "tok_plus_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_MOD_EQ: val = "tok_mod_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_SR_EQ: val = "tok_sr_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_AND_EQ: val = "tok_and_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_DIV_EQ: val = "tok_div_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_MUL_EQ: val = "tok_mul_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_OR_EQ: val = "tok_or_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_SLA_EQ: val = "tok_sla_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_SL_EQ: val = "tok_sl_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_XOR_EQ: val = "tok_xor_eq"; break;
        case AST_ASSIGNMENT_OPERATOR_TOK_MINUS_EQ: val = "tok_minus_eq"; break;
    }

    printf("%s", val);
}
