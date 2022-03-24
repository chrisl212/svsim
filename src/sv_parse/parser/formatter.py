#!/usr/bin/env python3

import json
import re
from pprint import pprint as pp

spec_file = 'spec.json'
yacc_file = 'parser.y'

def load_spec(fpath: str) -> list:
    with open(fpath, 'r') as f:
        return json.loads(f.read())

def load_yacc_sections(fpath: str) -> list:
    with open(fpath, 'r') as f:
        contents = f.readlines()

    sections = []
    current_section = []
    for line in contents:
        if line.strip() == '%%':
            sections.append(current_section)
            current_section = []
        else:
            current_section.append(line)
    sections.append(current_section)

    return sections

def get_productions(section: list) -> dict:
    rgx = re.compile(r'[A-Za-z_0-9]+$')

    prods = {}
    line = 0
    while line < len(section):
        prod = []
        stripped = section[line].replace('//', '')
        stripped = stripped.strip()

        if rgx.match(stripped) and stripped != 'Uncategorized':
            ident = stripped
            if ident == 'FIXME':
                prod.append(section[line])
                line += 1
                ident = section[line].replace('//', '').strip()

            while section[line].strip() != '':
                prev = section[line-1].replace('//', '').strip()
                if prev != '' and prev[0] in [':', '|']:
                    if section[line].replace('//', '').strip()[0] != '{':
                        if section[line-1].strip().startswith('//'):
                            prod.append('//        { $$ = (ast_node_t *)NULL; }\n')
                        else:
                            prod.append('        { $$ = (ast_node_t *)NULL; }\n')
                prod.append(section[line])
                line += 1

            prods[ident] = prod
        
        line += 1

    return prods

def format_section(spec: list, prods: dict) -> list:
    formatted_section = []

    if spec['title'] != '':
        formatted_section.append('//====================================================================================================\n')
        formatted_section.append(f'// {spec["title"]}\n')
        formatted_section.append('//====================================================================================================\n')
    
    formatted_section.append('\n')

    for item in spec['items']:
        if type(item) == dict:
            formatted_section.extend(format_section(item, prods))
        else:
            if item in prods:
                formatted_section.extend(prods[item])
                prods.pop(item)
                formatted_section.append('\n')

    return formatted_section

def fill_out(spec: dict, not_found: dict) -> None:
    for item in list(spec['items']):
        if type(item) == dict:
            fill_out(item, not_found)
        else:
            if f'{item}_optional' in not_found:
                spec['items'].insert(spec['items'].index(item)+1, f'{item}_optional')
            if f'{item}_list' in not_found:
                spec['items'].insert(spec['items'].index(item)+1, f'{item}_list')

def add_node_types(section: list, prod: dict) -> list:
    existing = []

    prod = dict(prod)
    for line in section:
        if line.startswith('%type'):
            nodes = line.split(' ')[2:]
            for node in [n.strip() for n in nodes]:
                if node in prod:
                    prod.pop(node)

    line = ''
    for i, node in enumerate(prod.keys()):
        if i % 5 == 0:
            section.append(line + '\n')
            line = '%type <ast_node>'
        line += f' {node}'

    return section

if __name__ == '__main__':
    spec = load_spec(spec_file)
    yacc = load_yacc_sections(yacc_file)

    prod = get_productions(yacc[1])

    yacc[0] = add_node_types(yacc[0], prod)

    section = format_section(spec, prod)

    if len(prod) > 0:
        section.append('//====================================================================================================\n')
        section.append(f'// Uncategorized\n')
        section.append('//====================================================================================================\n')
        section.append('\n')
        print('Not found in spec:')
        for item in prod:
            print(item)
            section.extend(prod[item])
            section.append('\n')

    yacc[1] = section

    with open('out.y', 'w') as f:
        f.write('%%\n'.join(''.join(part) for part in yacc))
