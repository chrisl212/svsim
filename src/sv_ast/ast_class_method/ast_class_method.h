#ifndef AST_CLASS_METHOD_H
#define AST_CLASS_METHOD_H

typedef struct _ast_node ast_node_t;


typedef struct {
    ast_node_t super;
    ast_node_t *method_prototype;
    ast_node_t *class_method_qualifier_list;
    ast_node_t *task_declaration;
    ast_node_t *function_declaration;
} ast_class_method_t;

ast_node_t* ast_class_method_new(ast_node_t *method_prototype, ast_node_t *class_method_qualifier_list, ast_node_t *task_declaration, ast_node_t *function_declaration);

#endif
