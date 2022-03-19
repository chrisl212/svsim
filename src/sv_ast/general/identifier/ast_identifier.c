#include <stdlib.h>
#include <stdio.h>
#include "ast_identifier.h"

static void _ast_identifier_print(ast_node_t *node);
static void _ast_identifier_free(ast_node_t *node);

ast_identifier_t* ast_identifier_new(char *identifier) {
    ast_identifier_t *ident = calloc(1, sizeof(*ident));

    ident->super.print      = _ast_identifier_print;
    ident->super.free       = _ast_identifier_free;

    ident->identifier       = identifier;

    return ident;
}

static void _ast_identifier_print(ast_node_t *node) {
    ast_identifier_t *ident = (ast_identifier_t *)node;

    printf("%s", ident->identifier);
}

static void _ast_identifier_free(ast_node_t *node) {
    ast_identifier_t *ident = (ast_identifier_t *)node;

    free(ident->identifier);
}

