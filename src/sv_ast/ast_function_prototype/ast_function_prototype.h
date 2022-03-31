#ifndef AST_FUNCTION_PROTOTYPE_H
#define AST_FUNCTION_PROTOTYPE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *function_type_name;
    ast_node_t *tf_port_list;
} ast_function_prototype_t;

ast_node_t* ast_function_prototype_new(ast_node_t *function_type_name, ast_node_t *tf_port_list);

#endif
