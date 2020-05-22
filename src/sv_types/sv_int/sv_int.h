#ifndef SV_INT_H
#define SV_INT_H

typedef struct {
    int base;
} sv_int_t;

sv_int_t* sv_int_create(char *s);

#endif

