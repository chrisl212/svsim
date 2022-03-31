#include <stdio.h>
#include "ast_always_keyword.h"

void ast_always_keyword_print(ast_always_keyword_t always_keyword) {
    const char *val;

    switch (always_keyword) {
        case AST_ALWAYS_KEYWORD_ALWAYS_COMB: val = "always_comb"; break;
        case AST_ALWAYS_KEYWORD_ALWAYS_FF: val = "always_ff"; break;
        case AST_ALWAYS_KEYWORD_ALWAYS: val = "always"; break;
        case AST_ALWAYS_KEYWORD_ALWAYS_LATCH: val = "always_latch"; break;
    }

    printf("%s", val);
}
