import json
import re

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

def clean_name(name: str) -> str:
    return name.replace('//', '').strip()

def get_productions(section: list) -> dict:
    rgx = re.compile(r'[A-Za-z_0-9]+$')

    prods = {}
    line = 0
    while line < len(section):
        prod = []
        stripped = clean_name(section[line])

        if rgx.match(stripped) and stripped != 'Uncategorized':
            ident = stripped
            if ident == 'FIXME':
                prod.append(section[line])
                line += 1
                ident = clean_name(section[line])

            while section[line].strip() != '':
                prev = clean_name(section[line-1])
                if prev != '' and prev[0] in [':', '|']:
                    if clean_name(section[line])[0] != '{':
                        if section[line-1].strip().startswith('//'):
                            prod.append('//        { $$ = (ast_node_t *)NULL; }\n')
                        else:
                            prod.append('        { $$ = (ast_node_t *)NULL; }\n')
                prod.append(section[line])
                line += 1

            prods[ident] = prod
        
        line += 1

    return prods
