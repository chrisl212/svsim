#ifndef AST_IMPLICIT_CLASS_HANDLE_H
#define AST_IMPLICIT_CLASS_HANDLE_H

typedef enum {
    AST_IMPLICIT_CLASS_HANDLE_THIS,
    AST_IMPLICIT_CLASS_HANDLE_SUPER,
    AST_IMPLICIT_CLASS_HANDLE_FIXME
} ast_implicit_class_handle_t;

void ast_implicit_class_handle_print(ast_implicit_class_handle_t implicit_class_handle);

#endif
