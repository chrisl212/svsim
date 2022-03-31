#include <stdio.h>
#include "ast_module_keyword.h"

void ast_module_keyword_print(ast_module_keyword_t module_keyword) {
    const char *val;

    switch (module_keyword) {
        case AST_MODULE_KEYWORD_MACROMODULE: val = "macromodule"; break;
        case AST_MODULE_KEYWORD_MODULE: val = "module"; break;
    }

    printf("%s", val);
}
