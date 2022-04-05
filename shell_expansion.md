# Shell Expansion

Expansion is performed on the command line after it has been split into `tokens`.

## Brace expansion
expand Brace to a list of items

> Simple list
```shell
bash$ echo a{b,c,d}e
> ade ave ade
```

> List with step, only in BASH 4+ VERSION
```shell
bash$ echo a{2..8..1}e
> a2e a3e a4e a5e a6e a7e a8e
```
where, in this exemple, 2 is the begin, 8 the end, and 1 the step

> simple renaming of the folder foo to foo_bar
`bash$ mv foo{,_bar}`
> this create the list `foo` with `foo_bar` wich correspond for mv

## Tilde expansion

If a word begins with an unquoted tilde character ‘~’, all characters up to the
first unquoted slash are considered a tilde-prefix.

> If none of the character in the tilde-prefix are quoted, the characters in<br>
> the tilde-prefix following the tilde-prefix following the tilde are treated as<br>
> a possible login name.

```shell
# Display root HOME
bash$ echo ~root

# Display USER HOME
bash$ echo ~USER
```
> If the tilde-prefix is null, the tilde is replaced with the value of the HOME

```shell
# Display the variable $HOME
bash$ echo ~
```

> If the tilde-prefix is '+' the value of the shell variable PWD replaces the<br>
> tilde-prefix. If the prefix is '-' the value of the shell variable OLDPWD, if <br>
> is set, is substitued.

```shell
# PWD
bash$ echo ~+

# OLDPWD
bash$ echo ~-
```

## Shell parameter expansion

The '$' character introduces parameter expansion, command substitution, or
arithmetic expansion. The parameter name or symbol to be expanded may be
enclosed in braces, which are optional but serve to protect the variable to be
expanded from characters immediately following it which could be interpreted as
part of the name.

### Logic
`${parameter:-word}`
> if `parameter` is unset or null, the expansion of `word` is substitued,<br>
> otherwise, the value of parameter is substitued

```shell
bash$ export foo=fee

bash$ echo ${faa:-foo}
> foo

bash$ echo ${foo:-faa}
> fee

bash$ echo ${faa:-${foo}}
> fee
```

> like logics are possible with this ...

### Substring

```shell
# Cut string with the size
${parameter:offset}
${parameter:offset:length}

bash$ export alpha="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

bash$ echo ${alpha:7}
> HIJKLMNOPQRSTUVWXYZ
bash$ echo ${alpha:7:0}
>
bash$ echo ${alpha:7:2}
> HI
bash$ echo ${alpha:7:-2}
> HIJKLMNOPQRSTUVWX
# here the ' ' is important, as otherwise it would be :- of the comparison expan
bash$ echo ${alpha: -7}
> TUVWXYZ
bash$ echo ${alpha: -7:0}
>
bash$ echo ${alpha: -7:2}
> TU
bash$ echo ${alpha: -7:-2}
> TUVWX

# length of a string
bash$ export text="test"
bash$ echo ${#text}
> 4

# remove from the begin
${parameter#word}
${parameter##word}

bash$ export filename="test.txt"
bash$ echo ${filename#test}
> txt

# remove from the end
${parameter%word}
${parameter%%word}

bash$ export filename="test.txt"
bash$ echo ${filename%.txt}
> test

# Search and substitute
${parameter/pattern/string}

# replace the first occurence
bash$ export date="2022-01-01 00:00:00"
bash$ echo ${date/00/23}
> 2022-01-01 23:00:00

# replace all the occurence
bash$ echo ${date//00/23}
> 2022-01-01 23:23:23

# replace if match at the begin
bash$ echo ${date/#01/02}
> 2022-01-01 00:00:00
bash$ echo ${date/#2022/2023}
> 2023-01-01 00:00:00

# replace if match at the end
bash$ echo ${date/%01/02}
> 2022-01-01 00:00:00
bash$ echo ${date/%00/01}
> 2022-01-01 00:00:01

# if no string given, remove the pattern
bash$ echo ${date/00}
> 2022-01-01 :00:00

# case modifier (only working on BASH :) )
${parameter^pattern}
${parameter^^pattern}
${parameter,pattern}
${parameter,,pattern}

bash$ export name="jhon DoE"
# convert first character to lowercase
bash$ echo ${name,}
> jhon DoE

# convert all character to lowercase
bash$ echo ${name,,}
> jhon doe

# convert first character to uppercase
bash$ echo ${name^}
> Jhon DoE

# convert all character to uppercase
bash$ echo ${name^^}
> JHON DOE

# Working with bash and zsh
bash$ export name="jhon DoE"

# convert first character to lowercase
bash$ echo ${(u)name}
> jhon DoE

# convert all character to lowercase
bash$ echo ${(U)name}
> jhon doe

# convert all character to uppercase
bash$ echo ${(L)name}
> JHON DOE
```

## Command substitution
two ways:
- `$(command param1 ..)`<br>
or
- ``` `command param1 ..` ```

```shell
# faster command subsitution than cat
# orignal
bash$ $(cat file)
# better way
bash$ $(< file)
```
## arithmetic expansion

you can do math

```shell
bash$ echo $((1 + 1))
> 2
bash$ export n1=1
bash$ echo $((1 + 1 + ${n1}))
> 3
```
more about arithmetics in bash [here](https://www.gnu.org/software/bash/manual/html_node/Shell-Arithmetic.html)
