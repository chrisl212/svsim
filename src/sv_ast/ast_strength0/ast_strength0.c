#include <stdio.h>
#include "ast_strength0.h"

void ast_strength0_print(ast_strength0_t strength0) {
    const char *val;

    switch (strength0) {
        case AST_STRENGTH0_WEAK0: val = "weak0"; break;
        case AST_STRENGTH0_PULL0: val = "pull0"; break;
        case AST_STRENGTH0_SUPPLY0: val = "supply0"; break;
        case AST_STRENGTH0_STRONG0: val = "strong0"; break;
    }

    printf("%s", val);
}
