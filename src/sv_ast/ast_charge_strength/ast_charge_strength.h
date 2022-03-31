#ifndef AST_CHARGE_STRENGTH_H
#define AST_CHARGE_STRENGTH_H

typedef enum {
    AST_CHARGE_STRENGTH_LARGE,
    AST_CHARGE_STRENGTH_SMALL,
    AST_CHARGE_STRENGTH_MEDIUM
} ast_charge_strength_t;

void ast_charge_strength_print(ast_charge_strength_t charge_strength);

#endif
