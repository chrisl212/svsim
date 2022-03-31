#include <stdio.h>
#include "ast_join_keyword.h"

void ast_join_keyword_print(ast_join_keyword_t join_keyword) {
    const char *val;

    switch (join_keyword) {
        case AST_JOIN_KEYWORD_JOIN_ANY: val = "join_any"; break;
        case AST_JOIN_KEYWORD_JOIN_NONE: val = "join_none"; break;
        case AST_JOIN_KEYWORD_JOIN: val = "join"; break;
    }

    printf("%s", val);
}
