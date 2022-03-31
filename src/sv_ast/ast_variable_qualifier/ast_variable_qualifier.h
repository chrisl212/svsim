#ifndef AST_VARIABLE_QUALIFIER_H
#define AST_VARIABLE_QUALIFIER_H

typedef enum {
    AST_VARIABLE_QUALIFIER_RAND,
    AST_VARIABLE_QUALIFIER_CONST,
    AST_VARIABLE_QUALIFIER_VAR,
    AST_VARIABLE_QUALIFIER_RANDC
} ast_variable_qualifier_t;

void ast_variable_qualifier_print(ast_variable_qualifier_t variable_qualifier);

#endif
