#include <stdlib.h>
#include <stdio.h>
#include "ast_unsigned_int_literal.h"

static void _ast_unsigned_int_literal_print(ast_node_t *node);
// static void _ast_unsigned_int_literal_free(ast_node_t *node);

ast_unsigned_int_literal_t* ast_unsigned_int_literal_new(unsigned int value) {
    ast_unsigned_int_literal_t *lit = calloc(1, sizeof(*lit));

    lit->super.print = _ast_unsigned_int_literal_print;
    // lit->super.free = _ast_unsigned_int_literal_free;
    lit->value = value;

    return lit;
}

static void _ast_unsigned_int_literal_print(ast_node_t *node) {
    ast_unsigned_int_literal_t *lit = (ast_unsigned_int_literal_t *)node;

    printf("%d", lit->value);
}

// static void _ast_unsigned_int_literal_free(ast_node_t *node) {
//     ast_unsigned_int_literal_t *lit = (ast_unsigned_int_literal_t *)node;
// }

