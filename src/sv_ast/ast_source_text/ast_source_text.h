#ifndef AST_SOURCE_TEXT_H
#define AST_SOURCE_TEXT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *timeunits_declaration;
    ast_node_t *description_list;
} ast_source_text_t;

ast_node_t* ast_source_text_new(ast_node_t *timeunits_declaration, ast_node_t *description_list);

#endif
