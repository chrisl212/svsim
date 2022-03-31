#ifndef AST_TIME_UNIT_H
#define AST_TIME_UNIT_H

typedef enum {
    AST_TIME_UNIT_US,
    AST_TIME_UNIT_FS,
    AST_TIME_UNIT_S,
    AST_TIME_UNIT_PS,
    AST_TIME_UNIT_MS,
    AST_TIME_UNIT_NS
} ast_time_unit_t;

void ast_time_unit_print(ast_time_unit_t time_unit);

#endif
