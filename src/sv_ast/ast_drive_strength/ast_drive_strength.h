#ifndef AST_DRIVE_STRENGTH_H
#define AST_DRIVE_STRENGTH_H

typedef struct _ast_node ast_node_t;

#include "sv_ast/ast_strength0/ast_strength0.h"
#include "sv_ast/ast_strength1/ast_strength1.h"

typedef struct {
    ast_node_t super;
    ast_strength0_t strength0;
    ast_strength1_t strength1;
} ast_drive_strength_t;

ast_node_t* ast_drive_strength_new(ast_strength0_t strength0, ast_strength1_t strength1);

#endif
