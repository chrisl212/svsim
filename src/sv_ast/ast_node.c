#include <stdlib.h>
#include "ast_node.h"

ast_node_t* ast_node_new(void) {
    ast_node_t *node = calloc(1, sizeof(*node));
    return node;
}

void ast_node_print(ast_node_t *node, int indent, int indent_incr) {
    if (!node) {
        return;
    }

    if (node->print) {
        node->print(node, indent, indent_incr);
    }
}

void ast_node_free(ast_node_t *node) {
    if (!node) {
        return;
    }

    if (node->free) {
        node->free(node);
    }
    free(node);
}
