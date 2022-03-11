#include <stdlib.h>
#include "ast_node_list.h"

static void _ast_node_list_print(ast_node_t *node);
static void _ast_node_list_free(ast_node_t *node);
static void _ast_node_list_item_print(ast_node_list_item_t *item);
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
    item->next = list->root;
    list->root = item;
    list->len++;
}

static void _ast_node_list_print(ast_node_t *node) {
    ast_node_list_t *list = (ast_node_list_t *)node;
    _ast_node_list_item_print(list->root);
}

static void _ast_node_list_free(ast_node_t *node) {
    ast_node_list_t *list = (ast_node_list_t *)node;
    ast_node_t *item;

    if (!node) {
        return;
    }

    _ast_node_list_item_free(list->root);
    free(list);
}

static void _ast_node_list_item_print(ast_node_list_item_t *item) {
    if (!item) {
        return;
    }

    _ast_node_list_item_print(item->next);
    ast_node_print(item->node);
}

static void _ast_node_list_item_free(ast_node_list_item_t *item) {
    if (!item) {
        return;
    }

    _ast_node_list_item_free(item->next);
    _ast_node_list_item_free(item);
}
