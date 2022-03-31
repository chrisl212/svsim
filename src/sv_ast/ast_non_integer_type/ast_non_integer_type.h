#ifndef AST_NON_INTEGER_TYPE_H
#define AST_NON_INTEGER_TYPE_H

typedef enum {
    AST_NON_INTEGER_TYPE_SHORTREAL,
    AST_NON_INTEGER_TYPE_REAL,
    AST_NON_INTEGER_TYPE_REALTIME
} ast_non_integer_type_t;

void ast_non_integer_type_print(ast_non_integer_type_t non_integer_type);

#endif
