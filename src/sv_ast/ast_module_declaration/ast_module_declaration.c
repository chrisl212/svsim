#include <stdio.h>
#include <stdlib.h>
#include "sv_ast/ast.h"

static void _ast_module_declaration_print(ast_node_t *node, int indent, int indent_incr);
static void _ast_module_declaration_free(ast_node_t *node);

ast_node_t* ast_module_declaration_new(ast_node_t *module_item_list, ast_node_t *non_port_module_item_list, ast_node_t *module_ansi_header, ast_node_t *module_nonansi_header, ast_node_t *block_end_identifier, char _extern) {
    ast_module_declaration_t *module_declaration = calloc(1, sizeof(*module_declaration));

    module_declaration->super.print = _ast_module_declaration_print;
    module_declaration->super.free = _ast_module_declaration_free;

    module_declaration->module_item_list = module_item_list;
    module_declaration->non_port_module_item_list = non_port_module_item_list;
    module_declaration->module_ansi_header = module_ansi_header;
    module_declaration->module_nonansi_header = module_nonansi_header;
    module_declaration->block_end_identifier = block_end_identifier;
    module_declaration->_extern = _extern;

    return (ast_node_t *)module_declaration;
}

static void _ast_module_declaration_print(ast_node_t *node, int indent, int indent_incr) {
    ast_module_declaration_t *module_declaration = (ast_module_declaration_t *)node;

    if (module_declaration->_extern) {
        printf("extern ");
    }
    ast_node_print(module_declaration->module_ansi_header, indent, indent_incr);
    ast_node_print(module_declaration->module_nonansi_header, indent, indent_incr);
    printf("\n%s", node->next_indent);
    ast_node_list_print((ast_node_list_t *)module_declaration->module_item_list, indent + indent_incr, indent_incr, "\n");
    ast_node_list_print((ast_node_list_t *)module_declaration->non_port_module_item_list, indent + indent_incr, indent_incr, "\n");
    if (!module_declaration->_extern) {
        printf("\nendmodule");
        if (module_declaration->block_end_identifier) {
            printf(" : ");
            ast_node_print(module_declaration->block_end_identifier, indent, indent_incr);
        }
    }
}

static void _ast_module_declaration_free(ast_node_t *node) {
    ast_module_declaration_t *module_declaration = (ast_module_declaration_t *)node;

    ast_node_free(module_declaration->module_item_list);
    ast_node_free(module_declaration->non_port_module_item_list);
    ast_node_free(module_declaration->module_ansi_header);
    ast_node_free(module_declaration->module_nonansi_header);
    ast_node_free(module_declaration->block_end_identifier);
}
