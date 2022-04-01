#ifndef AST_PACKAGE_IMPORT_DECLARATION_H
#define AST_PACKAGE_IMPORT_DECLARATION_H

typedef struct _ast_node ast_node_t;

typedef struct {
    ast_node_t super;
    ast_node_t *package_import_item_list;
} ast_package_import_declaration_t;

ast_node_t* ast_package_import_declaration_new(ast_node_t *package_import_item_list);

#endif