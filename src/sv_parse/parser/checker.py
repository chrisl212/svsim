#!/usr/bin/env python3

def get_observed(line):
    line   = line.strip().split(' ')
    tokens = set()
    sym    = set()
    operators = set()
    for t in line:
        if len(t) == 0 or 'FIXME' in t or '//' in t:
            continue
        if t[0] == "'" and len(t) > 1 and not t[1].isalnum():
            operators.add(t[1])
        elif t.upper() == t:
            tokens.add(t)
        else:
            sym.add(t)

    return tokens, sym, operators

if __name__ == '__main__':
    with open('parser.y') as f:
        lines = f.readlines()

    observed_tokens = set()
    defined_tokens  = set()
    observed_sym    = set()
    defined_sym     = set()
    operators       = set()

    for line in lines:
        if ':' in line:
            lhs = line.split(':')[0].strip()
            rhs = line.split(':')[1]
            defined_sym.add(lhs)
            tokens, sym, ops = get_observed(rhs)
            observed_tokens.update(tokens)
            observed_sym.update(sym)
            operators.update(ops)
        elif len(line.strip()) > 0 and line.strip()[0] == '|':
            rhs = line.strip()[1:]
            tokens, sym, ops = get_observed(rhs)
            observed_tokens.update(tokens)
            observed_sym.update(sym)
            operators.update(ops)
        elif '%token' in line:
            ts = line.split(' ')[1:]
            for t in ts:
                t = t.strip()
                if len(t) == 0 or 'FIXME' in t:
                    continue
                defined_tokens.add(t)

    needed_tokens = list(observed_tokens - defined_tokens)
    s = '%token'
    for i, t in enumerate(needed_tokens):
        s += ' ' + t
        if len(s) > 40 or i == len(needed_tokens) - 1:
     #       print(s)
            s = '%token'

    for sym in list(observed_sym - defined_sym):
        print(sym)
    #for op in operators:
    #    print(f'"{op}"                  ' + '{ ' + f'return \'{op}\';' + ' }')
