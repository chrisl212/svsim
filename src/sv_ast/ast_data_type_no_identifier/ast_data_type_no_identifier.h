#ifndef AST_DATA_TYPE_NO_IDENTIFIER_H
#define AST_DATA_TYPE_NO_IDENTIFIER_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_integer_atom_type/ast_integer_atom_type.h"
#include "sv_ast/ast_signing/ast_signing.h"
#include "sv_ast/ast_virtual_interface_type/ast_virtual_interface_type.h"
#include "sv_ast/ast_integer_vector_type/ast_integer_vector_type.h"
#include "sv_ast/ast_non_integer_type/ast_non_integer_type.h"

typedef struct {
    ast_node_t super;
    ast_node_t *identifier1;
    ast_integer_atom_type_t integer_atom_type;
    ast_node_t *identifier;
    ast_signing_t signing;
    ast_virtual_interface_type_t virtual_interface_type;
    ast_node_t *parameter_value_assignment;
    ast_integer_vector_type_t integer_vector_type;
    ast_non_integer_type_t non_integer_type;
    ast_node_t *identifier0;
    ast_node_t *packed_dimension_list;
} ast_data_type_no_identifier_t;

ast_node_t* ast_data_type_no_identifier_new(ast_node_t *identifier1, ast_integer_atom_type_t integer_atom_type, ast_node_t *identifier, ast_signing_t signing, ast_virtual_interface_type_t virtual_interface_type, ast_node_t *parameter_value_assignment, ast_integer_vector_type_t integer_vector_type, ast_non_integer_type_t non_integer_type, ast_node_t *identifier0, ast_node_t *packed_dimension_list);

#endif
