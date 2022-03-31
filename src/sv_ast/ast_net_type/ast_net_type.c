#include <stdio.h>
#include "ast_net_type.h"

void ast_net_type_print(ast_net_type_t net_type) {
    const char *val;

    switch (net_type) {
        case AST_NET_TYPE_TRIOR: val = "trior"; break;
        case AST_NET_TYPE_TRI1: val = "tri1"; break;
        case AST_NET_TYPE_TRI0: val = "tri0"; break;
        case AST_NET_TYPE_SUPPLY1: val = "supply1"; break;
        case AST_NET_TYPE_WOR: val = "wor"; break;
        case AST_NET_TYPE_TRI: val = "tri"; break;
        case AST_NET_TYPE_TRIAND: val = "triand"; break;
        case AST_NET_TYPE_TRIREG: val = "trireg"; break;
        case AST_NET_TYPE_WIRE: val = "wire"; break;
        case AST_NET_TYPE_SUPPLY0: val = "supply0"; break;
        case AST_NET_TYPE_WAND: val = "wand"; break;
        case AST_NET_TYPE_UWIRE: val = "uwire"; break;
    }

    printf("%s", val);
}
