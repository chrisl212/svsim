#ifndef AST_MODULE_DECLARATION_H
#define AST_MODULE_DECLARATION_H

typedef struct _ast_node ast_node_t;

typedef struct {
    ast_node_t super;
    ast_node_t *module_item_list;
    ast_node_t *non_port_module_item_list;
    ast_node_t *module_ansi_header;
    ast_node_t *module_nonansi_header;
    ast_node_t *block_end_identifier;
    char       _extern;
} ast_module_declaration_t;

ast_node_t* ast_module_declaration_new(ast_node_t *module_item_list, ast_node_t *non_port_module_item_list, ast_node_t *module_ansi_header, ast_node_t *module_nonansi_header, ast_node_t *block_end_identifier, char _extern);

#endif
