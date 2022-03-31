#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_module_common_item_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_module_common_item_free(ast_node_t *node);

ast_node_t* ast_module_common_item_new(ast_node_t *final_construct, ast_always_keyword_t always_keyword, ast_node_t *statement, ast_node_t *assertion_item, ast_node_t *bind_directive, ast_node_t *loop_generate_construct, ast_node_t *module_or_generate_item_declaration, ast_node_t *conditional_generate_construct, ast_node_t *continuous_assign, ast_node_t *initial_construct, ast_node_t *generic_instantiation, ast_node_t *net_alias) {
    ast_module_common_item_t *module_common_item = calloc(1, sizeof(*module_common_item));

    module_common_item->super.print = _ast_module_common_item_print;
    module_common_item->super.free = _ast_module_common_item_free;

    module_common_item->final_construct = final_construct;
    module_common_item->always_keyword = always_keyword;
    module_common_item->statement = statement;
    module_common_item->assertion_item = assertion_item;
    module_common_item->bind_directive = bind_directive;
    module_common_item->loop_generate_construct = loop_generate_construct;
    module_common_item->module_or_generate_item_declaration = module_or_generate_item_declaration;
    module_common_item->conditional_generate_construct = conditional_generate_construct;
    module_common_item->continuous_assign = continuous_assign;
    module_common_item->initial_construct = initial_construct;
    module_common_item->generic_instantiation = generic_instantiation;
    module_common_item->net_alias = net_alias;

    return (ast_node_t *)module_common_item;
}

static void _ast_module_common_item_print(ast_node_t *node, int indent, int indent_incr) {
    ast_module_common_item_t *module_common_item = (ast_module_common_item_t *)node;

    ast_node_print(module_common_item->final_construct, indent, indent_incr);
    ast_always_keyword_print(module_common_item->always_keyword);
    ast_node_print(module_common_item->statement, indent, indent_incr);
    ast_node_print(module_common_item->assertion_item, indent, indent_incr);
    ast_node_print(module_common_item->bind_directive, indent, indent_incr);
    ast_node_print(module_common_item->loop_generate_construct, indent, indent_incr);
    ast_node_print(module_common_item->module_or_generate_item_declaration, indent, indent_incr);
    ast_node_print(module_common_item->conditional_generate_construct, indent, indent_incr);
    ast_node_print(module_common_item->continuous_assign, indent, indent_incr);
    ast_node_print(module_common_item->initial_construct, indent, indent_incr);
    ast_node_print(module_common_item->generic_instantiation, indent, indent_incr);
    ast_node_print(module_common_item->net_alias, indent, indent_incr);
}

static void _ast_module_common_item_free(ast_node_t *node) {
    ast_module_common_item_t *module_common_item = (ast_module_common_item_t *)node;

    ast_node_free(module_common_item->final_construct);
    ast_node_free(module_common_item->statement);
    ast_node_free(module_common_item->assertion_item);
    ast_node_free(module_common_item->bind_directive);
    ast_node_free(module_common_item->loop_generate_construct);
    ast_node_free(module_common_item->module_or_generate_item_declaration);
    ast_node_free(module_common_item->conditional_generate_construct);
    ast_node_free(module_common_item->continuous_assign);
    ast_node_free(module_common_item->initial_construct);
    ast_node_free(module_common_item->generic_instantiation);
    ast_node_free(module_common_item->net_alias);
}
