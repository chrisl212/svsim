#ifndef AST_NAME_OF_INSTANCE_H
#define AST_NAME_OF_INSTANCE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *unpacked_dimension_list;
} ast_name_of_instance_t;

ast_node_t* ast_name_of_instance_new(ast_node_t *identifier, ast_node_t *unpacked_dimension_list);

#endif
