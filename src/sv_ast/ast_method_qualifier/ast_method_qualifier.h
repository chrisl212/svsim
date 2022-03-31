#ifndef AST_METHOD_QUALIFIER_H
#define AST_METHOD_QUALIFIER_H

typedef enum {
    AST_METHOD_QUALIFIER_PURE,
    AST_METHOD_QUALIFIER_VIRTUAL
} ast_method_qualifier_t;

void ast_method_qualifier_print(ast_method_qualifier_t method_qualifier);

#endif
