#ifndef AST_INTEGER_VECTOR_TYPE_H
#define AST_INTEGER_VECTOR_TYPE_H

typedef enum {
    AST_INTEGER_VECTOR_TYPE_REG,
    AST_INTEGER_VECTOR_TYPE_BIT,
    AST_INTEGER_VECTOR_TYPE_LOGIC
} ast_integer_vector_type_t;

void ast_integer_vector_type_print(ast_integer_vector_type_t integer_vector_type);

#endif
