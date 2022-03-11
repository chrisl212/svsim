#ifndef AST_LIFETIME_H
#define AST_LIFETIME_H

typedef enum {
    AST_LIFETIME_STATIC,
    AST_LIFETIME_AUTOMATIC
} ast_lifetime_t;

void ast_lifetime_print(ast_lifetime_t lifetime);

#endif
