#include <stdlib.h>
#include <string.h>
#include "sv_int.h"

sv_int_t* sv_int_create(char *s) {
    sv_int_t *sv_int = calloc(1, sizeof(*sv_int));

    return sv_int;
}
