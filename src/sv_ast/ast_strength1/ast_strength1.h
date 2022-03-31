#ifndef AST_STRENGTH1_H
#define AST_STRENGTH1_H

typedef enum {
    AST_STRENGTH1_PULL1,
    AST_STRENGTH1_STRONG1,
    AST_STRENGTH1_WEAK1,
    AST_STRENGTH1_SUPPLY1
} ast_strength1_t;

void ast_strength1_print(ast_strength1_t strength1);

#endif
