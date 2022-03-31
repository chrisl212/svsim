#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_task_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_task_declaration_free(ast_node_t *node);

ast_node_t* ast_task_declaration_new(ast_node_t *task_body_declaration, ast_lifetime_t lifetime) {
    ast_task_declaration_t *task_declaration = calloc(1, sizeof(*task_declaration));

    task_declaration->super.print = _ast_task_declaration_print;
    task_declaration->super.free = _ast_task_declaration_free;

    task_declaration->task_body_declaration = task_body_declaration;
    task_declaration->lifetime = lifetime;

    return (ast_node_t *)task_declaration;
}

static void _ast_task_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_task_declaration_t *task_declaration = (ast_task_declaration_t *)node;

    ast_node_print(task_declaration->task_body_declaration, indent, indent_incr);
    ast_lifetime_print(task_declaration->lifetime);
}

static void _ast_task_declaration_free(ast_node_t *node) {
    ast_task_declaration_t *task_declaration = (ast_task_declaration_t *)node;

    ast_node_free(task_declaration->task_body_declaration);
}
