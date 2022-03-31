#ifndef AST_TF_CALL_H
#define AST_TF_CALL_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_implicit_class_handle/ast_implicit_class_handle.h"

typedef struct {
    ast_node_t super;
    ast_node_t *identifier;
    ast_node_t *ps_or_hierarchical_identifier;
    ast_implicit_class_handle_t implicit_class_handle;
    ast_node_t *argument_list;
} ast_tf_call_t;

ast_node_t* ast_tf_call_new(ast_node_t *identifier, ast_node_t *ps_or_hierarchical_identifier, ast_implicit_class_handle_t implicit_class_handle, ast_node_t *argument_list);

#endif
