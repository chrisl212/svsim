#ifndef AST_SIGNING_H
#define AST_SIGNING_H

typedef enum {
    AST_SIGNING_UNSIGNED,
    AST_SIGNING_SIGNED
} ast_signing_t;

void ast_signing_print(ast_signing_t signing);

#endif
