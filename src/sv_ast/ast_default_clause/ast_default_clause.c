#include <stdio.h>
#include "ast_default_clause.h"

void ast_default_clause_print(ast_default_clause_t default_clause) {
    const char *val;

    switch (default_clause) {
        case AST_DEFAULT_CLAUSE_DEFAULT: val = "default"; break;
    }

    printf("%s", val);
}
