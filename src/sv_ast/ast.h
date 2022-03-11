#ifndef AST_H
#define AST_H

typedef char* ast_identifier_t;
void ast_identifier_print(ast_identifier_t ident);

#include "ast_node.h"
#include "ast_node_list.h"
#include "source_text/source_text.h"
#include "decl/decl.h"
#include "expr/expr.h"
#include "general/general.h"

#endif
