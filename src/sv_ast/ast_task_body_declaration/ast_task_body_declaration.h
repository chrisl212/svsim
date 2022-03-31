#ifndef AST_TASK_BODY_DECLARATION_H
#define AST_TASK_BODY_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *statement_list;
    ast_node_t *tf_port_list;
    ast_node_t *tf_item_declaration_list;
    ast_node_t *ps_or_hierarchical_identifier;
    ast_node_t *block_end_identifier;
    ast_node_t *block_item_declaration_list;
} ast_task_body_declaration_t;

ast_node_t* ast_task_body_declaration_new(ast_node_t *statement_list, ast_node_t *tf_port_list, ast_node_t *tf_item_declaration_list, ast_node_t *ps_or_hierarchical_identifier, ast_node_t *block_end_identifier, ast_node_t *block_item_declaration_list);

#endif
