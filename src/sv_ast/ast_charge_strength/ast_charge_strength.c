#include <stdio.h>
#include "ast_charge_strength.h"

void ast_charge_strength_print(ast_charge_strength_t charge_strength) {
    const char *val;

    switch (charge_strength) {
        case AST_CHARGE_STRENGTH_LARGE: val = "large"; break;
        case AST_CHARGE_STRENGTH_SMALL: val = "small"; break;
        case AST_CHARGE_STRENGTH_MEDIUM: val = "medium"; break;
    }

    printf("%s", val);
}
