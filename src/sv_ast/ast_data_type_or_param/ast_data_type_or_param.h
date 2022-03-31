#ifndef AST_DATA_TYPE_OR_PARAM_H
#define AST_DATA_TYPE_OR_PARAM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *data_type;
} ast_data_type_or_param_t;

ast_node_t* ast_data_type_or_param_new(ast_node_t *data_type);

#endif
