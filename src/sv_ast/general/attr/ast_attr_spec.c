#include <stdlib.h>
#include <stdio.h>
#include "ast_attr_spec.h"

static void _ast_attr_spec_print(ast_node_t *node);
static void _ast_attr_spec_free(ast_node_t *node);

ast_attr_spec_t* ast_attr_spec_new(ast_identifier_t *identifier, ast_expr_t *expr) {
    ast_attr_spec_t *attr       = calloc(1, sizeof(*attr));

    attr->super.print           = _ast_attr_spec_print;
    attr->super.free            = _ast_attr_spec_free;

    attr->identifier            = identifier;
    attr->expr                  = expr;

    return attr;
}

static void _ast_attr_spec_print(ast_node_t *node) {
    ast_attr_spec_t *attr = (ast_attr_spec_t *)node;

    ast_node_print((ast_node_t *)attr->identifier);
    if (attr->expr) {
        printf(" = ");
        ast_node_print((ast_node_t *)attr->expr);
    }
}

static void _ast_attr_spec_free(ast_node_t *node) {
    ast_attr_spec_t *attr = (ast_attr_spec_t *)node;

    ast_node_free((ast_node_t *)attr->identifier);
    ast_node_free((ast_node_t *)attr->expr);
}

