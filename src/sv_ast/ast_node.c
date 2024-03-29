#include <stdlib.h>
#include "ast_node.h"

ast_node_t* ast_node_new(void) {
    ast_node_t *node = calloc(1, sizeof(*node));
    return node;
}

char* ast_node_gen_indent(int indent) {
    char *indent_str;
    int idx;

    indent_str = calloc(indent+1, sizeof(*indent_str));
    for (idx = 0; idx < indent; idx++) {
        indent_str[idx] = ' ';
    }
    return indent_str;
}

void ast_node_print(ast_node_t *node, int indent, int indent_incr) {
    if (!node) {
        return;
    }

    node->indent = ast_node_gen_indent(indent);
    node->next_indent = ast_node_gen_indent(indent + indent_incr);

    if (node->print) {
        node->print(node, indent, indent_incr);
    }

    free(node->indent);
    free(node->next_indent);
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
