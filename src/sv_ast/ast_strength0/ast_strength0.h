#ifndef AST_STRENGTH0_H
#define AST_STRENGTH0_H

typedef enum {
    AST_STRENGTH0_WEAK0,
    AST_STRENGTH0_PULL0,
    AST_STRENGTH0_SUPPLY0,
    AST_STRENGTH0_STRONG0
} ast_strength0_t;

void ast_strength0_print(ast_strength0_t strength0);

#endif
