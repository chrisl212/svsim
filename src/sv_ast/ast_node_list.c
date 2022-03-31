#include <stdlib.h>
#include "ast_node_list.h"

static void _ast_node_list_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_node_list_free(ast_node_t *node);
static void _ast_node_list_item_print(ast_node_list_item_t *item, int indent, int indent_incr);
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

static void _ast_node_list_print(ast_node_t *node, int indent, int indent_incr) {
    ast_node_list_t *list = (ast_node_list_t *)node;
    _ast_node_list_item_print(list->first, indent, indent_incr);
}

static void _ast_node_list_free(ast_node_t *node) {
    ast_node_list_t *list = (ast_node_list_t *)node;
    ast_node_t *item;

    if (!node) {
        return;
    }

    _ast_node_list_item_free(list->first);
    free(list);
}

static void _ast_node_list_item_print(ast_node_list_item_t *item, int indent, int indent_incr) {
    if (!item) {
        return;
    }

    ast_node_print(item->node, indent, indent_incr);
    _ast_node_list_item_print(item->next, indent, indent_incr);
}

static void _ast_node_list_item_free(ast_node_list_item_t *item) {
    if (!item) {
        return;
    }

    _ast_node_list_item_free(item->next);
    _ast_node_list_item_free(item);
}
