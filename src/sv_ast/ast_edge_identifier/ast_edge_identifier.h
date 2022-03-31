#ifndef AST_EDGE_IDENTIFIER_H
#define AST_EDGE_IDENTIFIER_H

typedef enum {
    AST_EDGE_IDENTIFIER_NEGEDGE,
    AST_EDGE_IDENTIFIER_EDGE,
    AST_EDGE_IDENTIFIER_POSEDGE
} ast_edge_identifier_t;

void ast_edge_identifier_print(ast_edge_identifier_t edge_identifier);

#endif
