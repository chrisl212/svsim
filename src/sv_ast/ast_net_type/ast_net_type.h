#ifndef AST_NET_TYPE_H
#define AST_NET_TYPE_H

typedef enum {
    AST_NET_TYPE_TRIOR,
    AST_NET_TYPE_TRI1,
    AST_NET_TYPE_TRI0,
    AST_NET_TYPE_SUPPLY1,
    AST_NET_TYPE_WOR,
    AST_NET_TYPE_TRI,
    AST_NET_TYPE_TRIAND,
    AST_NET_TYPE_TRIREG,
    AST_NET_TYPE_WIRE,
    AST_NET_TYPE_SUPPLY0,
    AST_NET_TYPE_WAND,
    AST_NET_TYPE_UWIRE
} ast_net_type_t;

void ast_net_type_print(ast_net_type_t net_type);

#endif
