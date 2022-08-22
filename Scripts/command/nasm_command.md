# assemble x86_64
`nasm -f elf64 <file_name> -o <object_name>.o`

# link with ld
`ls <object_name> -o <executable_output>`

# assemble i386
`nasm f elf32 <file_name> -o <object_name>.o`

# link i386
`ld -m elf_i386 <object_name>.o -o a32`

