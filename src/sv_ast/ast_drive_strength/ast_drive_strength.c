#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_drive_strength_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_drive_strength_free(ast_node_t *node);

ast_node_t* ast_drive_strength_new(ast_strength0_t strength0, ast_strength1_t strength1) {
    ast_drive_strength_t *drive_strength = calloc(1, sizeof(*drive_strength));

    drive_strength->super.print = _ast_drive_strength_print;
    drive_strength->super.free = _ast_drive_strength_free;

    drive_strength->strength0 = strength0;
    drive_strength->strength1 = strength1;

    return (ast_node_t *)drive_strength;
}

static void _ast_drive_strength_print(ast_node_t *node, int indent, int indent_incr) {
    ast_drive_strength_t *drive_strength = (ast_drive_strength_t *)node;

    ast_strength0_print(drive_strength->strength0);
    ast_strength1_print(drive_strength->strength1);
}

static void _ast_drive_strength_free(ast_node_t *node) {
    ast_drive_strength_t *drive_strength = (ast_drive_strength_t *)node;

}
