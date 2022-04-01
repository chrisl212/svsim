#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast_node_list.h"

static void _ast_node_list_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_node_list_free(ast_node_t *node);
static void _ast_node_list_item_print(ast_node_list_item_t *item, int indent, int indent_incr, const char *sep);
static void _ast_node_list_item_free(ast_node_list_item_t *item);

ast_node_list_t* ast_node_list_new(void) {
    ast_node_list_t *list = calloc(1, sizeof(*list));

    list->super.print = _ast_node_list_print;
    list->super.free = _ast_node_list_free;

    return list;
}

void ast_node_list_append(ast_node_list_t *list, ast_node_t *node) {
    ast_node_list_item_t *item = calloc(1, sizeof(*item));
    item->node = node;
    list->len++;

    if (!list->first && !list->last) {
        list->first = list->last = item;
    } else {
        list->last->next = item;
        list->last = item;
    }
}

void ast_node_list_print(ast_node_list_t *list, int indent, int indent_incr, const char *sep) {
    if (!list) {
        return;
    }
    _ast_node_list_item_print(list->first, indent, indent_incr, sep);
}

static void _ast_node_list_print(ast_node_t *node, int indent, int indent_incr) {
    ast_node_list_t *list = (ast_node_list_t *)node;
    ast_node_list_print(list, indent, indent_incr, " ");
}

static void _ast_node_list_free(ast_node_t *node) {
    ast_node_list_t *list = (ast_node_list_t *)node;
    ast_node_t *item;

    if (!node) {
        return;
    }

    _ast_node_list_item_free(list->first);
}

static void _ast_node_list_item_print(ast_node_list_item_t *item, int indent, int indent_incr, const char *sep) {
    int len, idx;
    char *indent_str;

    if (!item) {
        return;
    }

    ast_node_print(item->node, indent, indent_incr);
    if (item->next) {
        indent_str = ast_node_gen_indent(indent);
        for (idx = 0; idx < strlen(sep); idx++) {
            putchar(sep[idx]);
            if (sep[idx] == '\n') {
                printf("%s", indent_str);
            }
        }
        free(indent_str);
    }
    _ast_node_list_item_print(item->next, indent, indent_incr, sep);
}

static void _ast_node_list_item_free(ast_node_list_item_t *item) {
    if (!item) {
        return;
    }

    _ast_node_list_item_free(item->next);
    ast_node_free(item->node);
    free(item);
}
