#ifndef AST_INTERFACE_CLASS_DECLARATION_H
#define AST_INTERFACE_CLASS_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *ps_or_normal_identifier;
    ast_node_t *interface_class_type_list;
    ast_node_t *interface_class_parameters;
    ast_node_t *block_end_identifier;
    ast_node_t *interface_class_item_list;
} ast_interface_class_declaration_t;

ast_node_t* ast_interface_class_declaration_new(ast_node_t *ps_or_normal_identifier, ast_node_t *interface_class_type_list, ast_node_t *interface_class_parameters, ast_node_t *block_end_identifier, ast_node_t *interface_class_item_list);

#endif
