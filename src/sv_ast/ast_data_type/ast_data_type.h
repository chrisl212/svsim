#ifndef AST_DATA_TYPE_H
#define AST_DATA_TYPE_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *packed_dimension_list;
    ast_node_t *ps_identifier;
    ast_node_t *cases;
    ast_node_t *identifier;
    ast_node_t *hierarchical_identifier;
    ast_node_t *data_type_no_identifier;
    ast_node_t *parameter_value_assignment;
    ast_node_t *select;
    ast_node_t *only;
    ast_node_t *valid;
} ast_data_type_t;

ast_node_t* ast_data_type_new(ast_node_t *packed_dimension_list, ast_node_t *ps_identifier, ast_node_t *cases, ast_node_t *identifier, ast_node_t *hierarchical_identifier, ast_node_t *data_type_no_identifier, ast_node_t *parameter_value_assignment, ast_node_t *select, ast_node_t *only, ast_node_t *valid);

#endif
