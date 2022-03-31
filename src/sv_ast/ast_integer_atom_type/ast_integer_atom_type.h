#ifndef AST_INTEGER_ATOM_TYPE_H
#define AST_INTEGER_ATOM_TYPE_H

typedef enum {
    AST_INTEGER_ATOM_TYPE_TIME,
    AST_INTEGER_ATOM_TYPE_LONGINT,
    AST_INTEGER_ATOM_TYPE_BYTE,
    AST_INTEGER_ATOM_TYPE_SHORTINT,
    AST_INTEGER_ATOM_TYPE_INTEGER,
    AST_INTEGER_ATOM_TYPE_INT
} ast_integer_atom_type_t;

void ast_integer_atom_type_print(ast_integer_atom_type_t integer_atom_type);

#endif
