#!/usr/bin/python
from __future__ import print_function
import sys
import os
import json

def get_tokens(_line):
    tokens = _line.split()
    result = dict()
    result['filename'] = tokens.pop()
    result['compiler'] = tokens.pop(0)
    result['paths'] = list()
    result['compile_flags'] = list()
    for token in tokens:
        if token.startswith('-D'):
            result['compile_flags'].append(token)
        if token.startswith('-I'):
            result['compile_flags'].append(token)
            result['paths'].append(token)
    return result


def get_included_headers(filespec):
    files = list()
    assert (isinstance(filespec, dict))
    command = filespec['compiler']
    for path in filespec['paths']:
        command += ' {0}'.format(path)
    command += ' -M {0}'.format(filespec['filename'])
    p = os.popen(command)
    for l in p.readlines():
        if ':' in l:
            continue
        parts = l.split()
        files.append(parts[0])
    return files


func = """\n
def FlagsForFile(filename, **kwargs):
    result = dict()
    result['flags'] = flags
    result['include_files_relative_to_dir'] = \'{0}\'
    return result
""".format(os.getcwd())


def build_tags():
    ctags_command = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -e -L {0}'.format('sources.list')
    os.system(ctags_command)

    
def write_ycmd_config(flags):
    with open('.ycm_extra_conf.py', 'w') as f:
        print('import ycm_core\n\n', file=f)
        print('flags = [', file=f)
        last_entry = flags.pop()
        for entry in flags:
            print('    \'{0}\','.format(entry), file=f)
        print('    \'{0}\']'.format(last_entry), file=f)
        print(func, file=f)
        

def get_substitutions():
    substitutions = dict()
    try:
        subst_file = open('.pathsubst', 'r')
    except:
        print('WARNING: .pathsubst not found! Paths from build system will not be substituted.')
        return substitutions 
    for entry in subst_file.readlines():
        parts = entry.rstrip().split(',')
        if(len(parts)) != 2:
            print("skipping bad line {0}".format(entry))
        else:
            print('replace: {0} with {1}'.format(parts[0], parts[1]))
            substitutions[parts[0]] = parts[1]
    return substitutions


if __name__ == '__main__':
    if (len(sys.argv) != 2):
        sys.exit("Usage: mktags <build_log>")
    try:
        build_log = open(sys.argv[1], 'r')
    except:
        sys.exit("Unable to open {0}".format(sys.argv[1]))
    lines = build_log.readlines()
    files = set()
    flags = set()

    compile_commands = list()

    if os.path.isfile('./compile_commands.json'):
        with open('compile_commands.json', 'r') as previous_data:
            commands = json.load(previous_data)
            compile_commands.extend(commands)
            for old_entry in commands:
                files.add(old_entry['file'])
    
    source_types = ['.c', '.h', '.cpp', '.hpp']
    subst = get_substitutions()
    for line in lines:
        if ' -c ' in line:
            for tag in subst.keys():
                line = line.replace(tag, subst[tag])
            tokens = get_tokens(line)
            junk, ext = os.path.splitext(tokens['filename'])
            if ext not in source_types:
                continue
            if tokens['filename'] in files:
                continue
            arguments = dict()
            arguments['directory'] = os.getcwd()
            arguments['arguments'] = line.split()
            arguments['file'] = tokens['filename']
            cur_file_dir_path = os.path.dirname(tokens['filename'])
            arguments['arguments'].append('-I' + cur_file_dir_path)
            tokens['paths'].append('-I' + cur_file_dir_path)
            compile_commands.append(arguments)
            for entry in tokens['compile_flags']:
                flags.add(entry)
            files.add(tokens['filename'])
            for header in get_included_headers(tokens):
                files.add(header)
    with open('cscope.files', 'w') as f:
        for entry in files:
            print(entry, file=f)
    with open('compile_commands.json', 'w') as f:
        print(json.dumps(compile_commands, indent=4), file=f)
#   build_tags()
    write_ycmd_config(flags)
    os.system('rc -J .')
    os.system('cscope -b')
