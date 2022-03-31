#ifndef AST_ALWAYS_KEYWORD_H
#define AST_ALWAYS_KEYWORD_H

typedef enum {
    AST_ALWAYS_KEYWORD_ALWAYS_COMB,
    AST_ALWAYS_KEYWORD_ALWAYS_FF,
    AST_ALWAYS_KEYWORD_ALWAYS,
    AST_ALWAYS_KEYWORD_ALWAYS_LATCH
} ast_always_keyword_t;

void ast_always_keyword_print(ast_always_keyword_t always_keyword);

#endif
