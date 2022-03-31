#ifndef AST_COVER_PROPERTY_STATEMENT_H
#define AST_COVER_PROPERTY_STATEMENT_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *property_spec;
    ast_node_t *statement;
} ast_cover_property_statement_t;

ast_node_t* ast_cover_property_statement_new(ast_node_t *property_spec, ast_node_t *statement);

#endif
