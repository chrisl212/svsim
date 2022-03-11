#include <stdio.h>
#include "ast_lifetime.h"

void ast_lifetime_print(ast_lifetime_t lifetime) {
    switch (lifetime) {
        case AST_LIFETIME_STATIC:    printf("static ");
                                     break;
        case AST_LIFETIME_AUTOMATIC: printf("automatic ");
                                     break;
    }
}
