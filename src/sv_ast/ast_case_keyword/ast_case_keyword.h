#ifndef AST_CASE_KEYWORD_H
#define AST_CASE_KEYWORD_H

typedef enum {
    AST_CASE_KEYWORD_CASE,
    AST_CASE_KEYWORD_CASEX,
    AST_CASE_KEYWORD_CASEZ
} ast_case_keyword_t;

void ast_case_keyword_print(ast_case_keyword_t case_keyword);

#endif
