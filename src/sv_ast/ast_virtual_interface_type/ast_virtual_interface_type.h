#ifndef AST_VIRTUAL_INTERFACE_TYPE_H
#define AST_VIRTUAL_INTERFACE_TYPE_H

typedef enum {
    AST_VIRTUAL_INTERFACE_TYPE_VIRTUAL,
    AST_VIRTUAL_INTERFACE_TYPE_VIRTUAL_INTERFACE
} ast_virtual_interface_type_t;

void ast_virtual_interface_type_print(ast_virtual_interface_type_t virtual_interface_type);

#endif
