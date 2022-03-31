#ifndef AST_PROGRAM_DECLARATION_H
#define AST_PROGRAM_DECLARATION_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *timeunits_declaration;
    ast_node_t *non_port_program_item_list;
    ast_node_t *program_ansi_header;
    ast_node_t *program_item_list;
    ast_node_t *block_end_identifier;
    ast_node_t *program_nonansi_header;
} ast_program_declaration_t;

ast_node_t* ast_program_declaration_new(ast_node_t *timeunits_declaration, ast_node_t *non_port_program_item_list, ast_node_t *program_ansi_header, ast_node_t *program_item_list, ast_node_t *block_end_identifier, ast_node_t *program_nonansi_header);

#endif
