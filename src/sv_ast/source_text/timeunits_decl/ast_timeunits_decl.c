#include <stdlib.h>
#include <stdio.h>
#include "ast_timeunits_decl.h"

static void _ast_timeunits_decl_print(ast_node_t *node);
static void _ast_timeunits_decl_free(ast_node_t *node);

ast_timeunits_decl_t* ast_timeunits_decl_new(ast_time_literal_t *time_unit,
                                             ast_time_literal_t *time_precision) {

    ast_timeunits_decl_t *decl  = calloc(1, sizeof(*decl));

    decl->super.print           = _ast_timeunits_decl_print;
    decl->super.free            = _ast_timeunits_decl_free;

    decl->time_unit             = time_unit;
    decl->time_precision        = time_precision;

    return decl;
}

static void _ast_timeunits_decl_print(ast_node_t *node) {
    ast_timeunits_decl_t *decl = (ast_timeunits_decl_t *)node;

    printf("\n  timeunit ");
    ast_node_print((ast_node_t *)decl->time_unit);
    printf(" / ");
    ast_node_print((ast_node_t *)decl->time_precision);
    printf(";\n");
}

static void _ast_timeunits_decl_free(ast_node_t *node) {
    ast_timeunits_decl_t *decl = (ast_timeunits_decl_t *)node;

    ast_node_free((ast_node_t *)decl->time_unit);
    ast_node_free((ast_node_t *)decl->time_precision);
}
