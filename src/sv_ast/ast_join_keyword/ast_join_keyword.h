#ifndef AST_JOIN_KEYWORD_H
#define AST_JOIN_KEYWORD_H

typedef enum {
    AST_JOIN_KEYWORD_JOIN_ANY,
    AST_JOIN_KEYWORD_JOIN_NONE,
    AST_JOIN_KEYWORD_JOIN
} ast_join_keyword_t;

void ast_join_keyword_print(ast_join_keyword_t join_keyword);

#endif
