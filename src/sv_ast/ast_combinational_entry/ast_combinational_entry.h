#ifndef AST_COMBINATIONAL_ENTRY_H
#define AST_COMBINATIONAL_ENTRY_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *output_symbol;
    ast_node_t *level_input_list;
} ast_combinational_entry_t;

ast_node_t* ast_combinational_entry_new(ast_node_t *output_symbol, ast_node_t *level_input_list);

#endif
