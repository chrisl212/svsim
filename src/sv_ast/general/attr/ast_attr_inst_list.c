#include <stdio.h>
#include "ast_attr_inst_list.h"

void ast_attr_inst_list_print(ast_node_list_t *list) {
    ast_node_list_item_t *node_outer;
    ast_node_list_item_t *node_inner;

    if (!list) {
        return;
    }

    for (node_outer = list->root; node_outer != NULL; node_outer = node_outer->next) {
        ast_node_list_t *inner_list = (ast_node_list_t *)node_outer->node;

        printf("(* ");
        for (node_inner = inner_list->root; node_inner != NULL; node_inner = node_inner->next) {
            if (node_inner != inner_list->root) {
                printf(", ");
            }
            ast_node_print(node_inner->node);
        }
        printf(" *) ");
    }
}

