#include <stdio.h>
#include "ast_case_keyword.h"

void ast_case_keyword_print(ast_case_keyword_t case_keyword) {
    const char *val;

    switch (case_keyword) {
        case AST_CASE_KEYWORD_CASE: val = "case"; break;
        case AST_CASE_KEYWORD_CASEX: val = "casex"; break;
        case AST_CASE_KEYWORD_CASEZ: val = "casez"; break;
    }

    printf("%s", val);
}
