#include <stdlib.h>
#include <stdio.h>
#include "ast_string_literal.h"

static void _ast_string_literal_print(ast_node_t *node);
static void _ast_string_literal_free(ast_node_t *node);

ast_string_literal_t* ast_string_literal_new(char *value) {
    ast_string_literal_t *lit = calloc(1, sizeof(*lit));

    lit->super.print = _ast_string_literal_print;
    lit->super.free = _ast_string_literal_free;
    lit->value = value;

    return lit;
}

static void _ast_string_literal_print(ast_node_t *node) {
    ast_string_literal_t *lit = (ast_string_literal_t *)node;

    printf("%s", lit->value);
}

static void _ast_string_literal_free(ast_node_t *node) {
    ast_string_literal_t *lit = (ast_string_literal_t *)node;

    free(lit->value);
}

