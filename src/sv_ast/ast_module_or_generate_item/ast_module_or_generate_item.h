#ifndef AST_MODULE_OR_GENERATE_ITEM_H
#define AST_MODULE_OR_GENERATE_ITEM_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *checker_or_generate_item_declaration;
    ast_node_t *covered;
    ast_node_t *udp_instantiation;
    ast_node_t *in;
    ast_node_t *module_common_item;
    ast_node_t *gate_instantiation;
    ast_node_t *below;
    ast_node_t *parameter_override;
} ast_module_or_generate_item_t;

ast_node_t* ast_module_or_generate_item_new(ast_node_t *checker_or_generate_item_declaration, ast_node_t *covered, ast_node_t *udp_instantiation, ast_node_t *in, ast_node_t *module_common_item, ast_node_t *gate_instantiation, ast_node_t *below, ast_node_t *parameter_override);

#endif
