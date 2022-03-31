#!/usr/bin/env python3

import os
import json
from common import *

spec_file = 'spec.json'
yacc_file = '../parser.y'
prod_file = 'prod.json'

def mkdir(path: str) -> None:
    try:
        os.mkdir(path)
    except FileExistsError:
        pass

def gen_prod_file(prods: dict) -> None:
    prod_data = {'ready': 1, 'items': []}

    for prod in prods:
        terminals = set()
        tokens = set()
        lens = []
        for rule in prods[prod]:
            rule = clean_name(rule)
            if rule == '':
                continue

            if rule[0] in [':', '|']:
                rule = rule[2:]
                nonterminals = [r for r in rule.split(' ') if len(r) > 0 and not (r[0] in ["'", '/', '*', '%']) and r.islower()]
                nonterminals = [r.replace('_optional', '') for r in nonterminals if r != 'attribute_instance_list']
                nonterminals_mod = []
                for term in nonterminals:
                    others = [x for x in nonterminals if x == term]
                    if len(others) == 1:
                        nonterminals_mod.append(term)
                    else:
                        for i in range(len(others)):
                            nonterminals_mod.append(f'{term}{i}')
                nonterminals = nonterminals_mod

                terminals.update(nonterminals)
                lens.append(len(nonterminals))
                tokens.update([r for r in rule.split(' ') if len(r) > 0 and not (r[0] in ["'", '/', '*']) and r.isupper()])

        if prod.endswith('_list'):
            typ = 'list'
        elif prod.endswith('_optional'):
            typ = 'optional'
        elif len(tokens) > 0 and len(terminals) == 0:
            typ = 'enum'
        elif all(l <= 1 for l in lens):
            typ = 'pass-through'
        else:
            typ = 'node'

        data = {
            'name': prod,
        }
        data['type'] = typ
        if typ == 'node':
            data['terminals'] = list(terminals)
        elif typ == 'enum':
            data['values'] = list(tokens)

        prod_data['items'].append(data)

    with open(prod_file, 'w') as f:
        f.write(json.dumps(prod_data, indent=4))

def gen_ast(prods: list) -> None:
    ast_dir = '../../../sv_ast'
    mkdir(ast_dir)

    with open('ast_enum_template.h.tmp', 'r') as f:
        ast_enum_template_h = f.read()
    with open('ast_enum_template.c.tmp', 'r') as f:
        ast_enum_template_c = f.read()
    with open('ast_node_template.h.tmp', 'r') as f:
        ast_node_template_h = f.read()
    with open('ast_node_template.c.tmp', 'r') as f:
        ast_node_template_c = f.read()

    ast_h = '#ifndef AST_H\n#define AST_H\n\n#include "ast_node.h"\n#include "ast_node_list.h"\n'
    for prod in prods:
        if not prod['type'] in ['node', 'enum']:
            continue

        prod_dir = os.path.join(ast_dir, f'ast_{prod["name"]}')
        mkdir(prod_dir)

        if prod['type'] == 'node':
            ast_node_h = ast_node_template_h.replace('NODE_NAME_CAPS', prod['name'].upper())
            ast_node_h = ast_node_h.replace('NODE_NAME', prod['name'])
            ast_node_c = ast_node_template_c.replace('NODE_NAME', prod['name'])

            member_str = ''
            new_args = ''
            struct_assign = ''
            struct_free = ''
            struct_print = ''
            enum_includes = ''
            for i, member in enumerate(prod['terminals']):
                member_prod = [p for p in prods if p['name'] == member]
                member_type = member_prod[0]['type'] if len(member_prod) > 0 else 'node'

                if member_type in ['node', 'pass-through', 'optional', 'list']:
                    if len(new_args) > 0:
                        new_args += ', '
                    member_str += f'    ast_node_t *{member};\n'
                    new_args += f'ast_node_t *{member}'
                    struct_print += f'    ast_node_print({prod["name"]}->{member}, indent, indent_incr);\n'
                    struct_free += f'    ast_node_free({prod["name"]}->{member});\n'
                elif member_type == 'enum':
                    if len(new_args) > 0:
                        new_args += ', '
                    member_str += f'    ast_{member}_t {member};\n'
                    new_args += f'ast_{member}_t {member}'
                    struct_print += f'    ast_{member}_print({prod["name"]}->{member});\n'
                    enum_includes += f'#include "sv_ast/ast_{member}/ast_{member}.h"\n'
                struct_assign += f'    {prod["name"]}->{member} = {member};\n'

            ast_node_h = ast_node_h.replace('ENUM_INCLUDES', enum_includes)
            ast_node_h = ast_node_h.replace('STRUCT_MEMBERS', member_str)
            ast_node_h = ast_node_h.replace('NEW_ARGS', new_args)
            ast_node_c = ast_node_c.replace('NEW_ARGS', new_args)
            ast_node_c = ast_node_c.replace('STRUCT_ASSIGN', struct_assign)
            ast_node_c = ast_node_c.replace('STRUCT_PRINT', struct_print)
            ast_node_c = ast_node_c.replace('STRUCT_FREE', struct_free)
            
            ast_node_h_path = os.path.join(prod_dir, f'ast_{prod["name"]}.h')
            ast_node_c_path = os.path.join(prod_dir, f'ast_{prod["name"]}.c')
            with open(ast_node_h_path, 'w') as f:
                f.write(ast_node_h)
            with open(ast_node_c_path, 'w') as f:
                f.write(ast_node_c)
            ast_h += f'#include "ast_{prod["name"]}/ast_{prod["name"]}.h"\n'

        elif prod['type'] == 'enum':
            ast_enum_h = ast_enum_template_h.replace('ENUM_NAME_CAPS', prod['name'].upper())
            ast_enum_h = ast_enum_h.replace('ENUM_NAME', prod['name'])
            ast_enum_c = ast_enum_template_c.replace('ENUM_NAME', prod['name'])

            member_str = ''
            enum_switch = ''
            for i, member in enumerate(prod['values']):
                member_str += f'\n    AST_{prod["name"].upper()}_{member}'
                enum_switch += f'        case AST_{prod["name"].upper()}_{member}: val = "{member.lower()}"; break;\n'
                if i != len(prod['values']) - 1:
                    member_str += ','
                else:
                    member_str += '\n'
            ast_enum_h = ast_enum_h.replace('ENUM_MEMBERS', member_str)
            ast_enum_c = ast_enum_c.replace('ENUM_SWITCH', enum_switch)

            ast_enum_path = os.path.join(prod_dir, f'ast_{prod["name"]}.h')
            with open(ast_enum_path, 'w') as f:
                f.write(ast_enum_h)
            ast_h += f'#include "ast_{prod["name"]}/ast_{prod["name"]}.h"\n'
            
            ast_enum_path = os.path.join(prod_dir, f'ast_{prod["name"]}.c')
            with open(ast_enum_path, 'w') as f:
                f.write(ast_enum_c)
            
    ast_h += '\n#endif'
    with open(os.path.join(ast_dir, 'ast.h'), 'w') as f:
        f.write(ast_h)

if __name__ == '__main__':
    spec = load_spec(spec_file)
    yacc = load_yacc_sections(yacc_file)
    prod = get_productions(yacc[1])

    if not os.path.exists(prod_file):
        gen_prod_file(prod)

    with open(prod_file, 'r') as f:
        prod_data = json.loads(f.read())

    if prod_data['ready'] == 1:
        gen_ast(prod_data['items'])
