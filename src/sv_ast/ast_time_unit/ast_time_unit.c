#include <stdio.h>
#include "ast_time_unit.h"

void ast_time_unit_print(ast_time_unit_t time_unit) {
    const char *val;

    switch (time_unit) {
        case AST_TIME_UNIT_US: val = "us"; break;
        case AST_TIME_UNIT_FS: val = "fs"; break;
        case AST_TIME_UNIT_S: val = "s"; break;
        case AST_TIME_UNIT_PS: val = "ps"; break;
        case AST_TIME_UNIT_MS: val = "ms"; break;
        case AST_TIME_UNIT_NS: val = "ns"; break;
    }

    printf("%s", val);
}
