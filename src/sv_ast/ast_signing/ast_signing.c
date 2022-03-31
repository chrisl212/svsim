#include <stdio.h>
#include "ast_signing.h"

void ast_signing_print(ast_signing_t signing) {
    const char *val;

    switch (signing) {
        case AST_SIGNING_UNSIGNED: val = "unsigned"; break;
        case AST_SIGNING_SIGNED: val = "signed"; break;
    }

    printf("%s", val);
}
