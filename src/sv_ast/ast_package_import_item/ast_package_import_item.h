#ifndef AST_PACKAGE_IMPORT_ITEM_H
#define AST_PACKAGE_IMPORT_ITEM_H

typedef struct _ast_node ast_node_t;

typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    char       wildcard;
} ast_package_import_item_t;

ast_node_t* ast_package_import_item_new(ast_node_t *identifier, char wildcard);

#endif
