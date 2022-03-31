#ifndef AST_MODULE_KEYWORD_H
#define AST_MODULE_KEYWORD_H

typedef enum {
    AST_MODULE_KEYWORD_MACROMODULE,
    AST_MODULE_KEYWORD_MODULE
} ast_module_keyword_t;

void ast_module_keyword_print(ast_module_keyword_t module_keyword);

#endif
