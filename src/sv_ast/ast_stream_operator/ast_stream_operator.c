#include <stdio.h>
#include "ast_stream_operator.h"

void ast_stream_operator_print(ast_stream_operator_t stream_operator) {
    const char *val;

    switch (stream_operator) {
        case AST_STREAM_OPERATOR_TOK_BIT_SL: val = "tok_bit_sl"; break;
        case AST_STREAM_OPERATOR_TOK_BIT_SR: val = "tok_bit_sr"; break;
    }

    printf("%s", val);
}
